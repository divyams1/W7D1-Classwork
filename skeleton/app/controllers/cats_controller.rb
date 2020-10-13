class CatsController < ApplicationController
  before_action :ensure_logged_in
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    # @cat = Cat.new(cat_params)
    cat = current_user.cats.new(cat_params)
    if cat.save
      redirect_to cat_url(cat)
    else
      flash.now[:errors] = cat.errors.full_messages
      render :new
    end
  end

  def edit  
                      
    @cat = Cat.find(params[:id])
    @cats = current_user.cats
    if @cats.include?(@cat)
      render :edit
    else 
      redirect_to cats_url 
    end 
  end

  def update
    @cat = Cat.find(params[:id])
    @cats = current_user.cats 
    if @cats.include?(@cat)
      if @cat.update_attributes(cat_params)
        redirect_to cat_url(@cat)
      else
        flash.now[:errors] = @cat.errors.full_messages
        render :edit
      end
    else 
      redirect_to cats_url 
    end 
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex)
  end
end
