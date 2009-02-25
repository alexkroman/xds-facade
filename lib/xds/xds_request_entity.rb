module XDS
  class XdsRequestEntity < org.apache.commons.httpclient.methods.multipart.MultipartRequestEntity
    import "org.apache.commons.httpclient.util.EncodingUtil"
     MULTIPART_FORM_CONTENT_TYPE = "multipart/related"
     attr_accessor :start
     attr_accessor :start_info
     attr_accessor :action
     attr_accessor :type
     
     def getContentType()    
      buffer = %{#{MULTIPART_FORM_CONTENT_TYPE}; type="#{@type}"; start="<#{@start}>"; start-info="#{@start_info}"; action="#{action}"; boundary=#{org.apache.commons.httpclient.util.EncodingUtil.getAsciiString(getMultipartBoundary())}}
     end
  end
end