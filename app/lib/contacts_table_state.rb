class ContactsTableState
  attr_accessor :empty, :fresh, :records, :query, :page, :sort, :direction

  def initialize(options = {})
    @empty = options.fetch(:empty, nil)
    @fresh = options.fetch(:fresh, nil)
    @records = Contact.order('sendgrid_created_at DESC').limit(25)
    @query = options.fetch(:query, nil)
    @page = options.fetch(:page, nil)
    @sort = options.fetch(:sort, nil)
    @direction = options.fetch(:direction, nil)
  end
end
