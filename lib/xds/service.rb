class XDS::Service
  
  def initialize(url)
    service_url = java.net.URL.new(url)
    @service = DocumentRepositoryService.new(service_url)
    @port = @service.getDocumentRepositoryPortSoap12()
  end
  
  
  def provide_and_register_document_set(metadata, document)
    sor = SubmitObjectsRequest.new
    sor.setRegistryObjectList(metadata.create_registry_object_list)
    pardsr = ProvideAndRegisterDocumentSetRequestType.new
    pardsr.setSubmitObjectsRequest(sor)
    web_service_document = ProvideAndRegisterDocumentSetRequestType.Document.new
    web_service_document.setValue(document.to_java_bytes)
    web_service_document.setId('the_document')
    pardsr.getDocument().add(web_service_document)
    @port.documentRepositoryProvideAndRegisterDocumentSetB(pardsr)
  end
end