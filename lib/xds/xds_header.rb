module XDS
  class XdsHeader 
     def self.new_message_id()
        "urn:uuid:#{UUID.new.generate}"      
     end

     attr_accessor :action
     attr_accessor :endpoint_uri
     @@namespace= {"xmlns" => "http://www.w3.org/2005/08/addressing"}
     
     def initialize(endpoint,action,message_id = XdsHeader.new_message_id)
       @action = action
       @endpoint_uri = endpoint
       @message_id = message_id 
     end
     
     def to_soap(builder)
       builder.soapenv(:Header) do
          builder.wsa(:To, @endpoint_uri)
          builder.wsa(:Action, @action)
          builder.wsa(:MessageID, @message_id) 
       end
     end
     
  end
end