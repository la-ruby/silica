# frozen_string_literal: true

# :nodoc:
module AddendumVersionsHelper
  def addendum_version_card_title(addendum_version)
    "Addendum #{"%02d" % (addendum_version.addendum.addendum_number)} Details"
  end
end
