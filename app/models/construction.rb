class Construction < ActiveRecord::Base

  validates:name,presence:true

  #validates_associated :worktime_aggregates_attendances,:worktime_aggregates,:workplace

  has_many :worktime_aggregates_attendances,through: :worktime_aggregates,source: :attendance
  has_many :worktime_aggregates
  belongs_to :workplace,:inverse_of => :constructions #validate時に必要


end
