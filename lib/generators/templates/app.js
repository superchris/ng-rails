
angular.module("<%= application_name.underscore %>.resources", ["ngResource"]);

angular.module("<%= application_name.underscore %>.services", ["ngResource"]);

angular.module("<%= application_name.underscore %>.directives", []);

angular.module("<%= application_name.underscore %>.filters", []);

angular.module("<%= application_name.underscore %>.controllers", []);

this.<%= application_name.camelize %> = angular.module("<%= application_name.underscore %>", ["<%= application_name.underscore %>.resources", "<%= application_name.underscore %>.services", "<%= application_name.underscore %>.directives", "<%= application_name.underscore %>.filters", "<%= application_name.underscore %>.controllers"]);
