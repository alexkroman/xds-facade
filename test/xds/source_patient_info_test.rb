require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class SourcePatientInfoTest < Test::Unit::TestCase
  include XmlTestHelper
  context "SourcePatientInfo" do
    setup do
      eo_xml = REXML::Document.new(File.read(File.expand_path(File.dirname(__FILE__) + '/../data/extrinsic_object.xml')))
      @eo_node = eo_xml.root
    end
    
    should "be able to serialize to soap representaion" do
      
      name = "name"
      spi = "spi"
      gender="manlyman"
      dob = Time.now.strftime('%Y%m%d')
      addr = "penny lane"
      
      p = XDS::SourcePatientInfo.new(:name=>name,
                          :source_patient_identifier=>spi,
                          :gender=>gender,
                          :date_of_birth=>dob,
                          :address=>addr)
                          
      soap = p.to_soap(create_builder)
      assert_xpath(soap,"/Slot[@name='sourcePatientInfo']/ValueList/Value[text() = 'PID-5|#{name}']")
      assert_xpath(soap,"/Slot[@name='sourcePatientInfo']/ValueList/Value[text() = 'PID-8|#{gender}']")
      assert_xpath(soap,"/Slot[@name='sourcePatientInfo']/ValueList/Value[text() = 'PID-7|#{dob}']")
      assert_xpath(soap,"/Slot[@name='sourcePatientInfo']/ValueList/Value[text() = 'PID-11|#{addr}']")
      assert_xpath(soap,"/Slot[@name='sourcePatientInfo']/ValueList/Value[text() = 'PID-3|#{spi}']")
    end
    
    should "match and strip HL7V2 coded fields" do
      value_list = ['PID-3|pid1^^^domain', 'PID-5|Doe^John^^^', 'PID-7|19560527']
      p = XDS::SourcePatientInfo.new
      name = p.match_and_strip(value_list, 'PID-5')
      assert name
      assert_equal 'Doe^John^^^', name
    end
    
    should "return nil when trying to match and strip a field that isn't there" do
      value_list = ['PID-3|pid1^^^domain', 'PID-5|Doe^John^^^', 'PID-7|19560527']
      p = XDS::SourcePatientInfo.new
      nuthin = p.match_and_strip(value_list, 'PID-13')
      assert_nil nuthin
    end
    
    should "be able to populate values from an ExtrinsicObject node" do
      patient_info = XDS::SourcePatientInfo.new
      patient_info.from_extrinsic_object(@eo_node)
      assert_equal 'pid1^^^domain', patient_info.source_patient_identifier
      assert_equal 'Doe^John^^^', patient_info.name
      assert_equal 'M', patient_info.gender
      assert_equal '100 Main St^^Metropolis^Il^44130^USA', patient_info.address
      assert_equal "19560527", patient_info.date_of_birth
    end
  end

end