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
    binding.pry
    @attendance = Attendance.new(attendances_params) #render 'new'に変数を渡すため
    @attendance.user_id = current_user.id
    if @attendance.save
      format.html { redirect_to attendances_path(@attendance), notice: '登録しました。' }
      format.js { render :index }
    else
      format.html { render :new }
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
      params.require(:attendance).permit(:opening_datetime,:closing_datetime,:over_time,:holiday, worktime_aggregates_attributes:[:select_workplace, :construction_id,:constructiontime,:attendance_id,:_destroy,:construction])
    end

end
