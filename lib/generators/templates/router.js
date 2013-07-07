<%= application_name.camelize %>.config(['$routeProvider', function($routeProvider) {
  $routeProvider
    .when('/', 
      { controller: "homeCtrl", 
        templateUrl: '<%%= asset_path "home.html" %>'})
    .otherwise({redirectTo: '/'});
}]);
