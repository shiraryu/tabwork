class UsersController < ApplicationController

  def index
    @user = User.find_by(id: params[:id])
    @users = User.all
  end
  def show
    redirect_to :action => "index"
  end
end
