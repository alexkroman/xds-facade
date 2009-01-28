require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class ServiceTest < Test::Unit::TestCase
  context "An XDS Service" do
    setup do
      @service = XDS::Service.new('http://employeeshare.mitre.org/a/andrewg/transfer/wsdl/XDS.b_DocumentRepository.wsdl')
    end

    should "provide and register a document set" do
      md = Factory.build(:metadata) 
      document = '<ClinicalDocument>Clinical Data</ClinicalDocument>'
      response = @service.provide_and_register_document_set(md, document)
      puts response
    end

  end
end
