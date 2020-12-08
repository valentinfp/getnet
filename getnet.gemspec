# encoding: utf-8
require "./lib/getnet/version"

Gem::Specification.new do |s|
    s.name        = 'getnet'
    s.version     = Getnet::VERSION
    s.date        = '2020-12-08'
    s.summary     = "Biblioteca de integração com a Getnet"
    s.description = "Biblioteca de integração com a API do serviço de pagamentos da Getnet"
    s.authors     = ["Valentin F. Paes"]
    s.email       = 'valentin.paes0@gmail.com'
    s.files       = Dir['README.md', 'lib/**/*']
    s.homepage    =
      'https://rubygems.org/gems/getnet'
    s.license       = 'MIT'

    s.required_ruby_version = ">= 2.6.0"
end