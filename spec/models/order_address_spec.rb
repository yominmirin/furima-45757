require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
  end

  describe '購入情報の保存' do
    context '保存できる場合' do
      it 'すべての項目が正しく記述されている場合保存できる' do
        expect(@order_address).to be_valid
      end
      it 'buildingが空でも保存できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end
    context '保存できない場合' do
      it 'postal_codeが空欄の場合保存できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'cityが空欄の場合保存できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'street_addressが空欄の場合保存できない' do
        @order_address.street_address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Street address can't be blank")
      end
      it 'phone_numberが空欄の場合保存できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'tokenが空の場合保存できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'prefecture_idが1の場合保存できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'postal_codeがバリデーションを満たさない場合保存できない' do
        @order_address.postal_code = 'a'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code input correctly')
      end
      it 'phone_numberが半角数字でない場合保存できない' do
        @order_address.phone_number = 'a'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number input only number')
      end
      it 'phone_numberが9文字以下の場合保存できない' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number input only number')
      end
      it 'phone_numberが12文字以上の場合保存できない' do
        @order_address.phone_number = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number input only number')
      end
      it 'userに紐づいていない場合保存できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemに紐づいていない場合保存できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
