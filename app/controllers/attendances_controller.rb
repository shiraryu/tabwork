class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attendance,only:[:show,:edit,:update,:destroy]

  def index
    @user = User.find_by(id: params[:user_id])
    #binding.pry
    @attendance = Attendance.new #select_form
    if current_user.try(:admin?)
      if params[:user_id]
        if params[:attendance]
          date_search = "#{params[:attendance]["date_search(1i)"]}-#{params[:attendance]["date_search(2i)"]}-#{params[:attendance]["date_search(3i)"]}"
          @attendances = @user.attendances.where(opening_datetime: date_search.in_time_zone.all_month).order(:opening_datetime)
        else
          date_default = "#{Date.today.year}-#{Date.today.month}-#{01}"
          @attendances = @user.attendances.where(opening_datetime: date_default.in_time_zone.all_month).order(:opening_datetime)
        end
      else
        if params[:attendance]
          date_search = "#{params[:attendance]["date_search(1i)"]}-#{params[:attendance]["date_search(2i)"]}-#{params[:attendance]["date_search(3i)"]}"
          @attendances = current_user.attendances.where(opening_datetime: date_search.in_time_zone.all_month).order(:opening_datetime)
        else
          date_default = "#{Date.today.year}-#{Date.today.month}-#{01}"
          @attendances = current_user.attendances.where(opening_datetime: date_default.in_time_zone.all_month).order(:opening_datetime)
        end
      end
    else
      if params[:attendance]
        date_search = "#{params[:attendance]["date_search(1i)"]}-#{params[:attendance]["date_search(2i)"]}-#{params[:attendance]["date_search(3i)"]}"
        @attendances = current_user.attendances.where(opening_datetime: date_search.in_time_zone.all_month).order(:opening_datetime)
      else
        date_default = "#{Date.today.year}-#{Date.today.month}-#{01}"
        @attendances = current_user.attendances.where(opening_datetime: date_default.in_time_zone.all_month).order(:opening_datetime)
      end
    end
  end

  def show
    @attendance.worktime_aggregates.build
    @user = @attendance.user
    opening_datetime_show = @attendance.opening_datetime  #入ってきたIDからopening_datetime取得
    opening_date = "#{opening_datetime_show.year}-#{opening_datetime_show.month}-#{01}" #成形
    if current_user.try(:admin?)
      @attendances = @user.attendances.where(opening_datetime: opening_date.in_time_zone.all_month).order(:opening_datetime)
    else
      @attendances = current_user.attendances.where(opening_datetime: opening_date.in_time_zone.all_month).order(:opening_datetime)
    end
  end

  def detail
    if current_user.try(:admin?)
      attendance = Attendance.find(params[:attendance_id])
      @user = attendance.user
      @attendance = @user.attendances.find(params[:attendance_id])
    else
      @attendance = current_user.attendances.find(params[:attendance_id])
    end
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
    @attendance = Attendance.new(attendance_params) #render 'new'に変数を渡すため
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
      redirect_to users_path,notice:"編集しました。"
    else
      render'edit'
    end
  end

  def destroy
    @attendance.destroy
    redirect_to users_path, notice:"削除しました"
  end

  def confirm
    @attendance = Attendance.new(attendances_params)
    render :new if @attendance.invalid?
  end

  private
    def attendance_params
      params.require(:attendance).permit(:opening_datetime,:closing_datetime,:over_time,:break_time,:holiday,:attendance_time,:date_search,:date,:user_id, worktime_aggregates_attributes:[:select_workplace, :construction_id,:constructiontime,:attendance_id,:construction])
    end
    def attendances_params #nested編集対応
      params.require(:attendance).permit(:opening_datetime,:closing_datetime,:over_time,:break_time,:holiday,:attendance_time,:date_search,:date,:user_id, worktime_aggregates_attributes:[:select_workplace, :construction_id,:constructiontime,:attendance_id,:_destroy,:construction,:id])
    end
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

end
