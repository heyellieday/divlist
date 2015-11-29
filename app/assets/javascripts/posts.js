app.controller('PostsCtrl', ['$scope', '$location', '$http', 'Posts', '$location', function ($scope, $location, $http, Posts, $location) {
  $scope.posts = new Posts();

  $scope.toggleUpvote = function(post){
			if (post.is_upvoted == false){
				$http.post("/upvotes/", {post_id: post.id}).success(function(data){
					post.is_upvoted = true;
					post.upvote_count++;
				});
			}else{
				$http.post("/upvotes/remove", {post_id: post.id}).success(function(data){
					post.is_upvoted = false;
					post.upvote_count--;
				});
			}
  		
  };
}]);