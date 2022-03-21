# frozen_string_literal: true

class Addendum < ApplicationRecord
  belongs_to :project
  has_many :addendum_versions

  def most_recent_addendum_version
    addendum_versions.order(:version).last
  end

  def next_addendum_version_version
    result = 1
    if addendum_versions.present?
      result = addendum_versions.order(:version).last.version.to_i+1
    end
    result
  end

  def add_an_addendum_version
    addendum_version = AddendumVersion.create(
      addendum_id: id,
      version:  next_addendum_version_version,
      mop_token: SecureRandom.hex,
      status: 'Draft',
      related_repc_id: project.repc.id
    )
    addendum_version
  end

  def self.next_addendum_number(project)
    project.addendums.count == 0 ? 1 : project.addendums.order(:addendum_number).last.addendum_number+1
  end

  def self.add_an_addendum(project)
    addendum = Addendum.create(
      addendum_number: Addendum.next_addendum_number(project),
      project_id: project.id
    )
    addendum_version = AddendumVersion.create(
      addendum_id: addendum.id,
      version:  1,
      mop_token: SecureRandom.hex,
      status: 'Draft',
      related_repc_id: project.repc.id
    )
    raise 'Invalid 1642519450' if addendum_version.errors.present?
    addendum
  end
end
