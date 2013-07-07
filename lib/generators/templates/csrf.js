<%= application_name.camelize %>.config([
  "$httpProvider", function(provider) {
    return provider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content");
  }
]);
