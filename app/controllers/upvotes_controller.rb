class UpvotesController < ApplicationController
	def remove
		post =  Post.find(upvote_params[:post_id])
		@upvote = current_user.upvotes.find_by(post_id: params[:post_id])
		@upvote.destroy
		post.upvote_count -= 1
		post.save
		render json: @upvote
	end
	def create
		post =  Post.find(upvote_params[:post_id])
		@upvote = current_user.upvotes.find_or_create_by(post_id: upvote_params[:post_id])
		post.upvote_count += 1
		post.save
		render json: @upvote
	end
	protected
		def upvote_params
			params.require(:upvote).permit(:post_id)
		end
end
