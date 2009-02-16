module XDS
  class RetrieveDocumentSetRequest
    
    def initialize
      @doc_ids = []
    end
    
    def add_ids_to_request(repository_unique_id, document_unique_id)
      @doc_ids << {:repository_unique_id => repository_unique_id,
                   :document_unique_id => document_unique_id}
    end
    
    def to_soap_body(body_attributes = {})
      builder = Builder::XmlMarkup.new(:indent => 2)
      
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
