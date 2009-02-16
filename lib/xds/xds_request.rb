module XDS
  class XdsRequest  
    attr_accessor :header
    attr_accessor :endpoint_uri  
    
    def initialize(service_url,action,message_id = XdsHeader.new_message_id)
      @header = XDS::XdsHeader.new(service_url,action,message_id)
      @endpoint_uri = service_url
    end   
    
    def endpoint_uri=(value)
      @endpoint_uri = value
      @header.endpoint_uri = value
    end
    
    def execute
      client = DefaultHttpClient.new
      post = HttpPost.new(endpoint_uri)
      post.entity = StringEntity.new(to_soap)
      client.execute(post)
    end
    
    def to_soap(builder = Builder::XmlMarkup.new(:indent => 2),attributes={})
      builder.soapenv(:Envelope, 
                    "xmlns:soapenv" => "http://www.w3.org/2003/05/soap-envelope",
                     "xmlns"=>"http://www.w3.org/2003/05/soap-envelope",
                     "xmlns:wsa" =>"http://www.w3.org/2005/08/addressing") do
        header.endpoint_uri = endpoint_uri
        header.to_soap(builder)
        to_soap_body(builder, attributes)
      end
    end
    
    def to_soap_body(builder,attributes={})
      raise "Implement Me, Really!!!!"
    end
  end 
end