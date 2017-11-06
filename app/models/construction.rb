class Construction < ActiveRecord::Base
  validates:name,presence:true

  has_many :worktime_aggregates_attendances,through: :worktime_aggregates,source: :attendance
  has_many :worktime_aggregates
  belongs_to :workplace

  def self.sum_of_constructiontime_date(constructions)  #出勤日数
    constructions.sum(:constructiontime)
  end

end
