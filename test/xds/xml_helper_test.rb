require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
require 'lib/xds/helper'
class XmlHelperTest < Test::Unit::TestCase
  include XmlTestHelper
  include XDS::Helper
  
  context "The Xml Helper" do
     setup do
       eo_xml = REXML::Document.new(File.read(File.expand_path(File.dirname(__FILE__) + '/../data/extrinsic_object.xml')))
       @eo_node = eo_xml.root
     end
     
     should "be able to create a  slot" do
           
           slot = create_slot(create_builder,"testSlot", ["value1","value2"])   
           assert_xpath(slot,"/Slot[@name='testSlot']/ValueList/Value[text() = 'value1']",{},1)
           assert_xpath(slot,"/Slot[@name='testSlot']/ValueList/Value[text() = 'value2']",{},1)
     end
     
     
     should "be able to create a LocalizedString" do
          ls = create_localized_string(create_builder,"ls_value")
          assert_xpath(ls,"/LocalizedString[@value='ls_value']",{},1)
     end
     
     
     should "be able to create a Name element" do
         name = create_name(create_builder,"name_value")
         assert_xpath(name,"/Name/LocalizedString[@value='name_value']",{},1)
     end
   
     should "be able to create a Classification element" do
         cl = create_classification(create_builder,"myscheme","object_id","node_rep")
         assert_xpath(cl,"/Classification[@classificationScheme = 'myscheme']",{},1)
         assert_xpath(cl,"/Classification[@classifiedObject = 'object_id']",{},1)
         assert_xpath(cl,"/Classification[@nodeRepresentation = 'node_rep']",{},1)
     end
     
     should "be able to create a Classification element with a block" do
         cl = create_classification(create_builder,"myscheme","object_id","node_rep") do |builder|
           create_name(builder,"test_name")
         end
         
         assert_xpath(cl,"/Classification[@classificationScheme = 'myscheme']",{},1)
         assert_xpath(cl,"/Classification[@classifiedObject = 'object_id']",{},1)
         assert_xpath(cl,"/Classification[@nodeRepresentation = 'node_rep']",{},1)
         
         assert_xpath(cl,"/Classification/Name/LocalizedString[@value='test_name']",{},1)
         
     end
     
     
     should "be able to create an ExternalIdentiier" do
         ei = create_external_identifier(create_builder,"my_id","my_reg_object","scheme","schem_value")
         assert_xpath(ei,"/ExternalIdentifier[@id='my_id' and @registryObject='my_reg_object' and @identificationScheme='scheme' and @value='schem_value']",{}, 1)
     end
     
     
     should "be able to create an ExternalIdentiier with a block" do
         ei = create_external_identifier(create_builder,"id","reg_obj", "scheme","schem_value") do |builder|
            create_slot(builder,"test_slot",["value1","value2"])
         end
         assert_xpath(ei,"/ExternalIdentifier[@identificationScheme='scheme' and @value='schem_value']",{}, 1)
         assert_xpath(ei,"/ExternalIdentifier/Slot/ValueList/Value[text() = 'value1']",{},1)
         assert_xpath(ei,"/ExternalIdentifier/Slot/ValueList/Value[text() = 'value2']",{},1)
     end
     
     should "be able to create an ExtrinsicObject " do 
       eo = create_extrinsic_object(create_builder,"my_id","my_mime","my_object_type")     
       assert_xpath(eo,"/ExtrinsicObject[@id='my_id' and @mimeType='my_mime' and @objectType='my_object_type']")
     end
     
     
     should "be able to create an ExtrinsicObject with a block" do 
       eo = create_extrinsic_object(create_builder,"my_id","my_mime","my_object_type") do |builder|
           create_slot(builder,"test_slot",["value1","value2"])
        end      
       assert_xpath(eo,"/ExtrinsicObject[@id='my_id' and @mimeType='my_mime' and @objectType='my_object_type']")
       assert_xpath(eo,"/ExtrinsicObject/Slot/ValueList/Value[text() = 'value1']",{},1)
       assert_xpath(eo,"/ExtrinsicObject/Slot/ValueList/Value[text() = 'value2']",{},1)
     end
     
     context "when getting a slot value" do
      should "get the slot value" do
        creation_time = get_slot_value(@eo_node, 'creationTime')
        assert_equal('20041224', creation_time)
      end
      
      should "return nil when the slot doesn't exist" do
        nuthin = get_slot_value(@eo_node, 'foo')
        assert_nil nuthin
      end
      
      should "return the first value when there are multiple values in the list" do
        uri = get_slot_value(@eo_node, 'URI')
        assert_equal 'http://129.6.24.109:9080/Repository/229.6.58.29.939.txt', uri
      end
     end
     
     context "when getting a slot with multiple values" do
      should "get the slot values" do
        uris = get_slot_values(@eo_node, 'URI')
        assert uris
        assert_equal 2, uris.length
        assert_equal 'http://129.6.24.109:9080/Repository/229.6.58.29.939.txt', uris.first
        assert_equal 'http://www.example.com', uris[1]
      end
     end
     
     should 'be able to provide a block to a desired classification' do
        with_classification(@eo_node, "urn:uuid:93606bcf-9494-43ec-9b4e-a7748d1a838d") do |classification|
          assert_equal "urn:uuid:6d037c16-d94d-4c10-acfc-f6cae5f7287e", classification.attributes['classifiedObject']
        end
     end
     
     should 'be able to get an external identifier' do
       patient_id = get_external_identifier_value(@eo_node, XDS::Metadata::EXTERNAL_ID_SCHEMES[:patient_id][:scheme])
       assert patient_id
       assert_equal '93f3f8a6d100463^^^&1.3.6.1.4.1.21367.2005.3.7&ISO', patient_id
     end
    
  end
  
end