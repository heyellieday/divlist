app.controller('PostsCtrl', ['$scope', '$location', '$http', 'Posts', '$location','$rootScope', '$uibModal', function ($scope, $location, $http, Posts, $location, $rootScope, $uibModal) {
  $scope.posts = new Posts();

  $scope.toggleUpvote = function(post){
  	if ($rootScope.signedIn == true){

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
  	}else{
  		    var modalInstance = $uibModal.open({
  		      animation: true,
  		      templateUrl: 'myModalContent.html',
  		      controller: 'PostModalInstanceCtrl',
  		      resolve: {
  		        post: function () {
  		          return post;
  		        }
  		      }
  		    });

  		    modalInstance.result.then(function (selectedItem) {
  		      $scope.selected = selectedItem;
  		    }, function () {
  		      $log.info('Modal dismissed at: ' + new Date());
  		    });
  	}
  };
}]);