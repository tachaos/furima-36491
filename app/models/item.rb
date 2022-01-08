class Item < ApplicationRecord
  #has_one :seller
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :category
    belongs_to :status
    belongs_to :delivery_charge
    belongs_to :delivery_source
    belongs_to :delivery_days

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :price
  end

  validates :category_id,        numericality: { other_than: 0 , message: "can't be blank"}
  validates :status_id,          numericality: { other_than: 0 , message: "can't be blank"}
  validates :delivery_charge_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :delivery_source_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :delivery_days_id,   numericality: { other_than: 0 , message: "can't be blank"}
  validates :price,              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "Out of setting range"}
  validates :price,              numericality: { only_integer: true, message: "Half-width number." }

end
