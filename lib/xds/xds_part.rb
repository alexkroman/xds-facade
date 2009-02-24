module XDS
  import "org.apache.commons.httpclient.util.EncodingUtil"
  CRLF_BYTES = EncodingUtil.getAsciiBytes("\r\n");

  class XdsPart < org.apache.commons.httpclient.methods.multipart.StringPart
    
    attr_accessor :id
    
    def length
      super + XDS::CRLF_BYTES.length + EncodingUtil.get_ascii_bytes(get_id).length
    end
    
    
    def send_id(out)
      out.write(XDS::CRLF_BYTES)
      out.write(EncodingUtil.get_ascii_bytes(get_id))     
    end
    
    # /***
    #    298      * Write all the data to the output stream.
    #    299      * If you override this method make sure to override 
    #    300      * #length() as well
    #    301      * 
    #    302      * @param out The output stream
    #    303      * @throws IOException If an IO problem occurs.
    #    304      */
    def send( out)   
     sendStart(out);
     sendDispositionHeader(out)
     sendContentTypeHeader(out)
     send_id(out)
     sendTransferEncodingHeader(out)
     
     sendEndOfHeader(out)
     sendData(out)
     sendEnd(out)
   end
   
   private 
   def get_id
      "Content-ID: <#{@id}>"
   end
  end
end
