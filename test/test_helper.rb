require File.expand_path(File.dirname(__FILE__) + '/../lib/xds-facade')

require 'test/unit'
require 'shoulda'
require 'factory_girl'

require File.expand_path(File.dirname(__FILE__) + '/factories')

module XmlTestHelper
  def assert_xpath(buffer, expression, namespaces = {}, desired_count = 1)
    doc = REXML::Document.new(StringIO.new(buffer))
    results = REXML::XPath.match(doc, expression, namespaces)
    assert results
    assert_equal desired_count, results.length
  end
end