require 'json'
require 'faraday'

module EOS
  class Client

    def initialize(server='http://localhost:8888', hc=false)
      @server = server
      @hc = hc
      load_specs
    end

    def self.ar
      new('https://api.eosargentina.io')
    end

    private

    def connection
      @connection ||= Faraday.new(@server){|f| f.adapter :net_http_persistent }
    end

    def version
      'v1'
    end

    # Load API specification from spec files

    def load_specs
      @specs = {}
      spec_files.each do |name|
        @specs[name] = read_spec(name)
      end
    end

    def specs_path
      "#{File.dirname __dir__}/specs/"
    end

    def spec_files
      Dir["#{specs_path}*"].map{|filename| File.basename(filename, '.json') }.compact
    end

    def read_spec(name)
      JSON.parse(File.read("#{specs_path}#{name}.json"))
    end

    # Add API methods to class for seamless usage

    def method_missing(method_name, *args, &block)
      if respond_to_missing?(method_name)
        api_call(method_name, args.first)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      return true if @hc
      api, endpoint = extract_endpoint(method_name)
      @specs.key?(api) && @specs[api].key?(endpoint)
    end

    def extract_endpoint(name)
      name.to_s.split('_',2)
    end

    def known_params(method_name)
      api, endpoint = extract_endpoint(method_name)
      return {} unless @specs[api] && @specs[api][endpoint]
      @specs[api][endpoint]['params'] || {}
    end

    def path(method_name)
      api, endpoint = extract_endpoint(method_name)
      "/#{version}/#{api}/#{endpoint}"
    end

    # The actual http call
    def api_call(method_name, args)
      args ||= {}
      known = known_params(method_name)
      body = @hc ? args : args.select{ |key, _| known.include?(key.to_s) }
      post path(method_name), body
    end

    def post(path, body)
      headers = {'Content-Type' => 'application/json'}
      response = connection.post path, body.to_json, headers
      JSON.parse(response.body)
    end
  end
end
