# frozen_string_literal: true

# Build Initial Records module
module BuildInitialRecords
  extend ActiveSupport::Concern

  included do
    before_create :build_default_property_disposition_checklist
    before_create :build_default_listing
    before_create :build_default_repc
    before_create :build_default_intake_form
  end

  private

  def build_default_repc
    repcs << Repc.new(
      version: '1',
      mop_token: SecureRandom.hex,
      mop_token_secondary: SecureRandom.hex
    )
    true
  end

  def build_default_property_disposition_checklist
    self.property_disposition_checklist = PropertyDispositionChecklist.new
    true
  end

  def build_default_listing
    self.listing = Listing.new(
      address: combined_address, price: rand(100_000..999_999)
    )
    true
  end

  def build_default_intake_form
    self.intake_form = IntakeForm.new(
      property_analysis: 'incomplete',
      disposition_plan: 'incomplete'
    )
    true
  end
end
