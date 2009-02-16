class DocumentRepositoryService
  
  def initialize(service_url)
    @service_url = service_url
  end
  
  
  def register_document_set_b
    
  end
    
  def provide_and_register
    
  end
  
  
  def create_retrieve_document_set_request(doc_ids=[])
    RetrieveDocumentSetRequest.new(@service_url,doc_ids)
  end
  
  
end