class ApiController < ApplicationController

	# from the application controller
  protect_from_forgery with: :null_session

	def index
		render :json => Muppet.all
	end

	def show
		render :json => Muppet.find(params[:id])
	end

	def create
		@muppet = Muppet.new(muppet_params)

		if @muppet.save
			render :json => @muppet
		else
			render :json => { :error => @muppet.errors.full_messages }, :status => 418
		end
	end

	def update
		@muppet = Muppet.find(params[:id])

		if @muppet.update(muppet_params)
			render :json => @muppet
		else
			render :json => { :error => @muppet.errors.full_messages }, :status => 418
		end
	end

	def destroy
		@muppet = Muppet.find(params[:id])

		if @muppet.destroy
			render :json => @muppet
		else
			render :json => { :error => @muppet.errors.full_messages }, :status => 418
		end
	end

	private

		def muppet_params
			params.permit(:name, :image_url)
		end

end
