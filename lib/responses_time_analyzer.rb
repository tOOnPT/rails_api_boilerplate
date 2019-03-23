# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize

###
# Usage example (rails console):
# > require "./lib/responses_time_analyzer.rb"
# > analyzer = ResponsesTimeAnalyzer.new(top: 5, tests_log: false)
# > analyzer.top_worst_response_times
###

class ResponsesTimeAnalyzer
  TESTLOG = "./log/response_times_tests.log".freeze
  LOG = "./log/response_times.log".freeze

  attr_reader :top, :test_log

  def initialize(top: 3, tests_log: false)
    @top = top
    @tests_log = tests_log
  end

  def top_best_response_times
    result = response_times
    return result unless result.is_a? Array
    result.last(top)
  end

  def top_worst_response_times
    result = response_times
    return result unless result.is_a? Array
    result.take(top)
  end

  def html_generation
    result = response_times
    HtmlWriter.save_it(result) if result.is_a? Array
  end

  private

  def response_times
    File.readlines(log_file).
      # forget about first line
      drop(1).
      # split fields into an array
      map { |l| l.split(" | ") }.
      # group lines by controller action
      group_by { |l| l[0] }.
      # get the 3 worst times for each controller action,
      # sorted from worst to best
      map { |k, lines| [k, lines.sort_by { |line| 1 / line[2].split[1].to_f }[0..(@top - 1)]] }.
      # sort controller actions from worst response time to best
      sort_by { |_, lines| 1 / lines[0][2].split[1].to_f }
  rescue Errno::ENOENT => exception
    exception.message
  end

  def log_file
    @test_log ? TESTLOG : LOG
  end
end

###
# Save analyzer results to html file
###
class HtmlWriter
  HTMLFILE = "./coverage/responses_time_analyzer.html".freeze

  def self.save_it(data)
    html_code = [
      "<!doctype html>",
      "<html lang='en'>",
      "<head>",
      "<!-- Required meta tags -->",
      "<meta charset='utf-8'>",
      "<meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>",
      "<!-- Bootstrap CSS -->",
      "<link rel='stylesheet'",
      "href='https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css'",
      "integrity='sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm'",
      "crossorigin='anonymous'>",
      "<title>Hello, world!</title>",
      "</head>",
      "<body>",
      "<h1>Worst endpoint/times</h1>",
      "<div class='table-responsive'>",
      "<table class='table table-hover table-sm'>",
      "<caption>List of endpoints - top 3 worst response times</caption>",
      "<thead>",
      "<tr>",
      "<th scope='col'>Action</th>",
      "<td scope='col'>Status</td>",
      "<td scope='col'>Time</td>",
      "<td scope='col'>DB</td>",
      "<td scope='col'>View</td>",
      "</tr>",
      "</thead>",
      "<tbody>"
    ]

    data.map { |action_data| action_data.last }.first.each do |action_data|
      html_code << "<tr>"
      html_code << "<th scope='row'>#{table_value(action_data[0])}</th>"
      html_code << "<td scope='row'>#{table_value(action_data[1])}</td>"
      html_code << "<td scope='row'>#{table_value(action_data[2])}</td>"
      html_code << "<td scope='row'>#{table_value(action_data[3])}</td>"
      html_code << "<td scope='row'>#{table_value(action_data[4])}</td>"
      html_code << "</tr>"
    end

    ["</table>", "</div>", "</body>", "</html>"].each { |line| html_code << line }

    File.write(HTMLFILE, html_code.join(" "))
  end

  def self.table_value(value)
    value.length > 0 ? value : " ------- "
  end

  private_class_method :table_value
end

# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
