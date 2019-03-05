class SubsController < ApplicationController
  before_action :require_log_in

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user.id    
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update 
    @sub = current_user.subs.find(params[:id])
    if @sub 
      if @sub.update(sub_params)
        redirect_to sub_url(@sub)
      else
        flash.now[:errors] = @sub.errors.full_messages
        render :edit
      end
    else
      flash[:errors] = ["Can't edit subs you didn't create"]
      redirect_to subs_url
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end