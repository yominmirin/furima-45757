class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :street_address, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A\d{3}-\d{4}\z/, message: "input correctly"}
    validates :prefecture_id, numericality: {other_than: 1, message:"can't be blank"}
    validates :city
    validates :street_address
    validates :phone_number, format: {with: /\A\d{10,11}\z/, message: "input only number."}
    validates :user_id
    validates :item_id
  end

  def save
    ActiveRecord::Base.transaction do
      order = Order.create!(user_id: user_id, item_id: item_id)

      Address.create!(postal_code: postal_code, prefecture_id: prefecture_id, city: city, street_address: street_address, building: building, phone_number: phone_number, order_id: order.id)
    end
  end
end