require 'base64'
module XDS
  class ProvideAndRegisterDocumentSetB < XdsRequest

  
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

             builder.xdsb(:Document, Base64.b64encode(@document),"id"=>@metadata.id)

         end
       end
     end            
  end
end