require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class RetrieveDocumentSetRequestTest < Test::Unit::TestCase
  include XmlTestHelper
  context "A RetrieveDocumentSetRequest" do
    setup do
      @rdsr = XDS::RetrieveDocumentSetRequest.new("http://129.6.24.109:9080/axis2xop/services/xdsrepositoryb")
      @rdsr.add_ids_to_request('1.19.6.24.109.42.1', '229.6.58.29.939')
      @rdsr.add_ids_to_request('1.19.6.24.109.42.1', '229.6.58.29.937')
    end
    
    should "create a SOAP Body" do
      soap_body = @rdsr.to_soap_body(create_builder,'xmlns:soapenv' => "http://www.w3.org/2003/05/soap-envelope")
      assert soap_body
      assert_xpath(soap_body, "/soapenv:Body/xdsb:RetrieveDocumentSetRequest/xdsb:DocumentRequest/xdsb:RepositoryUniqueId[text()='1.19.6.24.109.42.1']", common_namespaces, 2)
      assert_xpath(soap_body, "/soapenv:Body/xdsb:RetrieveDocumentSetRequest/xdsb:DocumentRequest/xdsb:DocumentUniqueId[text()='229.6.58.29.939']", common_namespaces)
      assert_xpath(soap_body, "/soapenv:Body/xdsb:RetrieveDocumentSetRequest/xdsb:DocumentRequest/xdsb:DocumentUniqueId[text()='229.6.58.29.937']", common_namespaces)
    end
    
    should "query the NIST Public Registry" do
      docs = @rdsr.execute
      assert docs
      assert_equal 2, docs.length
      assert_equal '1.19.6.24.109.42.1', docs.first[:repository_unique_id]
      assert_equal '229.6.58.29.939', docs.first[:document_unique_id]
      assert docs.first[:content]
    end
    
  end
end