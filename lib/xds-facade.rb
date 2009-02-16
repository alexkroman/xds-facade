if RUBY_PLATFORM =~ /java/
  require 'rubygems'
  require 'builder'
  require 'uuid'
  require 'java'
  
  require 'lib/apache-mime4j-0.5.jar'
  require 'lib/commons-codec-1.3.jar'
  require 'lib/commons-logging-1.1.1.jar'
  require 'lib/httpclient-4.0-beta2.jar'
  require 'lib/httpcore-4.0-beta3.jar'
  require 'lib/httpmime-4.0-beta2.jar'
  
  import "org.apache.http.impl.client.DefaultHttpClient"
  import "org.apache.http.client.methods.HttpPost"
  import "org.apache.http.entity.StringEntity"
  

  require File.expand_path(File.dirname(__FILE__) + '/xds/helper')
  require File.expand_path(File.dirname(__FILE__) + '/xds/xds_header')
  require File.expand_path(File.dirname(__FILE__) + '/xds/xds_request')
  require File.expand_path(File.dirname(__FILE__) + '/xds/author')
  require File.expand_path(File.dirname(__FILE__) + '/xds/coded_attribute')
  require File.expand_path(File.dirname(__FILE__) + '/xds/metadata')
  require File.expand_path(File.dirname(__FILE__) + '/xds/source_patient_info')
  require File.expand_path(File.dirname(__FILE__) + '/xds/retrieve_document_set_request')
  
else
  warn "xds-facade is only for use with JRuby"
end