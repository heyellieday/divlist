class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
  def index

  	@posts = Post.paginate(page: params[:page], per_page: 5).order('created_at DESC')
  	
		if @posts.length == 0
			respond_to do |format|
			  format.html
			  format.json{
			  	render json: {error: 'There are no posts left.'}, status: 404
			  }
			end
		else
		set_meta_tags({
  		:title => 'Bringing together impactful communities.',
      :description => 'Karmafuse is a collection of socially-forward communities where members can share and discuss relevant topics.',
      :og => {
			  :title    => :title,
			  :type     => 'website',
			  :url      => root_url,
			  :image    => view_context.image_url("fb-background.png"),
			  :description => :description
			}
		})
			respond_to do |format|
			  format.html
			  format.json{
			  	render json: @posts.as_json(:include => [ :tweet => {:include => :twitter_profile}])
			  }
			end
		end
  end
  def create
  	@post = Post.create(post_params)
  end
  def new
  	@post = Post.new
  end
  def show
 		@post = Post.friendly.find(params[:id])
  end
  protected
  	def post_params
  		params.require(:post).permit(:title, :content, :source)
  	end
end