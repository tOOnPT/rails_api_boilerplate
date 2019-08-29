require "spec_helper"

describe ResponsesTimeAnalyzer do
  subject(:analyzer) { described_class.new(tests_log: true) }

  let(:test_endpoint) { "GET healthcheck#show.json" }
  let(:default_top) { 3 }

  context "with the top and log file defined" do
    before { log_file_path("response_times_tests.log") }

    it "returns the top_best_response_times" do
      results = analyzer.top_best_response_times
      endpoint_results = results.first
      endpoint_results_name = endpoint_results.first
      expect(endpoint_results_name).to eq(test_endpoint)
      endpoint_results_data = endpoint_results.last
      expect(endpoint_results_data.count).to eq(default_top)
    end

    it "returns the top_worst_response_times" do
      results = analyzer.top_worst_response_times
      endpoint_results = results.first
      endpoint_results_name = endpoint_results.first
      expect(endpoint_results_name).to eq(test_endpoint)
      endpoint_results_data = endpoint_results.last
      expect(endpoint_results_data.count).to eq(default_top)
    end
  end

  context "without the log file defined" do
    before { log_file_path("blablabla.log") }

    it "returns an error text" do
      expect(analyzer.top_best_response_times.include?("No such file or directory")).to eq(true)
      expect(analyzer.top_best_response_times.include?("blablabla.log")).to eq(true)
    end
  end

  context "with results to save into pretty html table" do
    before { log_file_path("response_times_tests.log") }

    it "returns the number of lines he wrote into the file" do
      expect(analyzer.html_generation.is_a?(Integer)).to eq(true)
    end
  end

  private

  # rubocop:disable RSpec/SubjectStub

  def log_file_path(filename)
    allow(subject)
      .to receive(:log_file)
      .and_return("./spec/fixtures/files/time_analyzer/#{filename}")
  end

  # rubocop:enable RSpec/SubjectStub
end
