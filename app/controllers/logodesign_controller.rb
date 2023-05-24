require "base64"
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
    return render json: {error: "please pass logo"}, status: :unprocessable_entity unless params[:logo].present?
    if params[:base_64].present?
      logo =  { 
        io: StringIO.new(Base64.decode64(params[:logo][:data].split(',')[1])),
        content_type: 'image/jpeg',
        filename: params[:filename]
      }
      filename = params[:filename]
      filesize = Base64.decode64(params[:logo][:data].split(',')[1]).length
    else
      logo = params[:logo]
      filename = logo.original_filename
      filesize = logo.size
    end
    @logo_design = LogoDesign.new(filesize:filesize, filename:filename, account_id:@current_user.id, logo: logo )
    if @logo_design.save
      render json: {logo: @logo_design, url: url_for(@logo_design.logo) }, status: :ok
    else
      render json: @logo_design.errors, status: :unprocessable_entity
    end
  end

  def update
    return render json: {error: "please pass logo"} unless params[:logo].present?
    if params[:base_64].present?
      logo =  { 
        io: StringIO.new(Base64.decode64(params[:logo][:data].split(',')[1])),
        content_type: 'image/jpeg',
        filename: params[:filename]
      }
      filename = params[:filename]
      filesize = logo.size
    else
      logo = params[:logo]
      filename = logo.original_filename
      filesize = logo.size
    end
    if @logo_design.update(filesize:filesize, filename:filename, logo: logo)
      render json: {logo: @logo_design, url: url_for(@logo_design.logo) }, status: :ok
    else
      render json: @logo_design.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @logo_design.destroy
      render json: {massage: "Your logo has been deleted"}, status: :ok
    else
      render json: {massage: @logo_design.errors.messages}, status: :ok
    end
  end

  private
	def set_logo
		@logo_design = LogoDesign.find_by(id: params[:id])
		return render json: {error:"not found"}, status: :unprocessable_entity unless @logo_design
	end
end
