
# https://stackoverflow.com/a/5268112
# https://github.com/rails/rails/issues/22606#issuecomment-166017622
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance| html_tag.html_safe end
