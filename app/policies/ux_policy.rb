# frozen_string_literal: true

class UxPolicy < ApplicationPolicy
  #
  # older
  #
  # these are tabs in main navigation
  def overview?; true end
  def offer?; true end
  def inspection?;   !user&.limited? end
  def underwriting?; !user&.limited? end
  def dispositions?; !user&.limited? end
  def marketplace?;  !user&.limited? end
  def activity?;     !user&.limited? end
  def files?;        !user&.limited? end
  # /these are tabs in main navigation

  def resync?
    user&.staff? && APOLLO_INTERNAL_PRODUCTION
  end
  #
  # /older
  #
end
