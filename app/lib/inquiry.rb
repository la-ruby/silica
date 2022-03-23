# frozen_string_literal: true

class Inquiry
  attr_accessor :name, :email, :phone, :url, :ip

  def initialize(options = {})
    @name = options[:name]
    @email = options[:email]
    @phone = options[:phone]
    @url = options[:url]
    @ip = options[:ip]
  end

  def valid?
    part_a_valid = @name.present?
    part_b_valid = @email.present? || @phone.present?
    part_a_valid && part_b_valid
  end
end
