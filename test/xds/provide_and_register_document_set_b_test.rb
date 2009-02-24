require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class ProvideAndRegisterDocumentSetTest < Test::Unit::TestCase
  include XmlTestHelper
  context "A ProvideAndRegisterDocumentSetRequest" do
    
    
    should "be able to register a document with a repository" do
      @prdsr = XDS::ProvideAndRegisterDocumentSetBXop.new("http://129.6.24.109:9080/tf5/services/xdsrepositoryb",
       Factory.build(:metadata), "some crappy document")
      puts @prdsr.execute.get_response_body_as_string
    end
    
    
  end
  
end