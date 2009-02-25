module XDS
  class ProvideAndRegisterDocumentSetBXopResponse 
    attr_accessor :parts
    def initialize(request,post)
      @request = request
      @parts = MIME::MimeMessageParser.parse(post.get_response_body_as_stream, 
                                              post.get_response_header("Content-Type").value)
      parse_response                                        
    end
    
    def status
      @status
    end
    
    def errors
      @errors
    end
    
    def success?
      @status == "urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Success"
    end
    
    def soap_resp
      @soap_resp  
    end
    
    private     
    def parse_response
      @soap_resp = @parts.first[:content]
      @response_document = REXML::Document.new(soap_resp)
      @response_element = REXML::XPath.first(@response_document,"/soapenv:Envelope/soapenv:Body/rs:RegistryResponse",COMMON_NAMESPACES)
      @status=@response_element.attributes["status"]
      @errors = REXML::XPath.match(@response_element,"./rs:RegistryErrorList/rs:RegistryError",COMMON_NAMESPACES).collect do |err|
        {:code_context=>err.attributes["codeContext"],
           :error_code=>err.attributes["errorCode"],
           :severity=>err.attributes["severity"] , 
           :location=>err.attributes["location"],  
           :text=>err.text
        }
      end
       @slot_list = REXML::XPath.first(@response_element,"/rs:ResponseSlotList",COMMON_NAMESPACES)
    end
    
  end
end