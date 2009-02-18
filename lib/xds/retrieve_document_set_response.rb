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
        REXML::XPath.each(doc, 
                    '/soapenv:Envelope/soapenv:Body/xdsb:RetrieveDocumentSetResponse/xdsb:DocumentResponse',
                    COMMON_NAMESPACES) do |dr|
          doc = {}
          #Nuke the 'cid:' from the front of the content id since it doesn't show up in the mime message headers
          doc[:content_id] = dr.elements['xdsb:Document/xop:Include'].attributes['href'].to_s.sub('cid:', '')
          doc[:repository_unique_id] = dr.elements['xdsb:RepositoryUniqueId'].text
          doc[:document_unique_id] = dr.elements['xdsb:DocumentUniqueId'].text
          @retrieved_documents << doc
        end
      end
    end
  end
end
