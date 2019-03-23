# create a custom logger that logs to a separate file
logfile = if Rails.env.test?
            "#{Rails.root}/log/response_times_tests.log"
          else
            "#{Rails.root}/log/response_times.log"
          end

event_logger = ::Logger.new(logfile)
event_logger.formatter = proc { |_severity, _datetime, _progname, msg| "#{msg}\n" }

###
# Subscribe to the 'process_action.action_controller' event
# https://api.rubyonrails.org/classes/ActiveSupport/Notifications.html
###
ActiveSupport::Notifications.subscribe(
  'process_action.action_controller'
) do |_, started, finished, _, stats|
  request_time = (finished - started) * 1000
  controller = stats[:controller][0..-11].underscore
  action = "#{stats[:method]} #{controller}##{stats[:action]}.#{stats[:format]}"
  event_logger.info "#{action} | "\
                    "#{stats[:status]} | "\
                    "#{request_time} | "\
                    "#{stats[:db_runtime]} | "\
                    "#{stats[:format]}: #{stats[:view_runtime]}"
end
