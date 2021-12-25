class Item < ApplicationRecord
  has_one :seller
  belongs_to :user
  has_one_attached :image
end
