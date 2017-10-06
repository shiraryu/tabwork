class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def index
    @attendances = Attendance.all

  end

  def new
    @attendance = Attendance.new
    @attendance.worktime_aggregates.build
  end

  def create
    @attendance = Attendance.new(attendances_params) #render 'new'に変数を渡すため
    @attendance.user_id = current_user.id
    if @attendance.save
      redirect_to attendances_path, notice: "登録しました！"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def confirm
  end

  private
    def attendances_params
      params.require(:attendance).permit(:opening_datetime,:closing_datetime,:over_time,:holiday, worktime_aggregates_attributes:[:select_workplace, :construction_id,:constructiontime,:id,:_destroy])
    end

end
