class SpendController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :set_spend, only: [:show, :destroy, :update]

	def index
		@spends = Spend.where("strftime('%Y', spend_date) = ?", params[:year])
		total_amount = @spends.sum(:amount)
		if @spends.present?
			render json: { spends: @spends, total: total_amount }, status: :ok
		else
			render json: { spends: [], total: 0 }, status: :not_found
		end
	end

	def recent_spends
		@spends = Spend.last(10)
		render json: @spends, status: :ok
	end

	def transactions
    @spends = Spend.all.page(params[:page]).per(params[:per_page])
		render json: {spends: @spends, meta: {
			total_pages: @spends.total_pages,
			current_page: @spends.current_page,
			next_page: @spends.next_page,
			prev_page: @spends.prev_page,
			total_count: @spends.total_count
		}},status: :ok
  end

	def show
		 render json: @spend, status: :ok
	end

	def create
		@spend = Spend.new(spend_params)
		if @spend.save
			render json: @spend, status: :created
		else
			render json: { errors: @spend.errors.full_messages},
			status: :unprocessable_entity
		end
	end

	def update
		if @spend.update(spend_params)
      render json: @spend, status: :ok
    else
      render json: { errors: @spend.errors.full_messages},
			status: :unprocessable_entity
    end
	end

	def destroy
		@spend.destroy
		render json: { mes @logo_design = LogoDesign.update(filesize:filesize, filename:filename, account_id:@current_user.id,)sage: "spend deleted successfully"}, status: :ok
	end

	private
	def spend_params
		params.permit(:account_id, :name, :amount, :spend_date, :is_active)
	end

	def set_spend
		@spend = Spend.find_by(id: params[:id])
		return render json: {error:"spend not found"} unless @spend
	end
end