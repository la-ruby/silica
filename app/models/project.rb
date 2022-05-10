# frozen_string_literal: true

class Project < ApplicationRecord
  include DocuSign::Mixin
  include PrettyDate
  include PrettyMoney
  include ProjectPresenter
  include Webflow
  include Docusignable
  include BuildInitialRecords
  include ProjectValidations
  include ProjectStateHelpers
  extend Search

  scope :listed, -> { joins(:listing).where("listings.listed = 'true'") }

  has_many :kodaks, dependent: :destroy
  has_many :project_files, dependent: :destroy
  has_one :property_disposition_checklist
  has_one :listing
  has_many :repcs
  has_one :intake_form
  has_many :addendums

  after_create :update_searchable_columns
  after_update :activity_tab_updates

  def activity_tab_updates  
    if silica_attribute_added?('offer_viewed', previous_changes)
      Event.create(
        category: 'offer_viewed',
        timestamp: offer_viewed,
        record_id: id,
        record_type: 'Project',
        inventor_id: -3)
    end
    if silica_attribute_added?('marketing_mail_sent', previous_changes)
      Event.create(
        category: 'marketing_mail_sent',
        timestamp: Time.now,
        record_id: id,
        record_type: 'Project',
        inventor_id: -2)
    end
    if silica_attribute_added?('sales_notes_for_underwriting', previous_changes)
      Event.create(
        category: 'sales_notes_added',
        timestamp: Time.now,
        record_id: id,
        record_type: 'Project',
        inventor_id: -2)
    end
    if silica_attribute_added?('underwriting_notes_for_sales', previous_changes)
      Event.create(
        category: 'underwriting_notes_added',
        timestamp: Time.now,
        record_id: id,
        record_type: 'Project',
        inventor_id: -2)
    end
  end

  def silica_attribute_added?(the_attribute, the_previous_changes)
    if the_previous_changes.has_key?(the_attribute) &&
       (!(the_previous_changes[the_attribute][0].blank? && the_previous_changes[the_attribute][1].blank?)) && # change from nil to "" doesnt count
       the_previous_changes[the_attribute][0].blank? && the_previous_changes[the_attribute][1].present?
      true
    end
  end

  def update_searchable_columns
    str = "#{name} " \
          "#{street} #{street2} #{city} #{state} " \
          "#{phone} " \
          "#{email} " \
          "#{expectedtimeline} " \
          "#{req_date.strftime('%m/%d') rescue ''} " \
          "#{Time.iso8601(repc.sent_homeowner_at).strftime('%m/%d') rescue ''} " \
          "#{offer_viewed.strftime('%m/%d') rescue ''} " \
          "#{accepted_at.strftime('%m/%d') rescue ''} " \
          "#{addendum_sent.strftime('%m/%d') rescue ''} " \
          "#{source}"
    self.update_columns(
      searchable: str,
      street_searchable: "#{street} #{street2} #{city} #{state}")
  end

  def terms
    return if repc.offer_terms != 'yes'

    str = ''
    str += "Down Payment: $#{repc.down_payment}\n" if repc.down_payment.present?    
    str += "Term Length: #{repc.term_length} mos\n" if repc.term_length.present?
    str += "Interest Rate: #{repc.interest_rate}%\n" if repc.interest_rate.present?
    str += "Monthly Payment: $#{repc.monthly_payment}\n" if repc.monthly_payment.present?
    str += "Balloon Payment: $#{repc.balloon_payment}\n" if repc.balloon_payment.present?
    str
  end

  def repc
    repcs.last
  end

  def add_addendum_button_available?
    result = true

    return false unless repc.mature?
    result
  end

  def dispositions_prepare_listing_term_details_editable?
    repc.offer_terms == 'yes'
  end

  def dual?
    secondName.present? && secondEmail.present?
  end

  def dual_for_testing!
    update!(secondName: 'Testing', secondEmail: 'testing@example.net', secondPhone: '(111) 123-4567')
  end

  def marketplace_kodaks
    kodaks.where(marketplace: "1")
  end

  def primary_or_first_kodak
    kodaks.where(primary: "1", marketplace: "1").first&.pic || kodaks.where(marketplace: "1").first&.pic
  end

  # the react component expects a certain structure for the props passed in
  def project_files_for_react_component(folder)
    arr = project_files.select do |project_file|
      project_file.folder == folder
    end.map do |project_file| { id: project_file.id, name: project_file.silicafile.blob.filename.to_s } end
    arr.concat(ProjectFile::STANDARD_FOLDERS) if folder == '/'

    arr.concat(ProjectFile::STANDARD_CONSTRUCTION_SUBFOLDERS) if folder == '/Construction_Remodel/'
    arr
  end

  def events_for_activity_tab
    Event.where(record_type: 'Project', record_id: id).order('timestamp DESC')
  end

  def trigger_project_creation_notification(inventor_id = -2)
    Event.create(
      category: 'project_creation',
      timestamp: Time.now,
      record_id: id,
      record_type: 'Project',
      inventor_id: inventor_id
    )
  end
end
