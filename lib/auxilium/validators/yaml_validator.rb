# frozen_string_literal: true

class YamlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    YAML.safe_load(value)
  rescue Exception => e
    record.errors.add attribute, e.message.gsub('(<unknown>)', 'invalid')
  end
end
