require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class AffinityDomainConfigTest < Test::Unit::TestCase
  context "XDS::AffinityDomainConfig" do
    setup do
      @adc = XDS::AffinityDomainConfig.new(File.expand_path(File.dirname(__FILE__) + '/../data/affinity_domain_config.xml'))
    end
    
    should "find a coded attribute" do
      ca = @adc.coded_attribute(:format_code, 'PDF')
      assert ca
      assert_equal 'PDF', ca.code
      assert_equal 'PDF', ca.display_name
      assert_equal 'Connect-a-thon formatCodes', ca.coding_scheme
    end
    
    should "provide select options" do
      options = @adc.select_options(:confidentiality_code)
      assert options
      first_option = options.first
      assert first_option
      assert_equal 'Celebrity', first_option[0]
      assert_equal 'C', first_option[1]
    end
  end
end