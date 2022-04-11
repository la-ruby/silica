# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def new?
    true
  end

  def update?
    true
  end

  def underwriting_review_offer?
    true
  end

  def underwriting_prepare_repc?
    true
  end

  def download_property_analysis?
    true
  end

  def show?
    true
  end
end
