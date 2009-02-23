require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class RegistryStoredQueryResponseTest < Test::Unit::TestCase
  context "A RegistryStoredQueryResponse" do
    setup do
      @successful_request_xml = File.read(File.expand_path(File.dirname(__FILE__) + '/../data/query_response.xml'))
    end
    
    should 'properly set the response status for a successful request' do
      rsqr = XDS::RegistryStoredQueryResponse.new
      rsqr.parse_soap_response(@successful_request_xml)
      assert rsqr.request_successful?
    end
    
    should 'properly parse out the information on the document' do
      rsqr = XDS::RegistryStoredQueryResponse.new
      rsqr.parse_soap_response(@successful_request_xml)
      assert rsqr.request_successful?
      rmd = rsqr.retrieved_metadata
      assert rmd
      assert_equal 5, rmd.length
      md = rmd.first
      assert_equal '^Smitty^Gerald^^^', md.author.person
      assert_equal 'Connect-a-thon classCodes', md.class_code.coding_scheme
    end
  end
end