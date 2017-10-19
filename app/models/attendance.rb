class Attendance < ActiveRecord::Base

  validates_presence_of :opening_datetime

  has_many :worktime_aggregates,dependent: :destroy
  has_many :worktime_aggregate_constructions,through: :worktime_aggregates,source: :constructions
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

end
