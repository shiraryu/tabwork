class WorktimeAggregatesController < ApplicationController

  def index
    @worktime_aggregates = WorktimeAggregate.sum_of_constructiontime
  end
end

#.find(params[:construction_id])
