require 'rails_helper'

RSpec.describe 'NEW todo list', type: :system do
  it 'render a correct form' do
    visit new_todo_list_path

    expect(page).to have_selector('input', class: 'text')
    expect(page).to have_button('commit')
  end
end