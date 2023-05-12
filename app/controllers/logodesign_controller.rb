class LogodesignController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :set_logo, only: [:show, :destroy, :update]

  def index
    @logo_designs = LogoDesign.all
    render json: @logo_designs, status: :ok
  end

  def show
    render json: {logo: @logo_design, url: url_for(@logo_design.logo) }, status: :ok
  end

  def create
    logo = params[:logo]
    filename = logo.original_filename
    filesize = logo.size
    @logo_design = LogoDesign.new(filesize:filesize, filename:filename, account_id:@current_user.id, logo: logo )
    if @logo_design.save
      render json: {logo: @logo_design, url: url_for(@logo_design.logo) }, status: :ok
    else
      render json: @logo_design.errors, status: :unprocessable_entity
    end
  end

  def update
      logo = params[:logo]
      filename = logo.original_filename
      filesize = logo.size
    if @logo_design.update(filesize:filesize, filename:filename, logo: logo)
      render json: {logo: @logo_design, url: url_for(@logo_design.logo) }, status: :ok
    else
      render json: @logo_design.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @logo_design.destroy
    render json: {massage: "Your logo has been deleted"}, status: :ok
  end

  private
	def set_logo
		@logo_design = LogoDesign.find_by(id: params[:id])
		return render json: {error:"not found"} unless @logo_design
	end
end
