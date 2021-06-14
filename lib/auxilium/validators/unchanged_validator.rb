# frozen_string_literal: true

class UnchangedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, _value)
    return unless record.persisted?

    if record.changed_attributes.include?(attribute) || record.changed_attributes.include?("#{attribute}_id")
      record.errors.add(attribute,
                        I18n.t('errors.messages.may_not_be_changed'))
    end
  end
end
