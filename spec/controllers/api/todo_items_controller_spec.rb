require 'rails_helper'

RSpec.describe "TodoItems", type: :request do
  describe "GET /index" do
    context 'when the params are valid' do
      let(:todo_list) { TodoList.create(name: 'Setup RoR project') }
      let(:todo_item) { TodoItem.create(title: 'test', description: 'test', todo_list: todo_list) }

      before do
        get "/api/todolists/#{todo_item.todo_list_id}/todo_items"
      end

      it 'succesfull' do
        expect(response.code).to eq '200'
      end

      it 'return correctly data' do
        todo_items = JSON.parse(response.body)
        aggregate_failures 'includes the title and description' do
          expect(todo_items['data'].count).to eq(1)
          expect(todo_items['data'][0].keys).to match_array(['id', 'title', 'description', "completed", "created_at", "todo_list_id", "updated_at"])
          expect(todo_items['data'][0]['id']).to eq(todo_item.id)
          expect(todo_items['data'][0]['title']).to eq(todo_item.title)
          expect(todo_items['data'][0]['description']).to eq(todo_item.description)
        end
      end
    end
  end

  describe "POST /create" do
    context 'when the params are valid' do
      let(:todo_list) { TodoList.create(name: 'Setup RoR project') }
      let(:params) do
        {
          title: 'Test to challenge',
          description: 'test'
        }
      end
      let(:request) do
        post "/api/todolists/#{todo_list.id}/todo_items", params: params
      end

      it 'succesfull' do
        request
        expect(response.code).to eq '200'
      end

      it 'create a new toto_items' do
        expect { request }.to change(TodoItem, :count).from(0).to 1
      end
    end

    context 'when the are missing params' do
      let(:todo_list) { TodoList.create(name: 'Setup RoR project') }
      let(:params) do
        {
          description: 'test'
        }
      end
      let(:request) do
        post "/api/todolists/#{todo_list.id}/todo_items", params: params
      end

      it 'error' do
        request
        expect(response.code).to eq '422'
      end
    end
  end
end
