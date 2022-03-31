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

  def overview?
    true
  end

  def offer?
    true
  end

  def inspection?
    true
  end

  def dispositions_checklist?
    true
  end

  def dispositions_prepare_listing?
    true
  end

  def underwriting_review_offer?
    true
  end

  def underwriting_prepare_repc?
    true
  end

  def underwriting_property_analysis?
    true
  end

  def underwriting_intake_form?
    true
  end

  def marketplace?
    true
  end

  def files?
    true
  end

  def activity?
    true
  end

  def download_property_analysis?
    true
  end
end
