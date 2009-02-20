require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class AuthorTest < Test::Unit::TestCase
  include XmlTestHelper
 
  context "XDS::Author" do
    setup do
      eo_xml = REXML::Document.new(File.read(File.expand_path(File.dirname(__FILE__) + '/../data/extrinsic_object.xml')))
      @eo_node = eo_xml.root
    end
    
    should "be able to create soap representaion " do 
      auth = XDS::Author.new("institution_value","person_value","role_value","specialty_value")
      soap = auth.to_soap(create_builder,"my_object_id")   
      assert_xpath(soap,"/Classification[@classifiedObject='my_object_id']/Slot[@name = 'authorInstitution']/ValueList/Value[text()='institution_value]",{},1)
      assert_xpath(soap,"/Classification[@classifiedObject='my_object_id']/Slot[@name='authorPerson']/ValueList/Value[text()='person_value]",{},1)
      assert_xpath(soap,"/Classification[@classifiedObject='my_object_id']/Slot[@name='authorRole']/ValueList/Value[text()='role_value]",{},1)
      assert_xpath(soap,"/Classification[@classifiedObject='my_object_id']/Slot[@name='authorSpecialty']/ValueList/Value[text()='specialty_value]",{},1)
    end
    
    should "be able to populate values from an ExtrinsicObject node" do
      author = XDS::Author.new()
      author.from_extrinsic_object(@eo_node)
      assert_equal('^Dopplemeyer^Sherry^^^', author.person)
      assert_equal('Primary Surgon', author.role)
      assert_equal('Orthopedic', author.specialty)
      assert_equal('Cleveland Clinic', author.institution)
    end
  end
end