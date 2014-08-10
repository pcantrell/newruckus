# Thanks to http://stackoverflow.com/a/9047226

class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    valid = begin
      uri = URI.parse(value)
      uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
    rescue URI::InvalidURIError
      false
    end
    
    unless valid
      record.errors[attribute] << (options[:message] || "is not an url")
    end
  end
end
