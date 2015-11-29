app.controller('PendingPostsCtrl', ['$scope', '$location', '$http', 'PendingPosts', '$location', function ($scope, $location, $http, PendingPosts, $location) {
  $scope.posts = new PendingPosts();

  $scope.approve = function(post_id, index){
  	$scope.posts.posts.remove(index);
		$http.post("/dashboard/posts/approve", {id: post_id}).success(function(data){
		});
	}

}]);