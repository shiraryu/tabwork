class Admin::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(workplaces_params)
    if @user.save
      redirect_to admin_users_path,notice:"新しく社員を登録しました。"
    else
      #入力フォーム再描写
      render'new'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def userss_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end
    def set_workplace
      @workplace = Workplace.find(params[:id])
    end
end
