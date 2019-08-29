module DigHash
  module_function

  def dig(data, keys)
    return data if data.blank? || keys.blank?

    key = keys.shift
    return nil unless data.is_a? Hash

    data[key].blank? ? data[key] : dig(data[key], keys)
  end
end
