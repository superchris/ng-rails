<%= application_name.camelize %>.config ["$httpProvider", (provider) ->
  provider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")
]
