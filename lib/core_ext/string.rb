# frozen_string_literal: true

class String
  def downcase_first
    self[0] = self[0].downcase
    self
  end
end
