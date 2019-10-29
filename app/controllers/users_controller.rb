class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_or_correct, only: [:show]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end

  def show
  end

  def new
    # unless @user.admin? && !current_user　自分で考えたやつ
    #☆まずは条件分岐。User.newは後に書く！
    # ↓user.admin? だけだと別の管理者が当該管理者のsignupページを開けてしまう。
    if logged_in? && !current_user.admin?
    flash[:info] = "既にアカウント作成済みです。"
    redirect_to current_user
    end
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    if @user.destroy
      flash[:success] = "#{@user.name}のデータを削除しました"
      redirect_to users_url
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
end