class WorkplacesController < ApplicationController
  before_action :authenticate_user!        #ログイン有無のチェック
  before_action :set_workplace,only:[:show,:edit,:update,:destroy]

  def index
    @workplaces = Workplace.all
  end

  def new
    if params[:back]
      @workplace = Workplace.new(workplaces_params)
    else
      @workplace = Workplace.new
    end
  end

  def create
    @workplace = Workplace.new(workplaces_params)
    if @workplace.save
      redirect_to workplaces_path,notice:"新しい現場を登録しました。"
    else
      #入力フォーム再描写
      render'new'
    end
  end

  def edit
  end

  def update
    if @workplace.update(workplaces_params)
      redirect_to workplaces_path,notice:"編集しました。"
    else
      render'edit'
    end
  end

  def destroy
    @workplace.destroy
    redirect_to workplaces_path
  end

  def show
    @construction = @workplace.constructions.build   # 入力フォーム用インスタンス
    @constructions = @workplace.constructions        # 一覧用インスタンス
  end

  def confirm
    @workplace = Workplace.new(workplaces_params)
    render :new if @workplace.invalid?
  end

  private
    def workplaces_params
      params.require(:workplace).permit(:name)
    end
    def set_workplace
      @workplace = Workplace.find(params[:id])
    end
end
