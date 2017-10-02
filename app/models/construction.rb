class Construction < ActiveRecord::Base
  validates:name,presence:true

  has_many :worktime_aggregates,dependent: :destroy
  belongs_to :workplace

end
