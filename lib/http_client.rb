require "net/http"

module HttpClient
  module_function

  def get(path, headers = default_accept_header)
    uri = URI.parse(path)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == "https"
    request = Net::HTTP::Get.new(uri.request_uri)
    headers.each_key { |key| request[key] = headers[key] }
    http.request(request)
  end

  def post(path, body = "", headers = default_content_header)
    uri = URI.parse(path)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == "https"
    request = Net::HTTP::Post.new(uri.request_uri)
    headers.each_key { |key| request[key] = headers[key] }
    request.body = body
    http.request(request)
  end

  def put(path, body = "", headers = default_content_header)
    uri = URI.parse(path)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == "https"
    request = Net::HTTP::Put.new(uri.request_uri)
    headers.each_key { |key| request[key] = headers[key] }
    request.body = body
    http.request(request)
  end

  def delete(path)
    uri = URI.parse(path)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == "https"
    request = Net::HTTP::Delete.new(uri.request_uri)
    headers.each_key { |key| request[key] = headers[key] }
    http.request(request)
  end

  private_class_method

  def default_content_header
    { "Content-Type": "application/json", **default_accept_header }
  end

  def default_accept_header
    { "Accept": "application/json" }
  end
end
