require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class CodedAttributeTest < Test::Unit::TestCase
  include XmlTestHelper
 
  context "CodedAttribute" do
    setup do
      eo_xml = REXML::Document.new(File.read(File.expand_path(File.dirname(__FILE__) + '/../data/extrinsic_object.xml')))
      @eo_node = eo_xml.root
    end
    
    TYPES = {:class_code => 'urn:uuid:41a5887f-8865-4c09-adf7-e362475b143a',
           :confidentiality_code => 'urn:uuid:f4f85eac-e6cb-4883-b524-f2705394840f',
           :format_code => 'urn:uuid:a09d5840-386c-46f2-b5ad-9c3699a4309d',
           :healthcare_facility_type_code =>  'urn:uuid:f33fb8ac-18af-42cc-ae0e-ed0b0bdb91e1',
           :practice_setting_code =>'urn:uuid:cccf5598-8b07-4b77-a05e-ae952c785ead',
           :type_code => 'urn:uuid:f0306f51-975f-434e-a61c-c59651d33983'
           }
  
    should "be able to create a soap representation of itself" do      
      TYPES.each_pair do |key,value|
        ca = XDS::CodedAttribute.new(key,"code_val","ds_name", "scheme")
        soap = ca.to_soap(create_builder,"my_object_id")
        assert_xpath(soap,"/Classification[@classificationScheme='#{value}' and @classifiedObject='my_object_id' and @nodeRepresentation='code_val' ]/Name/LocalizedString[@value='ds_name']/../../Slot[@name='codingScheme']/ValueList/Value[text()='scheme']",{},1)         
      end
    end
    
    should "be able to populate values from an ExtrinsicObject node" do
      ca = XDS::CodedAttribute.new(:practice_setting_code)
      ca.from_extrinsic_object(@eo_node)
      assert_equal('Cardiology', ca.code)
      assert_equal('Cardiology', ca.display_name)
      assert_equal('Connect-a-thon practiceSettingCodes', ca.coding_scheme)
    end
    
  end

end
