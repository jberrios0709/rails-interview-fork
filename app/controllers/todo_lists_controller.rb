class TodoListsController < ApplicationController
  # GET /todolists
  def index
    @todo_lists = TodoList.all

    respond_to :html
  end

  # GET /todolists/new
  def new
    @todo_list = TodoList.new

    respond_to :html
  end

  def create
    @todo_list = TodoList.new(params_permit)
    return render :new, status: :unprocessable_entity unless @todo_list.valid?

    @todo_list.save
    redirect_to :todo_lists
  end

  private

  def params_permit
    params.require(:todo_list).permit(:name)
  end
end
