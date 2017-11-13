class WorktimeAggregate < ActiveRecord::Base

  belongs_to :attendance
  belongs_to :construction

  def self.sum_of_constructiontime
    sql = <<-SQL
    select *, sum_constructiontime from worktime_aggregates
    join attendances
    on worktime_aggregates.attendance_id = attendances.attendance_id
    where worktime_aggregates.construction_id = :construction_id , {construction_id: construction_id}
    group by attendances.date
    ;
    SQL

    result = self.select(sql)
    return result
  end
end
