module XDS
  
  class XdsHeader 
     require 'uuid'
   
   
     def self.new_message_id()
        "urn:uuid:#{UUID.new.generate}"      
     end
     
      
     attr_accessor :action
     attr_accessor :endpoint_uri
     @@namespace= {"xmlns" => "http://www.w3.org/2005/08/addressing"}
     
     def initialize(action,endpoint,message_id = XdsHeader.new_message_id)
       @action = action
       @endpoint_uri = endpoint
       @message_id = message_id
     end
     
     def to_soap(builder)
       builder.Header("xmlns"=>"http://www.w3.org/2003/05/soap-envelope","xmlns:wsa" =>"http://www.w3.org/2005/08/addressing") do
          builder.wsa(:To, @endpoint_uri)
          builder.wsa(:Action, @action)
          builder.wsa(:MessageID, @message_id) 
       end
     end
     
  end
  
  class XdsRequest  
    attr_reader :header
    attr_accessor :endpoint_uri  
    
    def to_soap(builder = Builder::XmlMarkup.new(:indent => 2),attributes={})
        header.to_soap(builder,endpoint_uri)
        to_soap_body(builder,attributes)
    end
    
    def to_saop_body(builder,attributes={})
      raise "Implement Me, Really!!!!"
    end
  end 
end