class TodosController < ApplicationController
  before_action :set_todo, only: %i[update destroy]

  def index
    @todos = Todo.all
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream # This allows Turbo Streams to handle the response
      end
    else
      render :index
    end
  end

  def update
    if @todo.update(todo_params)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream
      end
    else
      render :index
    end
  end

  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream
    end
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :completed)
  end
end