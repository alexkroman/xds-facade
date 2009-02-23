# Provides an interface to an XDS Document Registry
class DocumentRegistry
  
  
  def initialize(service_url)
    @service_url = service_url
  end
  
  def register_document_set_b
  
  end
  
  # Issues a stored query request to the XDS Document Registry
  # Will return an Array of XDS::Metadata
  # <tt>query</tt> - a Hash where the key is the parameter name and value is the value to query against
  # call-seq:
  # dr = DocumentRegistry.new(http://yourregistry.com/xdsb)
  # dr.registery_stored_query({"$XDSDocumentEntryPatientId" => "'93f3f8a6d100463^^^&1.3.6.1.4.1.21367.2005.3.7&ISO'",
  #                            "$XDSDocumentEntryStatus" => "('urn:oasis:names:tc:ebxml-regrep:StatusType:Approved')"})
  def registery_stored_query(query)
    rsqr = XDS::RegistryStoredQueryRequest.new(@service_url, query)
    rsqr.retrieved_metadata
  end
  
  
end