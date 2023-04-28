require 'rails_helper'
RSpec.describe 'ブログ管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user, role: 'parent') }
  let!(:user2) { FactoryBot.create(:user2, role: 'child') }
  describe '新規作成機能' do
    context '親のroleでブログを新規作成した場合' do
      it '作成したブログが親の一覧画面で表示される' do
        visit new_user_session_path
        fill_in 'user_email', with: 'a@gmail.com'
        fill_in 'user_password', with: 'password1'
        click_button 'ログイン'
        visit new_blog_path
        fill_in 'blog_content', with:'親の投稿です'
        click_on '登録する'
        expect(page).to have_content '投稿しました！'
        expect(page).to have_content '親の投稿一覧'
        expect(page).to have_content '親の投稿です'

      end
    end

    context '子のroleでブログを新規作成した場合' do
      it '作成したブログが子の一覧画面で表示される' do
        visit new_user_session_path
        fill_in 'user_email', with: 'b@gmail.com'
        fill_in 'user_password', with: 'password2'
        click_button 'ログイン'
        visit new_blog_path
        fill_in 'blog_content', with:'子の投稿です'
        click_on '登録する'
        expect(page).to have_content '投稿しました！'
        expect(page).to have_content '子の投稿一覧'
        expect(page).to have_content '子の投稿です'
      end
    end
  end

  describe 'ブログ編集機能' do
    let!(:blog) { FactoryBot.create(:blog, user: user) }
    context '投稿者がブログの情報を編集した時' do
      it '変更内容が反映される' do
        visit new_user_session_path
        fill_in "user_email", with: "a@gmail.com"
        fill_in "user_password", with: "password1"
        click_button "ログイン"
        visit blogs_path
        click_link "編集"
        fill_in 'blog_content', with:'大変'
        click_button "更新する"
        expect(page).to have_content "更新しました！"
        visit blogs_path
        expect(page).to have_content '大変'
      end
    end
  end

  describe 'ブログ削除機能' do
    let!(:blog2) { FactoryBot.create(:second_blog, user: user2) }
    context '投稿者がブログの情報を削除した時' do
      it 'ブログ情報が削除される' do
        visit new_user_session_path
        fill_in "user_email", with: "b@gmail.com"
        fill_in "user_password", with: "password2"
        click_button "ログイン"
        visit blogs_path
        click_link "削除"
        page.driver.browser.switch_to.alert.accept 
        expect(page).to have_content "投稿を削除しました！"
      end
    end
  end

  describe '検索機能' do
    let!(:blog) { FactoryBot.create(:blog, user: user) }
    let!(:blog2) { FactoryBot.create(:second_blog, user: user2) }
    context 'ブログをあいまい検索した場合' do
      it "検索キーワードを含むブログで絞り込まれる" do
        visit new_user_session_path
        fill_in "user_email", with: "a@gmail.com"
        fill_in "user_password", with: "password1"
        click_button "ログイン"
        visit blogs_path
        fill_in 'q_content_cont', with: 'blog1'
        click_button '検索'
        expect(page).to have_content 'blog1'
      end
    end
  end
end
