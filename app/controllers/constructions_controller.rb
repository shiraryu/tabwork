class ConstructionsController < ApplicationController
  before_action :set_construction,only:[:edit,:update,:destroy]
  # constructionを保存、投稿するためのアクション

  def consttime
    @construction = Construction.new  #select_form
    @constructions = Construction.all
    #@attendances = @construction.worktime_aggregates_attendances.all
    #if params[:construction]
      #constdate_search = "#{params[:construction]["constdate_search(1i)"]}-#{params[:construction]["constdate_search(2i)"]}-#{params[:construction]["constdate_search(3i)"]}"
      #@constructions = @attendances.where(opening_datetime: constdate_search.in_time_zone.all_month).order(:opening_datetime)
    #else
      #constdate_default = "#{Date.today.year}-#{Date.today.month}-#{01}"
      #@constructions = @attendances.where(opening_datetime: constdate_default.in_time_zone.all_month).order(:opening_datetime)
    #end
  end

  def consttime_detail
    @construction = Construction.find(params[:construction_id])
    @construction.worktime_aggregates.build
    @constructions = Construction.all
  end

  def create
    # workplace_idをパラメータの値から探し出し,workplaceに紐づくconstructionsとしてbuild
    @construction = Construction.new(construction_params)
    @workplace = @construction.workplace
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @construction.save
        format.html { redirect_to workplace_path(@workplace), notice: '工事を登録しました。' }
        format.js{render :index}
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
      respond_to do |format|
        if @construction.update(construction_params)
          format.html {redirect_to workplace_path(@construction.workplace), notice:"工事名を編集しました"}
        else
          format.html { render :edit }
        end
      end
  end

  def destroy
    respond_to do |format|
      if @construction.destroy
        format.js { render :index }  # JS形式でレスポンスを返す
      else
        format.html { render :new }
      end
    end
  end

  def get_construction
    @constructions = Construction.where(workplace_id: params[:workplace_id])
    @select = params[:select_id]
    @category = params[:category_id]
    render 'get_construction'
  end

  private
    def construction_params
      params.require(:construction).permit(:workplace_id, :name,:constdate_search)
    end
    def set_construction
      @construction = Construction.find(params[:id])
    end
end
