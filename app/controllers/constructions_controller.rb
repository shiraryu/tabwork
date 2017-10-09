class ConstructionsController < ApplicationController
  before_action :set_construction,only:[:edit,:update,:destroy]
  # constructionを保存、投稿するためのアクション
  def create
    # workplace_idをパラメータの値から探し出し,workplaceに紐づくconstructionsとしてbuildする
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
          format.html {redirect_to workplace_path(@construction.workplace), notice:"工事名を編集しました！"}
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
    render 'get_construction'
  end

  private
    def construction_params
      params.require(:construction).permit(:workplace_id, :name)
    end
    def set_construction
      @construction = Construction.find(params[:id])
    end
end
