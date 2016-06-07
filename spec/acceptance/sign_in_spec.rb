require 'rails_helper'

feature 'User sign in' do
  scenario 'Registered user try to sign in' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in 'Email', with: 'mail@mail.ru'
    fill_in 'Пароль', with: '12345678'
    click_on 'Войти'

    expect(page).to have_content user.first_name
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'mail@mail.ru'
    fill_in 'Пароль', with: '12345678'
    click_on 'Войти'

    expect(page).to have_content 'Вход'
    expect(current_path).to eq new_user_session_path
  end
end