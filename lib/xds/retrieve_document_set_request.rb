module XDS
  class RetrieveDocumentSetRequest < XdsRequest
    
    def initialize
      @header = XdsHeader.new("urn:ihe:iti:2007:RetrieveDocumentSet","")
      @doc_ids = []
    end
    
    def add_ids_to_request(repository_unique_id, document_unique_id)
      @doc_ids << {:repository_unique_id => repository_unique_id,
                   :document_unique_id => document_unique_id}
    end
    
    def to_soap_body(builder,body_attributes = {})
     
      builder.soapenv(:Body, body_attributes) do
        builder.RetrieveDocumentSetRequest('xmlns' => "urn:ihe:iti:xds-b:2007") do
          @doc_ids.each do |doc_id|
            builder.DocumentRequest do
              builder.RepositoryUniqueId(doc_id[:repository_unique_id])
              builder.DocumentUniqueId(doc_id[:document_unique_id])
            end
          end
        end
      end
    end
  end
end
