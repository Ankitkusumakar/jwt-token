class LangController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
		@langs = Lang.all
		render json: @langs, status: :ok
	end

	def show
		@lang = Lang.find(params[:id])
		render json: @lang, status: :ok
	end

	def current_language
    language = @current_user.user_lang ? @current_user.user_lang.lang : Lang.find_or_create_by(name: "english")
    render json: language, status: :ok
  end

	def update_current_language
    begin
      @current_user.user_lang.present? ? @current_user.user_lang.update(lang_params) : @current_user.create_user_lang(lang_params)
      render json: { message: "Language updated successfully", language: @current_user.user_lang.lang }
    rescue
      render json: {message: "Some error "}, status: :unprocessable_entity
    end
  end

  private
  def lang_params
    params.permit(:lang_id)
  end

end
