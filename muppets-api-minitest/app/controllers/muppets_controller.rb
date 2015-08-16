class MuppetsController < ApplicationController
  def index
    @muppets = Muppet.all
  end

  def show
    @muppet = Muppet.find(params[:id])
  end

  def new
    @muppet = Muppet.new
  end

  def create
    @muppet = Muppet.new(muppet_params)
    
    if @muppet.save
      redirect_to @muppet
    else
      render :new
    end
  end

  def edit
    @muppet = Muppet.find(params[:id])
  end

  def update
    @muppet = Muppet.find(params[:id])
    
    if @muppet.update(muppet_params)
      redirect_to @muppet
    else
      render :edit
    end
  end

  def destroy
    @muppet = Muppet.find(params[:id])
    if @muppet.destroy
      redirect_to muppets_path
    else
      render :edit
    end
  end

  def client
  end
  
  private

  def muppet_params
    params.require(:muppet).permit(:name, :image_url)
  end
end