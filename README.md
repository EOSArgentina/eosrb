# eosrb 
## EOS RPC-API client

Seamlessly interact with the EOS blockchain to kickstart your Ruby/RoR project.

## Usage

```ruby
require 'eosrb'
    
# Defaults to  EOS::Client.new('http://localhost:8888')
c = EOS::Client.new
puts c.chain_get_info
```

## Instalation

    gem install eosrb
    
## Available methods

  Check the [API specs](specs/) for details but every RPC method available through the client by this simple example
  
    /v1/chain/get_info => chain_get_info
    
  in general
  
    /v1/endpoint/method => endpoint_method

## Credits

  Ruby implementation by [EOS Argentina](http://eosargentina.io/). API Specs based on [py-eos-api](https://github.com/Netherdrake/py-eos-api). 
