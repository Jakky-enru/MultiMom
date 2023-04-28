require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーションのテスト' do
    context 'コメントの内容が空の場合' do
      it 'バリデーションにひっかかる' do
        comment = Comment.new(content: '')
        expect(comment).not_to be_valid
      end
    end
  end
end