require 'rails_helper'

RSpec.describe 'コメント機能', type: :system do
  let!(:user) { FactoryBot.create(:user, role: 'parent') }
  let!(:blog) { FactoryBot.create(:blog, user: user) }
  let!(:comment) { FactoryBot.create(:comment, blog: blog, user: user) }

  describe 'コメント投稿のテスト' do
    context 'コメントを投稿する場合' do
      it '投稿されたコメントが表示される' do
        visit new_user_session_path
        fill_in 'user_email', with: 'a@gmail.com'
        fill_in 'user_password', with: 'password1'
        click_button 'ログイン'
        click_link '詳細'
        sleep(0.5)
        fill_in 'comment_content', with: 'comment1'
        click_button 'コメントを登録'
        sleep(1)
        expect(page).to have_content 'comment1'
      end
    end

    context 'コメントを編集する場合' do
      it '編集されたコメントが表示される' do
        visit new_user_session_path
        fill_in 'user_email', with: 'a@gmail.com'
        fill_in 'user_password', with: 'password1'
        click_button 'ログイン'
        click_link '詳細'
        sleep(0.5)
        find('.comment-actions a', text: 'コメント編集').click
        sleep(0.5)
        find("[data-test-id='test_comment_content']").set('これは新しいコメントです。')
        sleep(0.5)
        click_button '更新'
        sleep(1)
        expect(page).to have_content 'これは新しいコメントです。'
      end
    end

    context 'コメントを削除する場合' do
      it '削除されたコメントがなくなる' do
        visit new_user_session_path
        fill_in 'user_email', with: 'a@gmail.com'
        fill_in 'user_password', with: 'password1'
        click_button 'ログイン'
        click_link '詳細'
        sleep(0.5)
        find('.comment-actions .custom-link', text: 'コメント削除', match: :first).click
        page.driver.browser.switch_to.alert.accept
        sleep(0.5)
        expect(page).not_to have_content 'これはコメントです。'
      end
    end
  end
end