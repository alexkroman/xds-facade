if RUBY_PLATFORM =~ /java/
  require 'rubygems'
  require 'xds-client'
  
  require 'java'
  
  import org.projectlaika.xds.SlotType1
  import org.projectlaika.xds.ClassificationType
  import org.projectlaika.xds.ValueListType
  import org.projectlaika.xds.RegistryObjectListType
  import org.projectlaika.xds.InternationalStringType
  import org.projectlaika.xds.LocalizedStringType
  import org.projectlaika.xds.IdentifiableType
  import org.projectlaika.xds.ExtrinsicObjectType
  import org.projectlaika.xds.ExternalIdentifierType
  import org.projectlaika.xds.ProvideAndRegisterDocumentSetRequestType
  import org.projectlaika.xds.DocumentRepositoryService
  import org.projectlaika.xds.SubmitObjectsRequest
  
  require File.expand_path(File.dirname(__FILE__) + '/xds/author')
  require File.expand_path(File.dirname(__FILE__) + '/xds/coded_attribute')
  require File.expand_path(File.dirname(__FILE__) + '/xds/metadata')
  require File.expand_path(File.dirname(__FILE__) + '/xds/service')
  require File.expand_path(File.dirname(__FILE__) + '/xds/source_patient_info')
  
else
  warn "xds-facade is only for use with JRuby"
end