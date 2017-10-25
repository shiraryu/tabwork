class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attendance,only:[:show,:edit,:update,:destroy]

  def index
    unless params[:attendance]
      @attendance = Attendance.new #select_form
      binding.pry
      date_search = "#{params[:attendance][“date_search(1i)”]}-#{params[:attendance][“date_search(2i)”]}-#{params[:attendance][“date_search(3i)”]}"
      @attendances = Attendance.where(opening_datetime: date_search.in_time_zone.all_month).order(:opening_datetime) #日時順 , 日付検索一覧返す
    end
      @attendances = Attendance.where(opening_datetime: "2017-10-01".in_time_zone.all_month).order(:opening_datetime)
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
