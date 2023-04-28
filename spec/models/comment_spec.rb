require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーションのテスト' do
    context 'コメントの内容が空の場合' do
      it 'バリデーションにひっかかる' do
        comment = Comment.new(content: '')
        expect(comment).not_to be_valid
      end
    end

    context 'コメントの内容が空ではない場合' do
      let!(:user1) { FactoryBot.create(:user, role: 'parent') }
      let!(:blog) { FactoryBot.create(:blog, user: user1) }
      it 'バリデーションにひっかからない' do
        comment = Comment.new(content: 'がんばれ',blog: blog, user: user1)
        expect(comment).to be_valid
      end
    end
  end
end