class Post < ApplicationRecord
  has_one_attached :photo
  belongs_to :color
end
