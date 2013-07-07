# ng-rails [![Build Status](https://travis-ci.org/janders223/ng-rails.png)](https://travis-ci.org/janders223/ng-rails) [![Dependency Status](https://gemnasium.com/janders223/ng-rails.png)](https://gemnasium.com/janders223/ng-rails)

ng-rails allows you to easily include [AngularJS](http://angularjs.org/) in your Rails 4+ project.

ng-rails aims to provide generators with a sane default configuration for getting an AngularJS app up and running easily.

## Getting Started

1. Add ng-rails to your application's Gemfile:

```ruby
gem 'ng-rails'
```

2. And then execute:

```bash
$ bundle install
```

3. Generate your AngularJS app

```bash
$ rails generate ng:bootstrap
```

The bootstrap generator can take several options to customize the application to suit your needs.

#### App Name

As ng-rails aims to provide a set of sane defaults, the name of your AngularJS app will default to the same name as your Rails application. Should you desire a different application name, pass the `-n` flag and the name you desire to the generator.

```bash
$ rails generate ng:bootstrap -n MyApp
```

#### Javascript

By default ng-rails will generate assets in coffeescript. If you prefer to write in pure javascript, pass the `--js` flag to the generator.

```bash
$ rails generate ng:bootstrap --js
```

#### CDN

AngularJS prefers to be run from the AngularJS CDN. By default, ng-rails will load `angular.min` and `angular-resource.min` from it's included `vendor/assets` directory. If you choose to use the CDN, pass the `-c` flag to the generator.

```bash
$ rails generate ng:bootstrap -c
```

#### Unstable Angular

AngularJS is always available in both stable and unstable versions. ng-rails ships with options for including one or the other. If you like to live on the edge, you can include the latest unstable build of AngularJS by using the `-u` flag.

```bash
$ rails generate ng:bootstrap -u
```

## Notes

Once ng-rails is *'complete'*  the version number will be made to mimic that of the latest stable build of AngularJS.

Please keep in mind that this is the best configuration that I have found for running an AngularJS app from sprockets/rails. It is a tried and true method with a couple of production apps running this way. If you find a better way of setting something up, please contribute following the guidelines below.

## Contributing

1. Fork the project.
2. Make your feature addition or bug fix.
3. Add tests for it. This ensures that your changes do not break something, or something else does not break your changes in the future.
4. Commit, do not mess with Rakefile, or version.
5. Create new Pull Request. Bonus points for topic branches.
