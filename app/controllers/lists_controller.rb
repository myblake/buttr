class ListsController < ApplicationController
  before_filter :set_list, only: [:show, :update, :destory]
  
  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.create(params[:list].permit(:shopping_date, :user_id))
    redirect :show
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def set_list
    @list = List.find(params[:id])
  end
end
