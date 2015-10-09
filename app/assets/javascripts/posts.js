app.controller('PostsCtrl', ['$scope', '$location', '$http', 'Posts', '$location', function ($scope, $location, $http, Posts, $location) {
  $scope.posts = new Posts();

  $scope.current_user_id = window.current_user_id;
  $scope.params = {user_id: $scope.current_user_id, post_id: null };

  $scope.registerPostEvents = function(){
  	if ($scope.current_user_id != null){
  		$('.favorite').off("click");
			$('.favorite').click(function(){
				if (!$(this).hasClass('favorited')){
					var post_id = $(this).attr('data-id');
					$scope.params.post_id = post_id;
					var data = {favorite: $scope.params};
		      $.ajax({
		         url: '/favorites',
		         type: 'POST',
		         dataType: "json",
		         contentType: "application/json",
		         data: JSON.stringify(data),
		         success: function(response) {
		         	var favorite = $(".favorite[data-id='" + post_id + "']");
		         	favorite.children().first().toggleClass('fa-heart-o');
							favorite.children().first().toggleClass('fa-heart');
		         }
		      });
				}
				$(this).toggleClass('favorited');

			});
			$('.upvotes').off("click");
			$('.upvotes').click(function(){
				if (!$(this).hasClass('upvoted')){
					var post_id = $(this).attr('data-id');
					$scope.params.post_id = post_id;
					var data = {upvote: $scope.params};
		      $.ajax({
		         url: '/upvotes',
		         type: 'POST',
		         dataType: "json",
		         contentType: "application/json",
		         data: JSON.stringify(data),
		         success: function(response) {
		         	var count = $(".count[data-id='" + post_id + "']");
		         	count.html(parseInt(count.html()) + 1);
							$(".upvotes[data-id='" + post_id + "']").toggleClass('upvoted');
		         }
		      });
				}

			});
  	}
  		
  };
}]);