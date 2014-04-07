# -*- encoding: utf-8 -*-
# stub: spree_robokassa 0.0.1.alfa ruby lib

Gem::Specification.new do |s|
  s.name = "spree_robokassa"
  s.version = "0.0.1.alfa"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Artem Aminov"]
  s.date = "2014-04-04"
  s.description = "Robokassa gem for Spree. Integrates Robokassa payment"
  s.email = ["artemaminov@gmail.com"]
  s.files = [".gitignore", "Gemfile", "LICENSE.txt", "README.md", "Rakefile", "app/controllers/spree/checkout_controller_decorator.rb", "app/controllers/spree/robokassa_controller.rb", "app/models/spree/billing_integration/robokassa.rb", "app/models/spree/billing_integration_decorator.rb", "app/models/spree/order_decorator.rb", "app/views/spree/admin/payments/source_views/_robokassa.html.erb", "app/views/spree/checkout/payment/_robokassa.html.erb", "app/views/spree/robokassa/show.html.erb", "config/locales/en.yml", "config/locales/ru.yml", "config/routes.rb", "lib/spree_robokassa.rb", "lib/spree_robokassa/engine.rb", "lib/spree_robokassa/version.rb", "spree_robokassa.gemspec"]
  s.homepage = "http://github.com/artemaminov/spree_robokassa.git"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Add Robokassa payment to Spree"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
