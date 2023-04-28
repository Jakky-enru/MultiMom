require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'バリデーションのテスト' do
    context 'ブログの内容が空の場合' do
      it 'バリデーションにひっかかる' do
        blog = Blog.new(content: '')
        expect(blog).not_to be_valid
      end
    end
  end
end