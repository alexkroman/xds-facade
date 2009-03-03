module XDS
  class ProvideAndRegisterDocumentSetBXop < MTOMXopRequest
  
     def initialize(service_url,metadata,document)
           super(service_url,"urn:ihe:iti:2007:ProvideAndRegisterDocumentSet-b")
           @metadata = metadata
           @document = document
       end                    

     
       def to_soap_body(builder, attributes={}) 
       @metadata.id = "urn:uid:#{UUID.new.generate}" unless @metadata.id  
       builder.soapenv(:Body, attributes) do
         builder.xdsb(:ProvideAndRegisterDocumentSetRequest,"xmlns:lcm"=>"urn:oasis:names:tc:ebxml-regrep:xsd:lcm:3.0",
                                                           "xmlns:rim"=>"urn:oasis:names:tc:ebxml-regrep:xsd:rim:3.0",
                                                           "xmlns:xdsb"=>"urn:ihe:iti:xds-b:2007") do 
             builder.lcm(:SubmitObjectsRequest) do
                 
                 @metadata.to_soap(builder)
               
             end

             builder.xdsb(:Document, "id"=>@metadata.id) do
                builder.Include("href"=>get_document_part_id, "xmlns"=>"http://www.w3.org/2004/08/xop/include")
             end

         end
       end
     end                 
  
     
     
    def execute
        post = super
        XDS::ProvideAndRegisterDocumentSetBXopResponse.new(self,post)     
    end
    
    def get_parts
      body_part =  XdsPart.new("body", to_soap)
      body_part.char_set="UTF-8"
      body_part.id = get_body_part_id
      body_part.set_content_type(%{application/xop+xml; type="application/soap+xml"})
     
      document_part = XdsPart.new("document",@document.to_s)   
      document_part.char_set="UTF-8"
      document_part.id=get_document_part_id       
      [body_part,document_part]
    end
    
    private 
    
     def get_document_part_id
        @document_part_id ||= "urn:uid:#{UUID.new.generate}"
     end
      
    def get_body_part_id
      @body_part_id ||= "urn:uid:#{UUID.new.generate}"
    end  
  end
  
end
