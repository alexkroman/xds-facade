module XDS
  class Service
  
    def initialize(url)
      @service = DocumentRepository_ServiceStub.new(url)
    end
  
  
    def create_retrieve_document_request(doc_ids = [])
      RetrieveDocumentRequest.new(@service_url,doc_ids)    
    end
    
    
  
    def provide_and_register_document_set(metadata, document)
      sor = SubmitObjectsRequest_type0.new
      sor.setRegistryObjectList(metadata.create_registry_object_list)
      pardsr = ProvideAndRegisterDocumentSetRequestType.new
      pardsr.setProvideAndRegisterDocumentSetRequestTypeSequence_type0(ProvideAndRegisterDocumentSetRequestTypeSequence_type0.new)
      pardsr.setSubmitObjectsRequest(sor)
      web_service_document = Document_type0::Factory.fromString(document,nil)
      web_service_document.setId(org.apache.axis2.databinding.types.URI.new('the_document'))
      pardsr.getProvideAndRegisterDocumentSetRequestTypeSequence_type0.addDocument(web_service_document)
      
      req = ProvideAndRegisterDocumentSetRequest.new
      req.setProvideAndRegisterDocumentSetRequest(pardsr)
      
      @service.DocumentRepository_ProvideAndRegisterDocumentSetB(req)
    end
  end
end