module XDS
  class ProvideAndRegisterDocumentSetB < XdsRequest

  
      def initialize(service_url,document)
          super(service_url,"urn:ihe:iti:2007:ProvideAndRegisterDocumentSet-b")
          @document = document
      end                    
  
     
      def execute
          client = create_client
          post = PostMethod.new(endpoint_uri)
          body_part =  StringPart.new("body", to_soap)
          body_part.set_content_type(%{type="text/xml"})
          @uuid = "urn:uid:#{UUID.new.generate}"
          document_part = StringPart.new("document",@document.to_s)          
          parts = [body_part,document_part].to_java(Part)
          post.set_request_entity(MultipartRequestEntity.new(parts, post.get_params))
          client.executeMethod(post)
          post
      end
  
      def to_soap_body(builder, attributes={}) 
      
        builder.ProvideAndRegisterDocumentSetRequest() do 
            builder.SubmitObjectsRequest do
            
            end
        
        end
      end
  end
end