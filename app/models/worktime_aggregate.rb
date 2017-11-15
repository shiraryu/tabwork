class WorktimeAggregate < ActiveRecord::Base
  belongs_to :attendance
  belongs_to :construction

  def self.sum_of_constructiontimes(construction_id, start_date = nil, start_year = nil, start_month = nil) #constructiontime月集計
    if start_date == nil && start_year == nil && start_month = nil #default
      joins(:attendance).where("attendances.opening_datetime >= :start AND attendances.opening_datetime <= :end", {start: Time.zone.today.beginning_of_month, end: Time.zone.today.end_of_month}).where(construction_id: construction_id).sum(:constructiontime)
    else
      end_date = Date.new(start_year,start_month,-1).to_s  #select
      joins(:attendance).where("attendances.opening_datetime >= :start AND attendances.opening_datetime <= :end", {start: start_date, end: end_date}).where(construction_id: construction_id).sum(:constructiontime)
    end
  end

  def self.sum_of_constructiontime(construction_id, start_date, start_year, start_month) #日毎集計
    results = []
    end_date = Date.new(start_year,start_month,-1) #paramsから月末計算
    end_day = (end_date).day #end_dateの日のみ取得
    (start_date.to_date..start_date.to_date + (end_day-1)).each do |day|  #日付のループ取得
      result = {}
      start_time = day.beginning_of_day.to_s
      end_time = day.end_of_day.to_s
      result[:day] = day
      result[:time] = joins(:attendance).where("attendances.opening_datetime >= :start AND attendances.opening_datetime <= :end", {start: start_time, end:  end_time}).where(construction_id: construction_id).sum(:constructiontime)
      results << result

    end
    results
    # days = (start_date.to_date..start_date.to_date + (end_day-1)).each {|da| puts da} #1日ごとのループ



      # start_time = Date.new(start_year,start_month,day).beginning_of_day.to_s
      # end_time = Date.new(start_year,start_month,day).end_of_day.to_s
      #
      # joins(:attendance).where("attendancesopening_datetime >= :start AND attendances.opening_datetime <= :end", {start: start_time, end:      end_time}).where(construction_id: construction_id).sum(:constructiontime)


  end

  def self.sum_of_constructiontime_sql
    sql = <<-SQL
    select attendances.date, sum(worktime_aggregates.constructiontime) from worktime_aggregates
    join attendances
    on worktime_aggregates.attendance_id = attendances.id
    where worktime_aggregates.construction_id = 2
    AND
    where
    group by attendances.date
    ;
    SQL
    ActiveRecord::Base.connection.select_all(sql)
    # result = self.select(sql)
    # return result
  end
end
