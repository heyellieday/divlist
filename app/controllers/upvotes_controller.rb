class UpvotesController < ApplicationController
	def remove
		@upvote = current_user.upvotes.find_by(post_id: params[:post_id])
		@upvote.destroy
		render json: @upvote
	end
	def create
		@upvote = current_user.upvotes.find_or_create_by(post_id: upvote_params[:post_id])
		render json: @upvote
	end
	protected
		def upvote_params
			params.require(:upvote).permit(:post_id)
		end
end
