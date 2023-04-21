require 'rails_helper'

RSpec.describe 'CREATE todo list', type: :system do
  it 'title is blank' do
    visit new_todo_list_path
    click_button 'Create Todo list'

    expect(page).to have_content('Name can\'t be blank')
    expect(TodoList.count).to eq(0)
  end

  it 'all is ok' do
    visit new_todo_list_path
    fill_in 'todo_list_name', with: 'Name to first test'
    click_button 'Create Todo list'

    expect(page).to have_content('#1 | Name to first test')
    expect(TodoList.count).to eq(1)
  end
end