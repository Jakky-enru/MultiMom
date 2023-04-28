require 'rails_helper'
RSpec.describe "ユーザー機能", type: :system do
  describe "新規ユーザー登録機能" do
    context "parentのroleで登録した場合" do
      it "登録できる" do
        visit new_user_registration_path
        fill_in "user_name", with: "User4"
        fill_in "user_email", with: "d@gmail.com"
        fill_in "user_password", with: "password4"
        fill_in "user_password_confirmation", with: "password4"
        select "親", from: "user_role"    
        click_button "新規登録"
        expect(page).to have_content "親の投稿一覧"
        expect(page).to have_content "アカウント登録が完了しました。"
      end
    end

    context "childのroleで登録した場合" do
      it "登録できる" do
        visit new_user_registration_path
        fill_in "user_name", with: "User5"
        fill_in "user_email", with: "e@gmail.com"
        fill_in "user_password", with: "password5"
        fill_in "user_password_confirmation", with: "password5"
        select "子", from: "user_role"         
        click_button "新規登録"
        expect(page).to have_content "子の投稿一覧"
        expect(page).to have_content "アカウント登録が完了しました。"
      end
    end

    context "adminのroleで登録した場合" do
      it "登録できる" do
        visit new_user_registration_path
        fill_in "user_name", with: "User6"
        fill_in "user_email", with: "f@gmail.com"
        fill_in "user_password", with: "password6"
        fill_in "user_password_confirmation", with: "password6"
        select "Admin", from: "user_role"    
        click_button "新規登録"
        expect(page).to have_content "投稿一覧"
        expect(page).to have_content "アカウント登録が完了しました。"
      end
    end
  end

  describe "ログイン機能" do
    let!(:User1) { FactoryBot.create(:user, role: 'parent') }
    let!(:user2) { FactoryBot.create(:user2, role: 'child') }

    context "parentのroleでログイン" do
      it "parentのroleを持つユーザーだけが投稿したblogの一覧画面を表示する" do
        visit new_user_session_path
        fill_in "user_email", with: "a@gmail.com"
        fill_in "user_password", with: "password1"
        click_button "ログイン"
        expect(page).to have_content "ログインしました。"
        visit blogs_path
        expect(page).to have_content "親の投稿一覧"
      end
    end

    context "childのroleでログイン" do
      it "childのroleを持つユーザーだけが投稿したblogの一覧画面を表示する" do
        visit new_user_session_path
        fill_in "user_email", with: "b@gmail.com"
        fill_in "user_password", with: "password2"
        click_button "ログイン"
        expect(page).to have_content "ログインしました。"
        visit blogs_path
        expect(page).to have_content "子の投稿一覧"
      end
    end
  end

  describe "管理者機能" do
    let!(:user3) { FactoryBot.create(:user3, role: 'admin') }

    context "管理者ユーザが管理者画面にアクセスしようとした場合" do
      it "管理者画面に遷移することができる" do
        visit new_user_session_path
        fill_in "user_email", with: "c@gmail.com"
        fill_in "user_password", with: "password3"
        click_button "ログイン"
        expect(page).to have_content "ログインしました。"
        click_on "管理者ページ"
        visit rails_admin_path
        expect(page).to have_content "サイト管理"
      end
    end
  end
end
