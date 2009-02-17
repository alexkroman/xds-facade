require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class RetrieveDocumentSetResponseTest < Test::Unit::TestCase
  context "A RetrieveDocumentSetRequest" do
    setup do
      @successful_request_xml = File.read(File.expand_path(File.dirname(__FILE__) + '/../data/successful_document_set_response.xml'))
    end
    
    should 'properly set the response status for a successful request' do
      rdsr = XDS::RetrieveDocumentSetResponse.new
      rdsr.parse_soap_response(@successful_request_xml)
      assert rdsr.request_successful?
    end
  end
end