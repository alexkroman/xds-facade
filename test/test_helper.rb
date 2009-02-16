require File.expand_path(File.dirname(__FILE__) + '/../lib/xds-facade')

require 'test/unit'
require 'shoulda'
require 'factory_girl'
require 'builder'

require File.expand_path(File.dirname(__FILE__) + '/factories')

module XmlTestHelper
  def assert_xpath(buffer, expression, namespaces = {}, desired_count = 1)
    doc = REXML::Document.new(StringIO.new(buffer))
    results = REXML::XPath.match(doc, expression, namespaces)
    assert results
    assert_equal desired_count, results.length
  end
  
  def create_builder(builder_attributes = {:indent => 2})
     Builder::XmlMarkup.new(builder_attributes)
  end
  
  def create_xml_document(doc_string)
    Rexml::Document.new(doc_string)
  end
  
  def common_namespaces
     @common_namespaces ||= {'xdsb' => "urn:ihe:iti:xds-b:2007", 
                            'soapenv' =>"http://www.w3.org/2003/05/soap-envelope",
                             'wsa' => "http://www.w3.org/2005/08/addressing"}
  end
  
end