module XDS
  class XdsRequest  
    attr_accessor :header
    attr_accessor :endpoint_uri  
    attr_accessor :proxy_host
    attr_accessor :proxy_port
    
    def initialize(service_url,action,message_id = XdsHeader.new_message_id)
      @header = XDS::XdsHeader.new(service_url,action,message_id)
      @endpoint_uri = service_url
      @proxy_host = XDS.proxy_config[:host]
      @proxy_port = XDS.proxy_config[:port]
    end   
    
    def endpoint_uri=(value)
      @endpoint_uri = value
      @header.endpoint_uri = value
    end
    
    def execute
      client = create_client
      post = PostMethod.new(endpoint_uri)
      post.request_entity = StringRequestEntity.new(to_soap, 'application/soap+xml', 'UTF-8')
      client.executeMethod(post)
      post
    end
    
    def to_soap(builder = Builder::XmlMarkup.new(:indent => 2),attributes={})
      builder.instruct!
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
    
    private 
    
     def create_client
       client = HttpClient.new
       if @proxy_host 
         host_config = client.host_configuration
         host_config.setProxy(@proxy_host, @proxy_port || 80)
       end
       client
     end
  end 
end