require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class RetrieveDocumentSetRequestTest < Test::Unit::TestCase
  include XmlTestHelper
  context "A RetrieveDocumentSetRequest" do
    setup do
     
      @rdsr = XDS::RetrieveDocumentSetRequest.new
      @rdsr.add_ids_to_request('1.19.6.24.109.42.1', '129.6.58.91.13297')
      @rdsr.add_ids_to_request('1.19.6.24.109.42.1', '129.6.58.91.13298')
    end
    
    should "create a SOAP Body" do
      soap_body = @rdsr.to_soap_body(create_builder,'xmlns:soapenv' => "http://www.w3.org/2003/05/soap-envelope")
      assert soap_body
      assert_xpath(soap_body, "/soapenv:Body/xdsb:RetrieveDocumentSetRequest/xdsb:DocumentRequest/xdsb:RepositoryUniqueId[text()='1.19.6.24.109.42.1']", @common_namespaces, 2)
      assert_xpath(soap_body, "/soapenv:Body/xdsb:RetrieveDocumentSetRequest/xdsb:DocumentRequest/xdsb:DocumentUniqueId[text()='129.6.58.91.13297']", @common_namespaces)
      assert_xpath(soap_body, "/soapenv:Body/xdsb:RetrieveDocumentSetRequest/xdsb:DocumentRequest/xdsb:DocumentUniqueId[text()='129.6.58.91.13298']", @common_namespaces)
    end
    
  end
end