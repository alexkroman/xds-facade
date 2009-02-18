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
    
    should 'properly parse out the information on the document' do
      rdsr = XDS::RetrieveDocumentSetResponse.new
      rdsr.parse_soap_response(@successful_request_xml)
      assert rdsr.request_successful?
      rds = rdsr.retrieved_documents
      assert rds
      assert_equal 1, rds.length
      rd = rds.first
      assert_equal "1.urn:uuid:3BE45FAC62CF0568A81199380869990@apache.org", rd[:content_id]
      assert_equal '1.19.6.24.109.42.1', rd[:repository_unique_id]
      assert_equal '1.2.3.4.100000022002209036.1196211173506.1', rd[:document_unique_id]
    end
  end
end