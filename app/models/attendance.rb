class Attendance < ActiveRecord::Base
  include ActiveRecord::Calculations

  before_save :date_column,:attendance_time

  has_many :worktime_aggregates,dependent: :destroy
  has_many :worktime_aggregate_constructions,through: :worktime_aggregates,source: :construction
  belongs_to :user
  accepts_nested_attributes_for :worktime_aggregates,reject_if: :reject_worktime_aggregates, allow_destroy: true

  validates_presence_of :opening_datetime,:closing_datetime,:over_time,:break_time,if: :holiday_false?

  def holiday_false?
    #binding.pry
    holiday == false
  end

  validates_presence_of :opening_datetime,if: :holiday_true?

  def holiday_true?
    holiday == true
  end

  def reject_worktime_aggregates(attributes)
    exists = attributes[:id].present?
    empty = attributes[:constructiontime].blank?
    attributes.merge!(_destroy: 1) if exists && empty
    !exists && empty
  end

  def sum_of_attendance_time
    unless closing_datetime == nil
      (((closing_datetime - opening_datetime) / 60 / 60) - (break_time.to_f) - (over_time.to_f)).to_f
    end
  end

  def attendance_time
    unless closing_datetime == nil
      if sum_of_attendance_time > 8
        time = 8.0
      elsif sum_of_attendance_time < 0
        time = 0.0
      else
        time = (((closing_datetime - opening_datetime) / 60 / 60) - (break_time.to_f) - (over_time.to_f)).to_f
      end
      write_attribute(:attendance_time, time)  #attendance_timeカラムにsave前に値を代入（書き込み）
    end
  end

  def date_column  #dateカラムに成形して保存
    date = read_attribute(:opening_datetime).to_date
    write_attribute(:date, date)
  end


  def self.sum_of_attendance_date(attendances)  #出勤日数
    attendances.where(holiday: false).count
  end
  def self.sum_of_attendance_time_month(attendances)  #出勤時間合計
    attendances.sum(:attendance_time)
    #binding.pry
  end
  def self.sum_of_break_time(attendances)  #休憩時間合計
    attendances.sum(:break_time)
  end
  def self.sum_of_over_time(attendances)  #残業合計
    attendances.sum(:over_time)
  end
  def self.sum_of_holiday(attendances)  #休暇日数合計
    attendances.where(holiday: true).count
  end

end
