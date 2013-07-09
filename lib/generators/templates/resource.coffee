# This is a resource generated from ng-rails
# While this should be sufficient to interact with a RESTful Rails controller
# should your application may require further customizations plese read
# http://docs.angularjs.org/api/ngResource.$resource for further information

<%= application_name.camelize %>.factory "<%= file_name.camelize %>", ['$resource', ($resource) ->
  $resource(
    "/<%= file_name.underscore %>/:id",
    { id: "@id" },
    { 
      'create': { method: 'POST' }, 
      'index': { method: 'GET', isArray: true }, 
      'show': { method: 'GET', isArray: false }, 
      'update': { method: 'PUT' }, 
      'destroy': { method: 'DELETE' } 
    }
  )
]
