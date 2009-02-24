class DocumentRepositoryService
  
  def initialize(service_url, proxy_host = nil, proxy_port=nil)
    @proxy_host = proxy_host
    @proxy_port = proxy_port
    @service_url = service_url
  end
  
  
  def register_document_set_b
    
  end
    
  def provide_and_register
    
  end
  
  
  def create_retrieve_document_set_request(doc_ids=[])
    rdr = RetrieveDocumentSetRequest.new(@service_url,doc_ids)
    rdr.proxy_host = @proxy_host
    rdr.proxy_port = @proxy_port
    rdr
  end
  
  
end