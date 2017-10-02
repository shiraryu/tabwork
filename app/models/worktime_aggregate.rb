class WorktimeAggregate < ActiveRecord::Base

  belongs_to :attendance
  belongs_to :construction

end
