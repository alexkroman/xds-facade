require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class ProvideAndRegisterDocumentSetTest < Test::Unit::TestCase
  include XmlTestHelper
  context "A ProvideAndRegisterDocumentSetRequest" do
    
    
    should "be able to register a document with a repository" do
      @prdsr = XDS::ProvideAndRegisterDocumentSetBXop.new("http://129.6.24.109:9080/tf5/services/xdsrepositoryb",
       Factory.build(:metadata), "some crappy document")
        @resp =  @prdsr.execute
        assert @resp.success?
        assert @resp.errors.empty?
    end
    
    should "be able to detect a failed PnR request " do
      metadata = Factory.build(:metadata)
      metadata.ss_unique_id=""
      metadata.source_id=""
      @prdsr = XDS::ProvideAndRegisterDocumentSetBXop.new("http://129.6.24.109:9080/tf5/services/xdsrepositoryb",
         metadata, "some crappy document") 
      
      @resp =  @prdsr.execute
      assert ! @resp.success?
      assert ! @resp.errors.empty?      
     
     end
    
  end
  
end