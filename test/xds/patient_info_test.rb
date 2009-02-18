require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class PatientInfoTest < Test::Unit::TestCase
  include XmlTestHelper
  context "SourcePatientInfo" do
    should "be able to serialize to soap representaion" do
      
      name = "name"
      spi = "spi"
      gender="manlyman"
      dob = Time.now
      addr = "penny lane"
      
      p = XDS::SourcePatientInfo.new(:name=>name,
                          :source_patient_identifier=>spi,
                          :gender=>gender,
                          :date_of_birth=>dob,
                          :address=>addr)
                          
      soap = p.to_soap(create_builder)
      assert_xpath(soap,"/Slot[@name='sourcePatientInfo']/ValueList/Value[text() = 'PID-5|#{name}']")
      assert_xpath(soap,"/Slot[@name='sourcePatientInfo']/ValueList/Value[text() = 'PID-8|#{gender}']")
      assert_xpath(soap,"/Slot[@name='sourcePatientInfo']/ValueList/Value[text() = 'PID-7|#{dob.strftime('%Y%m%d')}']")
      assert_xpath(soap,"/Slot[@name='sourcePatientInfo']/ValueList/Value[text() = 'PID-11|#{addr}']")
      assert_xpath(soap,"/Slot[@name='sourcePatientInfo']/ValueList/Value[text() = 'PID-3|#{spi}']")
    end
  end

end