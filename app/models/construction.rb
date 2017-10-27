class Construction < ActiveRecord::Base
  validates:name,presence:true

  has_many :worktime_aggregates_attendances,through: :worktime_aggregates,source: :attendances
  belongs_to :workplace

end
