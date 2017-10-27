class Attendance < ActiveRecord::Base
  include ActiveRecord::Calculations

  validates_presence_of :opening_datetime

  has_many :worktime_aggregates,dependent: :destroy
  has_many :worktime_aggregate_constructions,through: :worktime_aggregates,source: :construction
  belongs_to :user
  accepts_nested_attributes_for :worktime_aggregates, allow_destroy: true

  def sum_of_attendance_time
    (((closing_datetime - opening_datetime) / 60 / 60) - (break_time.to_f) - (over_time.to_f)).to_f
  end

  def attendance_time
    if sum_of_attendance_time > 8
      8.0
    elsif sum_of_attendance_time < 0
      0.0
    else
    (((closing_datetime - opening_datetime) / 60 / 60) - (break_time.to_f) - (over_time.to_f)).to_f
    end
  end

    def self.sum_of_attendance_date(attendances)  #出勤日数
      attendances.where(holiday: false).count
    end

    def self.sum_of_attendance_time_month(attendances)  #出勤時間合計
      attendances.sum(:attendance_time)
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
