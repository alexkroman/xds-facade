require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class AuthorTest < Test::Unit::TestCase
  include XmlTestHelper
 
  context "XDS::Author" do
    should "be able to create soap representaion " do 
      auth = XDS::Author.new("institution_value","person_value","role_value","specialty_value")
      soap = auth.to_soap(create_builder,"my_object_id")   
      assert_xpath(soap,"/Classification[@classifiedObject='my_object_id']/Slot[@name = 'authorInstitution']/ValueList/Value[text()='institution_value]",{},1)
      assert_xpath(soap,"/Classification[@classifiedObject='my_object_id']/Slot[@name='authorPerson']/ValueList/Value[text()='person_value]",{},1)
      assert_xpath(soap,"/Classification[@classifiedObject='my_object_id']/Slot[@name='authorRole']/ValueList/Value[text()='role_value]",{},1)
      assert_xpath(soap,"/Classification[@classifiedObject='my_object_id']/Slot[@name='authorSpecialty']/ValueList/Value[text()='specialty_value]",{},1)
    end
  end
end