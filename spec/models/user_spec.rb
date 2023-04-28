require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    context 'ユーザーの名前が空の場合' do
      it 'バリデーションにひっかかる' do
        user = User.new(name: '', email: 'test@example.com', password: 'password', password_confirmation: 'password', role: 'parent')
        expect(user).not_to be_valid
      end
    end

    context 'メールアドレスが空の場合' do
      it 'バリデーションにひっかかる' do
        user = User.new(name: 'Test User', email: '', password: 'password', password_confirmation: 'password', role: 'parent')
        expect(user).not_to be_valid
      end
    end

    context 'ロールが空の場合' do
      it 'バリデーションにひっかかる' do
        user = User.new(name: 'Test User', email: 'test@example.com', password: 'password', password_confirmation: 'password', role: '')
        expect(user).not_to be_valid
      end
    end
  end
end