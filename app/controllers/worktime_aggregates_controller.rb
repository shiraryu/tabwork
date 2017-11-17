class WorktimeAggregatesController < ApplicationController

  def index
    @start_date = params[:start_date]
    @start_year = params[:start_year].to_i
    @start_month = params[:start_month].to_i
    @construction_id = params[:construction_id]  #view用

    @worktime_aggregates = WorktimeAggregate.sum_of_constructiontime(@construction_id, @start_date, @start_year, @start_month)
    @construction = Construction.find(params[:construction_id])

  end
end
