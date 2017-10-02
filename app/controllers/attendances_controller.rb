class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def index
    @attendances = Attendance.all
    @worktime_aggregates = Worktime_aggregate.all
  end

  def new
    @attendance = Attendance.new
  end

  def create
    @attendance = Attendance.new(attendances_params) #render 'new'に変数を渡すため
    @attendance.user_id = current_user.id
    if @attendance.save
      redirect_to attendances_path, notice: "頑張ったことを作成しました！"
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
      params.require(:attendance).permit(:working_date, worktime_aggregates_attributes: [:workplace, :construction, :constructiontime])
    end

end
