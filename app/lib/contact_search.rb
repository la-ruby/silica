class ContactSearch
  attr_accessor :example

  def initialize(options = {})
    @query = options.fetch(:query, nil)
  end

  def perform
    Rails.logger.info "Performing search #{@query}"
  end
end
