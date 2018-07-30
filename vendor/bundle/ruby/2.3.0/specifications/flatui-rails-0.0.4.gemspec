# -*- encoding: utf-8 -*-
# stub: flatui-rails 0.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "flatui-rails".freeze
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotrek".freeze]
  s.date = "2013-03-25"
  s.description = "flat-ui for rails".freeze
  s.email = ["pkurek90@gmail.com".freeze]
  s.homepage = "".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2.3".freeze
  s.summary = "flat-ui for rails using sass".freeze

  s.installed_by_version = "2.5.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sass-rails>.freeze, [">= 3.2.0"])
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.1"])
      s.add_runtime_dependency(%q<bootstrap-sass>.freeze, ["= 2.2.2"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<sass-rails>.freeze, [">= 3.2.0"])
      s.add_dependency(%q<railties>.freeze, [">= 3.1"])
      s.add_dependency(%q<bootstrap-sass>.freeze, ["= 2.2.2"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<sass-rails>.freeze, [">= 3.2.0"])
    s.add_dependency(%q<railties>.freeze, [">= 3.1"])
    s.add_dependency(%q<bootstrap-sass>.freeze, ["= 2.2.2"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
