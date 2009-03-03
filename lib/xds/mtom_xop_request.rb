module XDS
  class MTOMXopRequest < XdsRequest
    
    def execute
        client = create_client
        parts = get_parts.to_java(Part)         
        post = PostMethod.new(endpoint_uri)

        ent = XdsRequestEntity.new(parts, post.get_params)
        ent.type="application/xop+xml"
        ent.start=parts[0].id
        ent.start_info="application/soap+xml"
        ent.action=@header.action
        
        post.set_request_entity(ent)
        post.content_chunked=true
        client.executeMethod(post)
        post      
    end
     
       
   def get_parts
     raise "Impement me"
   end
    
  end
  
  
end