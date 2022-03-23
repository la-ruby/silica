# frozen_string_literal: true

require 'open3'

# DocuSign Mixin
module DocuSign
  # Module DocuSign Mixin
  module Mixin
    class << self
      def create_recipient_view(envelope_id:, return_url:, role:, name:, email:)
        DocuSign::ViewRequest.new.perform(
          envelope_id: envelope_id,
          return_url: return_url,
          name: name,
          email: email,
          role: role
        )
      end
    end
  end
end
