class ContactsBarState
  attr_accessor :example

  def initialize(options = {})
    @example = options.fetch(:example, nil)
  end
end
