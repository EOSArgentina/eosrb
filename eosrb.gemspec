Gem::Specification.new do |s|
  s.name        = 'eosrb'
  s.version     = '0.0.1'
  s.date        = '2018-06-11'
  s.summary     = "EOS RPC-API client"
  s.description = "Easily interact with the EOS blockchain-"
  s.authors     = ["RNGLab"]
  s.email       = 'root@rnglab.org'
  s.require_paths = ['lib']
  s.files       = ["lib/eosrb.rb", "specs/chain.json"]
  s.homepage    = 'http://github.com/EOSArgentina/eos'
  s.license     = 'MIT'
  s.add_runtime_dependency 'faraday'
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'net-http-persistent'
end
