class ContactsTableState
  attr_accessor :records, :query, :page, :sort, :direction

  def initialize(options = {})
    @records = options.fetch(:records, nil)
    @query = options.fetch(:query, nil)
    @page = options.fetch(:page, 1)
    @sort = options.fetch(:sort, 'sendgrid_created_at')
    @direction = options.fetch(:direction, 'desc')
  end

  def empty?
    Contact.count == 0
  end

  def fresh?
    return false if Contact.count != Rails.cache.read("contact_count_at_sendgrid")
    true
  end
end
