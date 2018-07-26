# eosrb
## EOS RPC-API client

Seamlessly interact with the EOS blockchain to kickstart your Ruby/RoR project.

## Usage

```ruby
require 'eosrb'

# Defaults to EOS::Client.new('http://localhost:8888')
c = EOS::Client.new
puts c.chain_get_info
```

### Connect to EOS Argentina

```ruby
# Connects to https://api,eosargentina,io
c = EOS::Client.ar
prods = c.chain_get_producers(json: true)['rows'].map { |p| p['owner'] }
puts prods.include?('argentinaeos') ? 'awsm!' : 'aycaramba!'
```

## Instalation

    gem install eosrb


### Build and install

    git clone git@github.com:EOSArgentina/eosrb.git
    cd eosrb
    gem build eosrb
    gem install eosrb-0.0.1.gem


## Available methods

  Check the [API specs](specs/) for details but every RPC method available through the client by this simple example

    /v1/chain/get_info => chain_get_info

  in general

    /v1/api/method => api_method

## Credits

  Ruby implementation by [EOS Argentina](http://eosargentina.io/). API Specs based on [py-eos-api](https://github.com/Netherdrake/py-eos-api) and [eosjs-api](https://github.com/EOSIO/eosjs-api).
