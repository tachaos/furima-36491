class SellerDestination
  include ActiveModel::Model
  attr_accessor :postal_code, :delivery_source_id	, :city, :block_number, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
    validates :city
    validates :block_number
    validates :phone_number, numericality: {only_integer: true, message: "is invalid.Input only number"}
    validates :delivery_source_id, numericality: { other_than: 0, message: "can't be blank" }
    validates_format_of :phone_number, {with: /[0-9]{11}/ , message: "is too short" }
    validates :token
  end

    def save
      seller = Seller.create(user_id: user_id, item_id: item_id)
      Destination.create(postal_code: postal_code,  delivery_source_id: delivery_source_id, city: city, block_number: block_number, building_name: building_name, phone_number: phone_number, seller_id: seller.id)
    end
end