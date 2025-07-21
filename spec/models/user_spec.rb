require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべてのバリデーションを満たす場合登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空欄の場合登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include( "Nickname can't be blank" )
      end
      it 'emailが空欄の場合登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include( "Email can't be blank" )
      end
      it 'passwordが空欄の場合登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include( "Password can't be blank" )
      end
      it 'last_nameが空欄の場合登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include( "Last name can't be blank" )
      end
      it 'first_nameが空欄の場合登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include( "First name can't be blank" )
      end
      it 'last_name_kanaが空欄の場合登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include( "Last name kana can't be blank" )
      end
      it 'first_name_kanaが空欄の場合登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include( "First name kana can't be blank" )
      end
      it 'birth_dayが空欄の場合登録できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include( "Birth day can't be blank" )
      end
      it 'passwordとpassword_confirmationが不一致の場合登録できない' do
        @user.password = '123456a'
        @user.password_confirmation = '1234567a'
        @user.valid?
        expect(@user.errors.full_messages).to include( "Password confirmation doesn't match Password" )
      end
      it 'emailが登録済みの場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include( "Email has already been taken" )
      end
      it 'emailが@を含まない場合登録できない' do
        @user.email = 'testexample'
        @user.valid?
        expect(@user.errors.full_messages).to include( "Email is invalid" )
      end
      it 'passwordが6文字未満の場合登録できない' do
        @user.password = 'pass1'
        @user.valid?
        expect(@user.errors.full_messages).to include( "Password is too short (minimum is 6 characters)" )
      end
      it 'passwordが全角文字を含む場合登録できない' do
        @user.password = 'test123あ'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include( "Password は英字と数字の両方を含めた半角文字のみで設定してください" )
      end
      it 'passwordが半角英字を含まない場合登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include( "Password は英字と数字の両方を含めた半角文字のみで設定してください" )
      end
      it 'passwordが半角数字を含まない場合登録できない' do
        @user.password = 'sample'
        @user.valid?
        expect(@user.errors.full_messages).to include( "Password は英字と数字の両方を含めた半角文字のみで設定してください" )
      end
      it 'last_nameが全角(漢字・ひらがな・カタカナ)で入力されていない場合登録できない' do
        @user.last_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include( "Last name には漢字、ひらがな、カタカナのいずれかを使用してください" )
      end
      it 'first_nameが全角(漢字・ひらがな・カタカナ)で入力されていない場合登録できない' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include( "First name には漢字、ひらがな、カタカナのいずれかを使用してください" )
      end
      it 'last_name_kanaが全角カタカナで入力されていない場合登録できない' do
        @user.last_name_kana = 'ああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include( "Last name kana には全角カタカナを使用してください" )
      end
      it 'first_name_kanaが全角カタカナで入力されていない場合登録できない' do
        @user.first_name_kana = 'ああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include( "First name kana には全角カタカナを使用してください" )
      end
    end
  end
end
