class Construction < ActiveRecord::Base
  validates:name,presence:true

  has_many :worktime_aggregates_attendances,through: :worktime_aggregates,source: :attendance
  has_many :worktime_aggregates
  belongs_to :workplace

end
