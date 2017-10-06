class Attendance < ActiveRecord::Base

  validates:opening_datetime,presence:true

  has_many :worktime_aggregates,dependent: :destroy
  has_many :worktime_aggregate_constructions,through: :worktime_aggregates,source: :constructions
  belongs_to :user
  accepts_nested_attributes_for :worktime_aggregates, allow_destroy: true

end
