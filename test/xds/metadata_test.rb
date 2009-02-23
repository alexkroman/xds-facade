require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class MetadataTest < Test::Unit::TestCase
  include XmlTestHelper
  
  context "Metadata" do
    setup do
      response_xml = REXML::Document.new(File.read(File.expand_path(File.dirname(__FILE__) + '/../data/query_response.xml')))
            namespaces = {'query' => "urn:oasis:names:tc:ebxml-regrep:xsd:query:3.0", 'rim' => 'urn:oasis:names:tc:ebxml-regrep:xsd:rim:3.0'}.merge(common_namespaces)
      @eo_node = REXML::XPath.first(response_xml, '/soapenv:Envelope/soapenv:Body/query:AdhocQueryResponse/rim:RegistryObjectList/rim:ExtrinsicObject', namespaces)
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