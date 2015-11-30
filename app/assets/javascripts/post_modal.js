app.controller('PostModalInstanceCtrl', function ($scope, $uibModalInstance, post) {

  $scope.post = post

  $scope.ok = function () {
    $uibModalInstance.close($scope.post);
  };

  $scope.cancel = function () {
    $uibModalInstance.dismiss('cancel');
  };
});