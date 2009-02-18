require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class RegistryStoredQueryRequestTest < Test::Unit::TestCase
  include XmlTestHelper
  context "A RegistryStoredQueryRequest" do
    setup do
      @rsqr = XDS::RegistryStoredQueryRequest.new("http://129.6.24.109:9080/axis2/services/xdsregistryb", 
                                                  {"$XDSDocumentEntryPatientId" => "'93f3f8a6d100463^^^&1.3.6.1.4.1.21367.2005.3.7&ISO'",
                                                   "$XDSDocumentEntryStatus" => "('urn:oasis:names:tc:ebxml-regrep:StatusType:Approved')"})
    end
    
    should "create a SOAP Body" do
      soap_body = @rsqr.to_soap_body(create_builder,'xmlns:soapenv' => "http://www.w3.org/2003/05/soap-envelope")
      assert soap_body
      puts soap_body
    end
    
    should "query the NIST Public Registry" do
      response = @rsqr.execute
      assert response
      puts response.getResponseBodyAsString
    end
    
  end
end