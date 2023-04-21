require 'rails_helper'

RSpec.describe 'INDEX todo list', type: :system do
  context 'when there are rows' do
    before(:each) do
      TodoList.create(name: 'test1')
      TodoList.create(name: 'test2')
      TodoList.create(name: 'test3')
    end

    it 'render 3 rows' do
      visit todo_lists_path

      expect(page.all("div.todo_list_container").count).to eq(3)
    end

    it 'render correctly data' do
      visit todo_lists_path

      expect(page.all("div.todo_list_container").map(&:text))
        .to match_array ['#1 | test1', '#2 | test2', '#3 | test3']
    end
  end

  context 'when there are not rows' do
    it 'render 0 rows' do
      visit todo_lists_path

      expect(page.all("div.todo_list_container").count).to eq(0)
    end
  end
end