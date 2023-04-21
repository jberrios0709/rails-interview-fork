class Api::TodoItemsController < ApplicationController
  before_action :todo_list, only: [:create, :index]

  def index
    render json: { data: TodoItem.where(todo_list: todo_list) }
  end

  def create
    object = TodoItem.new(params_permit)
    return render json: { error: 'Invalid Params' }, status: :unprocessable_entity unless object.valid?

    object.save
    head :ok
  end

  private

  def todo_list
    @todo_list ||= TodoList.find_by(id: params[:todo_list_id])
  end

  def params_permit
    params.permit([:title, :description, :todo_list_id])
  end
end
