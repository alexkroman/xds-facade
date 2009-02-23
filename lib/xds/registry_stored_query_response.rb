module XDS
  class RegistryStoredQueryResponse
    attr_reader :retrieved_metadata
    
    def initialize
      @retrieved_metadata = []
      @request_successful = false
    end
    
    def request_successful?
      @request_successful
    end
    
    def parse_soap_response(soap_xml)
      doc = REXML::Document.new(StringIO.new(soap_xml))
      status = REXML::XPath.first(doc, 
                  '/soapenv:Envelope/soapenv:Body/query:AdhocQueryResponse/@status',
                  COMMON_NAMESPACES)
      if status.to_s.eql?('urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Success')
        @request_successful = true
        REXML::XPath.each(doc, 
                    '/soapenv:Envelope/soapenv:Body/query:AdhocQueryResponse/rim:RegistryObjectList/rim:ExtrinsicObject',
                    COMMON_NAMESPACES) do |eo|
          metadata = Metadata.new
          metadata.load_from_extrinsic_object(eo)
          @retrieved_metadata << metadata
        end
      end
    end
  end
end