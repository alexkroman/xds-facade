module XDS
  class XdsRequestEntity < MultipartRequestEntity
     MULTIPART_FORM_CONTENT_TYPE = "multipart/related"
     attr_accessor :start
     attr_accessor :start_info
     attr_accessor :action
     attr_accessor :type
     
     def getContentType()    
      buffer = %{#{MULTIPART_FORM_CONTENT_TYPE}; type="#{@type}"; start="<#{@start}>"; start-info="#{@start_info}"; action="#{action}"; boundary=#{EncodingUtil.getAsciiString(getMultipartBoundary())}}
     end
  end
end