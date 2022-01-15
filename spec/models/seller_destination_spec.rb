require 'rails_helper'

RSpec.describe SellerDestination, type: :model do
  describe '配送先情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @seller_destination = FactoryBot.build(:seller_destination, user_id: user.id, item_id: item.id)
      sleep(1)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@seller_destination).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @seller_destination.building_name = ''
        expect(@seller_destination).to be_valid
      end
    end
    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @seller_destination.postal_code = ''
        @seller_destination.valid?
        expect(@seller_destination.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @seller_destination.postal_code = '1234567'
        @seller_destination.valid?
        expect(@seller_destination.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it 'delivery_sourceを選択していないと保存できないこと' do
        @seller_destination.delivery_source_id = 0
        @seller_destination.valid?
        expect(@seller_destination.errors.full_messages).to include("Delivery source can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @seller_destination.phone_number = nil
        @seller_destination.valid?
        expect(@seller_destination.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが全角数字だと保存できないこと' do
        @seller_destination.phone_number = '０９０９９９９３３３３'
        @seller_destination.valid?
        expect(@seller_destination.errors.full_messages).to include("Phone number is invalid.Input only number")
      end
      it 'phone_numberが9桁以下では保存できないこと' do
        @seller_destination.phone_number = '090999933'
        @seller_destination.valid?
        expect(@seller_destination.errors.full_messages).to include("Phone number is too short")
      end
      it 'phone_numberが12桁以上では保存できないこと' do
        @seller_destination.phone_number = '090999933333'
        @seller_destination.valid?
        expect(@seller_destination.errors.full_messages).to include("Phone number is too short")
      end
      it "tokenが空では登録できないこと" do
        @seller_destination.token = nil
        @seller_destination.valid?
        expect(@seller_destination.errors.full_messages).to include("Token can't be blank")
      end
      it "userが紐付いていなければ投稿できない" do
        @seller_destination.user_id = nil
        @seller_destination.valid?
      end
      it "itemが紐付いていなければ投稿できない" do
        @seller_destination.item_id = nil
        @seller_destination.valid?
      end
    end
  end
end
