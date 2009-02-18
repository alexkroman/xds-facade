class ProvideAndRegisterDocumentSetB < XdsRequest
  
    def initialize(service_url)
        super(service_url,"urn:ihe:iti:2007:ProvideAndRegisterDocumentSet-b")
    end
  
  
  
    def to_soap_body(builder) 
      
      builder.ProvideAndRegisterDocumentSetRequest() do 
          builder.SubmitObjectsRequest do
            builder.RegistryObjectList do
              
              
            end
            
            
          end
          
          builder.Document do 
            
          end
        
      end
    end
end