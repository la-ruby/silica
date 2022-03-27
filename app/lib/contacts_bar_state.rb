class ContactsBarState
  attr_accessor :page, :sort, :direction

  def initialize(options = {})
    @page = options.fetch(:page, 1)
    @sort = options.fetch(:sort, 'sendgrid_created_at')
    @direction = options.fetch(:direction, 'desc')
  end
end
