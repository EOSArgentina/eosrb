require 'minitest/autorun'
require './lib/eosrb.rb'

class EOSTest < Minitest::Test
  def tested_instance
    EOS::Client.new
  end

  def test_version
    assert_equal "v1", tested_instance.send(:version)
  end

  def test_spec_files
    assert_equal ['chain'], tested_instance.send(:spec_files)
  end

  def test_extract_endpoint
    assert_equal ['one','two_still_2'],
      tested_instance.send(:extract_endpoint,'one_two_still_2')
  end

  def test_fails_on_no_api
    assert_raises NoMethodError do
      tested_instance.noapi_method
    end
  end

  def test_fails_on_no_method
    assert_raises NoMethodError do
      tested_instance.chain_nomethod
    end
  end
end
