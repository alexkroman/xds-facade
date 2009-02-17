module XDS
  class RetrieveDocumentSetResponse
    attr_reader :retrieved_documents
    
    def initialize
      @retrieved_documents = []
      @request_successful = false
    end
    
    def request_successful?
      @request_successful
    end
    
    def parse_soap_response(soap_xml)
      doc = REXML::Document.new(StringIO.new(soap_xml))
      status = REXML::XPath.first(doc, 
                  '/soapenv:Envelope/soapenv:Body/xdsb:RetrieveDocumentSetResponse/rs:RegistryResponse/@status',
                  COMMON_NAMESPACES)
      if status.to_s.eql?('urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Success')
        @request_successful = true
      end
    end
  end
end
