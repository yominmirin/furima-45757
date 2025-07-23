require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品新規投稿' do
    context '新規投稿できるとき' do
      it 'すべてのバリデーションを満たす場合投稿できる' do
        expect(@item).to be_valid
      end
    end
    context '新規投稿できないとき' do
      it 'nameが空欄の場合新規投稿できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'infoが空欄の場合新規投稿できない' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end
      it 'priceが空欄の場合新規投稿できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'categoryが未選択(idが1)の場合新規投稿できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category を選択してください')
      end
      it 'sales_statusが未選択(idが1)の場合新規投稿できない' do
        @item.sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Sales status を選択してください')
      end
      it 'shipping_fee_statusが未選択(idが1)の場合新規投稿できない' do
        @item.shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping fee status を選択してください')
      end
      it 'prefectureが未選択(idが1)の場合新規投稿できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture を選択してください')
      end
      it 'scheduled_deliveryが未選択(idが1)の場合新規投稿できない' do
        @item.scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Scheduled delivery を選択してください')
      end
      it 'imageが未選択の場合新規投稿できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Image を添付してください')
      end
      it 'priceが300円未満の場合新規投稿できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は￥300~9,999,999の半角数字で入力してください')
      end
      it 'priceが9,999,999円を超える場合新規投稿できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は￥300~9,999,999の半角数字で入力してください')
      end
      it 'priceに少数が入力された場合新規投稿できない' do
        @item.price = 3000.3
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は￥300~9,999,999の半角数字で入力してください')
      end
      it 'priceが文字列(数字でない文字)の場合新規投稿できない' do
        @item.price = 'a'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は￥300~9,999,999の半角数字で入力してください')
      end
      it 'priceが全角混在の場合新規投稿できない' do
        @item.price = '123４'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は￥300~9,999,999の半角数字で入力してください')
      end
      it 'userが紐づいていない場合新規投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
