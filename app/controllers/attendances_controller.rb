class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attendance,only:[:show,:edit,:update,:destroy]

  def index
    @attendance = Attendance.new #select_form
    if params[:attendance]
      date_search = "#{params[:attendance]["date_search(1i)"]}-#{params[:attendance]["date_search(2i)"]}-#{params[:attendance]["date_search(3i)"]}"
      @attendances = Attendance.where(opening_datetime: date_search.in_time_zone.all_month).order(:opening_datetime)
    else
      date_default = "#{Date.today.year}-#{Date.today.month}-#{01}"
      @attendances = Attendance.where(opening_datetime: date_default.in_time_zone.all_month).order(:opening_datetime)
    end
  end

  def show
      @attendance.worktime_aggregates.build
      opening_datetime_show = @attendance.opening_datetime  #入ってきたIDからopening_datetime取得
      opening_date = "#{opening_datetime_show.year}-#{opening_datetime_show.month}-#{01}" #成形
      @attendances = Attendance.where(opening_datetime: opening_date.in_time_zone.all_month).order(:opening_datetime)
  end

  def new
    if params[:back]
      @attendance = Attendance.new(attendances_params)
    else
      @attendance = Attendance.new
      @attendance.worktime_aggregates.build
    end
  end

  def create
    @attendance = Attendance.new(attendances_params) #render 'new'に変数を渡すため
    @attendance.user_id = current_user.id
    if @attendance.save
      redirect_to attendances_path(@attendance), notice: '登録しました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @attendance.update(attendances_params)
      redirect_to attendances_path,notice:"編集しました。"
    else
      render'edit'
    end
  end

  def destroy
    @attendance.destroy
    redirect_to attendances_path, notice:"削除しました"
  end

  def confirm
    @attendance = Attendance.new(attendances_params)
    render :new if @attendance.invalid?
  end

  private
    def attendances_params
      params.require(:attendance).permit(:opening_datetime,:closing_datetime,:over_time,:break_time,:holiday,:attendance_time,:date_search, worktime_aggregates_attributes:[:select_workplace, :construction_id,:constructiontime,:attendance_id,:_destroy,:construction])
    end
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

end
