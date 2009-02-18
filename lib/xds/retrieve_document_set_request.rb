module XDS
  class RetrieveDocumentSetRequest < XdsRequest
    
    def initialize(service_url, doc_ids = [])
      super(service_url,"urn:ihe:iti:2007:RetrieveDocumentSet")
      @doc_ids = doc_ids
    end
    
    def add_ids_to_request(repository_unique_id, document_unique_id)
      @doc_ids << {:repository_unique_id => repository_unique_id,
                   :document_unique_id => document_unique_id}
    end
    
    # Returns an array of hashes, with a hash for each document returned.
    # The hash will contain
    # * <tt>:repository_unique_id</tt> - The Repository Unique Id for the document
    # * <tt>:document_unique_id</tt> - The Document Unique Id for the document
    # * <tt>:content</tt> - The document as a String
    def execute
      post = super
      parts = MIME::MimeMessageParser.parse(post.get_response_body_as_stream, 
                                            post.get_response_header("Content-Type").value)
      rdsr = XDS::RetrieveDocumentSetResponse.new
      rdsr.parse_soap_response(parts.first[:content])
      if rdsr.request_successful?
        docs = []
        rdsr.retrieved_documents.each do |rd|
          part = parts.find {|candidate_part| candidate_part[:content_id].eql?('<' + rd[:content_id] + '>')}
          doc = {}
          doc[:repository_unique_id] = rd[:repository_unique_id]
          doc[:document_unique_id] = rd[:document_unique_id]
          doc[:content] = part[:content]
          docs << doc
        end
        
        return docs
      else
        return false
      end
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
