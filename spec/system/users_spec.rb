require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do
  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
    #トップページに遷移
    visit root_path

    #ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
  end

  it 'ログインに成功し、トップページに遷移する' do
      #予め、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)

      #サインインページへ移動
      visit new_user_session_path

      #ログインしていない場合、サインインページに遷移することを確認する
      expect(current_path).to eq new_user_session_path

      #既に保存されているユーザーのemailとpasswordを入力する
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password

      #ログインボタンをクリックする
      click_on("Log in")

      #トップページに遷移していることを確認する
      expect(current_path).to eq root_path

  end

  it 'ログインに失敗し、再びサインインページに戻る' do
    #予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)

    #トップページへ遷移する
    visit root_path

    #ログインしていない場合、サインインページに遷移していないこと確認する
    expect(current_path).to eq new_user_session_path

    #誤ったユーザー情報を入力する
    fill_in 'user_email', with: "test"
    fill_in 'user_password', with: "test"

    #ログインボタンをクリックする
    click_on("Log in")

    #サインインページに戻ってきていないことを確認する
    expect(current_path).to eq new_user_session_path
  end
end