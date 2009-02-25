require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class MetadataTest < Test::Unit::TestCase
  include XmlTestHelper
  
  context "Metadata" do
    setup do
      response_xml = REXML::Document.new(File.read(File.expand_path(File.dirname(__FILE__) + '/../data/query_response.xml')))
            @namespaces = {'query' => "urn:oasis:names:tc:ebxml-regrep:xsd:query:3.0", 'rim' => 'urn:oasis:names:tc:ebxml-regrep:xsd:rim:3.0'}.merge(common_namespaces)
      @eo_node = REXML::XPath.first(response_xml, '/soapenv:Envelope/soapenv:Body/query:AdhocQueryResponse/rim:RegistryObjectList/rim:ExtrinsicObject', @namespaces)
      @building_namespaces = {'xmlns:query' => "urn:oasis:names:tc:ebxml-regrep:xsd:query:3.0", 'xmlns:rim' => 'urn:oasis:names:tc:ebxml-regrep:xsd:rim:3.0'}.merge(common_namespaces_for_building)
    end
    
    should "be able to serialize to soap " do
      metadata = Factory.build(:metadata)
      builder =create_builder
      xml = metadata.to_soap(builder)
      assert_xpath(xml, "/rim:RegistryObjectList/rim:ExtrinsicObject", @namespaces,1)
      
      assert_xpath(xml, "/rim:RegistryObjectList/rim:RegistryPackage", @namespaces,1)
      assert_xpath(xml, "/rim:RegistryObjectList/rim:RegistryPackage/rim:ExternalIdentifier[@identificationScheme='urn:uuid:96fdda7c-d067-4183-912e-bf5ee74998a8']", @namespaces,1)
      assert_xpath(xml, "/rim:RegistryObjectList/rim:RegistryPackage/rim:ExternalIdentifier[@identificationScheme='urn:uuid:554ac39e-e3fe-47fe-b233-965d2a147832']", @namespaces,1)
      assert_xpath(xml, "/rim:RegistryObjectList/rim:RegistryPackage/rim:ExternalIdentifier[@identificationScheme='urn:uuid:58a6f841-87b3-4a3e-92fd-a8ffeff98427']", @namespaces,1)
      assert_xpath(xml, "/rim:RegistryObjectList/rim:RegistryPackage/rim:ExternalIdentifier[@identificationScheme='urn:uuid:6b5aea1a-874d-4603-a4bc-96a0a7b38446']", @namespaces,1)
      
      assert_xpath(xml, "/rim:RegistryObjectList/rim:Classification[@classificationNode='urn:uuid:a54d6aa5-d40d-43f9-88c5-b4633d873bdd' and @classifiedObject=/rim:RegistryObjectList/rim:RegistryPackage/@id]", @namespaces,1)
      
      assert_xpath(xml, "/rim:RegistryObjectList/rim:Association[@associationType='HasMember' and @sourceObject=/rim:RegistryObjectList/rim:RegistryPackage/@id]/rim:Slot[@name='SubmissionSetStatus']", @namespaces,1)
      
    end
    
    
    should "be able to populate values from an ExtrinsicObject node" do
      metadata = XDS::Metadata.new
      metadata.load_from_extrinsic_object(@eo_node)
      assert_equal '^Smitty^Gerald^^^', metadata.author.person
      assert_equal 'Cleveland Clinic', metadata.author.institution
      assert_equal 'Attending', metadata.author.role
      assert_equal 'Orthopedic', metadata.author.specialty
      assert_equal 'Communication', metadata.class_code.code
      assert_equal 'Communication', metadata.class_code.display_name
      assert_equal 'Connect-a-thon classCodes', metadata.class_code.coding_scheme
      assert_equal Date.new(2004, 12, 24), metadata.creation_time
      assert_equal '93f3f8a6d100463^^^&1.3.6.1.4.1.21367.2005.3.7&ISO', metadata.patient_id
      assert_equal 'pid1^^^domain', metadata.source_patient_info.source_patient_identifier
    end
  end
end