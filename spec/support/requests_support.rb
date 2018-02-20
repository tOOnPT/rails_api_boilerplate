module RequestsSupport
  def response_json
    JSON.parse(response.body, symbolize_names: true)
  end

  def raise_get_timeout
    allow(HttpClient).to receive(:get).and_raise(Timeout::Error)
  end

  def raise_put_timeout
    allow(HttpClient).to receive(:put).and_raise(Timeout::Error)
  end

  def raise_post_timeout
    allow(HttpClient).to receive(:post).and_raise(Timeout::Error)
  end
end
