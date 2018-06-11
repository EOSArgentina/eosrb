require 'json'
require 'faraday'

module EOS
  class Client

    def initialize(server='http://localhost:8888')
      @server = server
      load_specs
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
        api_call(method_name, args)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      api, endpoint = extract_endpoint(method_name)
      @specs.key?(api) && @specs[api].key?(endpoint)
    end

    def extract_endpoint(name)
      name.to_s.split('_',2)
    end

    # The actual http call
    def api_call(method_name, args)
      api, endpoint = extract_endpoint(method_name)
      body = {}
      @specs[api][endpoint]['params'].to_a.each do |type, param_name|
        body[param_name] = args.shift
      end

      response = connection.post "/#{version}/#{api}/#{endpoint}", body.to_json

      JSON.parse(response.body)
    end
  end
end
