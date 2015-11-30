class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
  def index
  	if params[:sort].present? && params[:sort] == "latest"
  		@posts = Post.approved.paginate(page: params[:page], per_page: 5).order("created_at DESC")
  	else
  		@posts = Post.approved.where("upvote_count > 0").where('created_at >= ?', 1.week.ago).paginate(page: params[:page], per_page: 5).order("upvote_count DESC")
  	end
  	
		if @posts.length == 0
			respond_to do |format|
			  format.html
			  format.json{
			  	render json: {error: 'There are no posts left.'}, status: 404
			  }
			end
		else
		set_meta_tags({
  		:title => 'Hire and Retain Top LGBTQ Talent.',
      :description => 'A crowdsourced collection of best practices to hire and retain top LGBTQ talent.',
      :og => {
			  :title    => :title,
			  :type     => 'website',
			  :url      => root_url,
			  :image    => view_context.image_url("cover-divlist.jpg"),
			  :description => :description
			}
		})
			respond_to do |format|
				@posts = @posts.map{|post| post.current_user = current_user; post}
			  format.html
			  format.json{
			  	render json: @posts.as_json(:include => [ :tweet => {:include => :twitter_profile}], methods: [:upvote_count, :is_upvoted])
			  }
			end
		end
  end

  def pending
  	  	@posts = Post.pending.paginate(page: params[:page], per_page: 5).order('created_at DESC')
  	  	
  			if @posts.length == 0
  				respond_to do |format|
  				  format.html
  				  format.json{
  				  	render json: {error: 'There are no posts left.'}, status: 404
  				  }
  				end
  			else
  				respond_to do |format|
  				  format.html
  				  format.json{
  				  	render json: @posts.as_json(:include => [ :tweet => {:include => :twitter_profile}])
  				  }
  				end
  			end
  end

  def approve
  	@post = Post.find(params[:id])
  	@post.approve!
  	render json: @post
  end
  def show
 		@post = Post.friendly.find(params[:id])
  end
  protected
  	def post_params
  		params.require(:post).permit(:title, :content, :source)
  	end
end