var autolinker = new Autolinker({hashtag: "twitter", newWindow: true});

var app = angular.module('app', [ 'infinite-scroll', 'ui.bootstrap']);

app.run(['$rootScope', '$sce', function($rootScope, $sce){
  $rootScope.prettifyDate = function(date){
      return moment(date).format("MMM Do YYYY");
  };
  $rootScope.permalink = function(post){
    return "/posts/" + post.slug;
  };
  $rootScope.renderSrc = function(url){
    console.log(url);
    return $sce.trustAsResourceUrl(url);
  }
  $rootScope.autoLinkContent = function(content){
    var linkedText = autolinker.link(content);
    return $sce.trustAsHtml(linkedText);
  }

  $rootScope.signedIn = window.signedIn;

}]);

app.run(function(){
  Array.prototype.remove = function(from, to) {
    var rest = this.slice((to || from) + 1 || this.length);
    this.length = from < 0 ? this.length + from : from;
    return this.push.apply(this, rest);
  };
});

app.config(['$httpProvider', function($httpProvider) {
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');


}]);

app.filter('cut', [function () {
        return function (value, wordwise, max, tail) {
            if (!value) return '';

            max = parseInt(max, 10);
            if (!max) return value;
            if (value.length <= max) return value;

            value = value.substr(0, max);
            if (wordwise) {
                var lastspace = value.lastIndexOf(' ');
                if (lastspace != -1) {
                    value = value.substr(0, lastspace);
                }
            }

            return value + (tail || ' …');
        };
    }]);
app.filter('unsafe',['$sce', function($sce) {
    return function(val) {
        return $sce.trustAsHtml(val);
    };
}]);

app.factory('PendingPosts',['$http', '$location', function($http, $location) {
  var Posts = function(scope) {
    this.posts = [];
    this.busy = false;
    this.after = 1;
  };


  Posts.prototype.nextPage = function() {
    if (this.busy) return;
    this.busy = true;
    var url = "";

    url = '/dashboard/posts/pending?format=json&page='+this.after;
    $http.get(url).success(function(data) {
      var posts = data;
      for (var i = 0; i < posts.length; i++) {
        this.posts.push(posts[i]);
      }
      this.after++;
      this.busy = false;
    }.bind(this));
  };
  return Posts;
}]);

app.factory('Posts',['$http', '$location', function($http, $location) {
  var Posts = function(scope) {
    this.posts = [];
    this.busy = false;
    this.after = 1;
  };

  var getUrlVars = function()
  {
      var vars = [], hash;
      var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
      for(var i = 0; i < hashes.length; i++)
      {
          hash = hashes[i].split('=');
          vars.push(hash[0]);
          vars[hash[0]] = hash[1];
      }
      return vars;
  }

  Posts.prototype.nextPage = function() {
    if (this.busy) return;
    this.busy = true;
    var url = "";

    url = '/?format=json&page='+this.after;
    queryParams = getUrlVars();
    for(i in queryParams){
        url += "&"+i+"="+queryParams[i];
    };
    $http.get(url).success(function(data) {
      var posts = data;
      for (var i = 0; i < posts.length; i++) {
        this.posts.push(posts[i]);
      }
      this.after++;
      this.busy = false;
    }.bind(this));
  };
  return Posts;
}]);