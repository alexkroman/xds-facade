module XDS
  
  class XdsHeader 
     require 'uuid'
   
   
     def self.new_message_id()
        UUID.new.generate      
     end
     
      
     attr_accessor :action
     attr_accessor :endpoint_uri
     
     
     def initialize(action,endpoint,message_id = XdsHeader.new_message_id)
       @action = action
       @endpoint_uri = endpoint
       @message_id = message_id
     end
     
     def to_soap(builder)
       generate_action(builder)
       generate_endpoint(builder)
       generate_message_id(builder)
     end
     
     
     def generate_action(builder)
       
     end
     
     def generate_endpoint(builder)
       
     end
     
     def generate_message_id(builder)
       
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