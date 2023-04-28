require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'バリデーションのテスト' do
    context 'ブログの内容が空の場合' do
      it 'バリデーションにひっかかる' do
        blog = Blog.new(content: '')
        expect(blog).not_to be_valid
      end
    end
    context 'ブログの内容が空ではない場合' do
      let!(:user1) { FactoryBot.create(:user, role: 'parent') }
      it 'バリデーションにひっかからない' do
        blog = Blog.new(content: '子育て', user: user1)
        expect(blog).to be_valid
      end
    end
  end
end