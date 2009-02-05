if RUBY_PLATFORM =~ /java/
  require 'rubygems'
  require 'xds-client'
  
  require 'java'
  
  import org.oasis.ebxml.rim.SlotType1
  import org.oasis.ebxml.rim.ClassificationType
  import org.oasis.ebxml.rim.ValueListType
  import org.oasis.ebxml.rim.ValueListTypeSequence
  import org.oasis.ebxml.rim.RegistryObjectListType
  import org.oasis.ebxml.rim.InternationalStringType
  import org.oasis.ebxml.rim.LocalizedStringType
  import org.oasis.ebxml.rim.IdentifiableType
  import org.oasis.ebxml.rim.ExtrinsicObjectType
  import org.oasis.ebxml.rim.ExternalIdentifierType
  import org.ihe.xds.ProvideAndRegisterDocumentSetRequestType
  import org.ihe.xds.ProvideAndRegisterDocumentSetRequest
  import org.projectlaika.xds.DocumentRepository_Service
  import org.projectlaika.xds.DocumentRepository_ServiceStub
  import org.oasis.ebxml.lcm.SubmitObjectsRequest
  import org.oasis.ebxml.lcm.SubmitObjectsRequest_type0
  import org.ihe.xds.ProvideAndRegisterDocumentSetRequestTypeSequence_type0
  import org.ihe.xds.Document_type0
  
  
  import org.oasis.ebxml.rim.ReferenceURI
  import org.oasis.ebxml.rim.LongName
  import org.oasis.ebxml.rim.FreeFormText
  import org.oasis.ebxml.rim.InternationalStringTypeSequence
  require File.expand_path(File.dirname(__FILE__) + '/xds/helper')
  require File.expand_path(File.dirname(__FILE__) + '/xds/author')
  require File.expand_path(File.dirname(__FILE__) + '/xds/coded_attribute')
  require File.expand_path(File.dirname(__FILE__) + '/xds/metadata')
  require File.expand_path(File.dirname(__FILE__) + '/xds/service')
  require File.expand_path(File.dirname(__FILE__) + '/xds/source_patient_info')
  
else
  warn "xds-facade is only for use with JRuby"
end