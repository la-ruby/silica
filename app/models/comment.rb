class Comment < ApplicationRecord
  has_rich_text :content
end
