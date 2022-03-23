# frozen_string_literal: true

# The UxPolicy
class UxPolicy < ApplicationPolicy
  # these are tabs in main navigation
  def overview? = true
  def offer? = true
  def inspection? = !user&.limited?
  def underwriting? = !user&.limited?
  def dispositions? = !user&.limited?
  def marketplace? = !user&.limited?
  def activity? = !user&.limited?
  def files? = !user&.limited?
  # /these are tabs in main navigation
end
