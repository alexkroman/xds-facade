require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class XdsHeaderTest < Test::Unit::TestCase
  include XmlTestHelper
  context "hey this does something" do

     
      should "be able to create a  header" do
          header = XDS::XdsHeader.new("urn:my_endpoint_uri","urn:MyAction","urn:uid:myuid")
          builder = create_builder()
          
          doc_string = builder.wrapper(common_namespaces_for_building) do 
            header.to_soap(builder)
          end
          puts doc_string
          assert doc_string
          assert_xpath(doc_string,"/wrapper/soapenv:Header/wsa:To[text() = 'urn:my_endpoint_uri']",common_namespaces,1)
          assert_xpath(doc_string,"/wrapper/soapenv:Header/wsa:MessageID[text() = 'urn:uid:myuid']",common_namespaces,1)         
          assert_xpath(doc_string,"/wrapper/soapenv:Header/wsa:Action[text() = 'urn:MyAction']",common_namespaces,1)
          
      end
  end
  
end