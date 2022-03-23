# frozen_string_literal: true

# The BuildInitialRecords module
module BuildInitialRecords
  extend ActiveSupport::Concern

  included do
    before_create :build_default_property_disposition_checklist

    def build_default_property_disposition_checklist
      self.property_disposition_checklist = PropertyDispositionChecklist.new
      true
    end

    before_create :build_default_listing

    def build_default_listing
      self.listing = Listing.new(
        address: combined_address, price: rand(100_000..999_999)
      )
      true
    end

    before_create :build_default_repc

    def build_default_repc
      securerandom = SecureRandom
      repcs << Repc.new(
        version: '1',
        mop_token: SecureRandom.hex,
        mop_token_secondary: securerandom.hex
      )
      true
    end

    before_create :build_default_intake_form

    def build_default_intake_form
      self.intake_form = IntakeForm.new(
        property_analysis: 'incomplete',
        disposition_plan: 'incomplete'
      )
      true
    end
  end
end
