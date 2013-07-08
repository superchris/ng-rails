// This is a directive stub generated from ng-rails
// The most common options when creating a directive have been provided with
// explanation. Should your directive need to be more complex, please read
// http://docs.angularjs.org/guide/directive

<%= application_name.camelize %>.directive("<%= file_name %>", function() {
  return {
    // Set the priority in which multiple directives are loaded into the DOM.
    // Priority is defined as a number, with higher values being loaded first.
    // priority: 0,

    // Replaces the element with the template HTML string. Normal scope binding {}
    // can be used in the template string.
    template: '<div></div>',

    // The same as template, but loaded from the specified URL.
    // templateUrl: 'directive.html',

    // if set to true, the template will replace the current element rather than
    // append to the element.
    replace: false,

    // Restrict the directive to allowed attributes:
    //   * E - Element name: <my-directive></my-directive>  
    //   * A - Attribute: <div my-directive="exp"> </div>  
    //   * C - Class: <div class="my-directive: exp;"></div>  
    //   * M - Comment: <!-- directive: my-directive exp -->
    // Restrict attributes can be combined to allow multiple formats, i.e. 'EA',
    // would allow it to be either an element or attribute.  
    restrict: 'A',

    // Set the scope of the directive:
    //   * true - Creates a new scope for this directive
    //   * {} - Creates a new isolate scope for this directive
    //   * @ - Binds the local scope to a DOM attr
    //       - Given <widget my-attr="hello {{name}}"> and scope: { local: @myAttr}
    //         sets local to the value of {{name}}
    //   * = - Creates bi-directional binding between a property on the local scope
    //         and the parent scope
    //       - Given <widget my-attr="parentModel"> and scope: { local:'=myAttr' }
    //         scope will be shared between the directive and the parent scope
    // scope: false,

    link: function(scope, element, attrs) {}
      // Your custom code goes here...

  };
});
