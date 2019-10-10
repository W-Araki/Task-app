class TasksController < ApplicationController
  before_action :set_user
  
  def index
  end
  
  def new
  end
  
  def show
  end
  
  def edit
  end
  
  private
  
  def set_user
    @user = User.find(params[:user_id])
  end
end