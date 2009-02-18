if RUBY_PLATFORM =~ /java/
  require 'rubygems'
  require 'builder'
  require 'uuid'
  require 'java'
  
  require 'lib/commons-codec-1.3.jar'
  require 'lib/commons-logging-1.1.1.jar'
  require 'lib/commons-httpclient-3.1.jar'
  require 'lib/apache-mime4j-0.5.jar'
  
  import "org.apache.commons.httpclient.HttpClient"
  import "org.apache.commons.httpclient.methods.PostMethod"
  import "org.apache.commons.httpclient.methods.StringRequestEntity"
  
  import "org.apache.james.mime4j.parser.MimeTokenStream"
  import "org.apache.james.mime4j.parser.MimeEntityConfig"
  
  require File.expand_path(File.dirname(__FILE__) + '/mime/mime_message_parser')

  require File.expand_path(File.dirname(__FILE__) + '/xds/helper')
  require File.expand_path(File.dirname(__FILE__) + '/xds/xds_header')
  require File.expand_path(File.dirname(__FILE__) + '/xds/xds_request')
  require File.expand_path(File.dirname(__FILE__) + '/xds/author')
  require File.expand_path(File.dirname(__FILE__) + '/xds/coded_attribute')
  require File.expand_path(File.dirname(__FILE__) + '/xds/metadata')
  require File.expand_path(File.dirname(__FILE__) + '/xds/source_patient_info')
  require File.expand_path(File.dirname(__FILE__) + '/xds/retrieve_document_set_request')
  require File.expand_path(File.dirname(__FILE__) + '/xds/retrieve_document_set_response')
  require File.expand_path(File.dirname(__FILE__) + '/xds/registry_stored_query_request')
  
else
  warn "xds-facade is only for use with JRuby"
end

module XDS
  COMMON_NAMESPACES = {'xdsb' => "urn:ihe:iti:xds-b:2007", 
                       'soapenv' =>"http://www.w3.org/2003/05/soap-envelope",
                       'wsa' => "http://www.w3.org/2005/08/addressing",
                       'rs' => "urn:oasis:names:tc:ebxml-regrep:xsd:rs:3.0",
                       'xop' => "http://www.w3.org/2004/08/xop/include"}
end