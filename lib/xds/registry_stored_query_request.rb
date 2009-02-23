module XDS
  class RegistryStoredQueryRequest < XdsRequest
    include Helper
    
    def initialize(service_url, query)
      super(service_url,"urn:ihe:iti:2007:RegistryStoredQuery")
      @query = query
    end
    
    def execute
      post = super
      rsqr = RegistryStoredQueryResponse.new
      rsqr.parse_soap_response(post.response_body_as_string)
      if rsqr.request_successful?
        return rsqr.retrieved_metadata
      else
        return nil
      end
    end
    
    def to_soap_body(builder,body_attributes = {})
      builder.soapenv(:Body, body_attributes) do
        builder.query(:AdhocQueryRequest, 'xmlns:query' => "urn:oasis:names:tc:ebxml-regrep:xsd:query:3.0",
                                          'xmlns:rs' => "urn:oasis:names:tc:ebxml-regrep:xsd:rs:3.0",
                                          'xmlns' => "urn:oasis:names:tc:ebxml-regrep:xsd:rim:3.0") do
          builder.query(:ResponseOption, 'returnComposedObjects' => "true", 'returnType' => "LeafClass")
          # Currently hardcoded to FindDocuments
          builder.AdhocQuery('id' => "urn:uuid:14d4debf-8f97-4251-9a74-a90016b0af0d") do
            @query.each_pair do |slot_name, values|
              packed_values = values.kind_of?(Array) ? values : [values]
              create_slot(builder, slot_name, packed_values)
            end
          end
        end
      end
    end
  end
end