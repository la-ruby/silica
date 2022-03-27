# frozen_string_literal: true

# Addendum Model
class Addendum < ApplicationRecord
  belongs_to :project
  has_many :addendum_versions

  def most_recent_addendum_version
    addendum_versions.order(:version).last
  end

  def next_addendum_version_version
    result = 1
    result = addendum_versions.order(:version).last.version.to_i + 1 if addendum_versions.present?
    result
  end

  def add_an_addendum_version
    Addendum.create_addendum_version(id, next_addendum_version_version, 'Draft', project.repc.id)
  end

  def self.next_addendum_number(project)
    project.addendums.count.zero? ? 1 : project.addendums.order(:addendum_number).last.addendum_number + 1
  end

  def self.add_an_addendum(project)
    addendum = Addendum.create(
      addendum_number: Addendum.next_addendum_number(project),
      project_id: project.id
    )
    addendum_version = Addendum.create_addendum_version(addendum.id, 1, 'Draft', project.repc.id)
    raise 'Invalid 1642519450' if addendum_version.errors.present?

    addendum
  end

  def self.create_addendum_version(id, version, status, related)
    AddendumVersion.create(
      addendum_id: id,
      version: version,
      mop_token: SecureRandom.hex,
      status: status,
      related_repc_id: related
    )
  end
end
