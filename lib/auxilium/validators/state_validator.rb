# frozen_string_literal: true

class StateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil? && options[:allow_nil]

    correct_states = options[:only] || []
    wrong_states = options[:except] || []
    state_method = options.fetch(:state, :state)
    current_state = attribute == state_method ? value : value.send(state_method)
    return if current_state.nil? && options[:allow_nil]

    if (wrong_states.present? && wrong_states.include?(current_state)) || (correct_states.present? && correct_states.exclude?(current_state))
      record.errors.add(attribute, I18n.t(attribute == state_method ? 'errors.messages.not_an_allowed_state' : 'errors.messages.not_in_an_allowed_state'))
    end
  end
end
