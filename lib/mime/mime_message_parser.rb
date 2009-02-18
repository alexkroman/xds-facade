module MIME
  # The constructor for MimeTokenStream that takes a MimeEntityConfig is
  # protected. We need to pass in a new config becuse the default one
  # has a max line length of 1000. Since we will be getting SOAP repsonses
  # with out new lines, we will easily exceed that. This class produces
  # a MimeTokenStream with a longer max line length
  class FixedMimeTokenStream < MimeTokenStream
    def initialize()
      config = MimeEntityConfig.new
      config.max_line_len = 4096
      super(config)
    end
  end
  
  class MimeMessageParser
    
    # Parses a mime message and returns an array of hashes for each part of the message
    # The hash will contain the following:
    # * <tt>:content_type</tt> - The content type of the message part
    # * <tt>:content_id</tt> - The id of the content (useful for dealing with MTOM/XOP)
    # * <tt>:content</tt> - The actual content of the message as a String
    def self.parse(input_stream, content_type)
      parts = []
      mts = FixedMimeTokenStream.new()
      mts.parse_headless(input_stream, content_type)
      current_message = {}
      until(mts.state == MimeTokenStream::T_END_OF_STREAM)
        case mts.state
        when MimeTokenStream::T_FIELD
          if mts.field_name.eql?('Content-Type')
            current_message[:content_type] = mts.field_value.strip
          end
          if mts.field_name.eql?('Content-ID')
            current_message[:content_id] = mts.field_value.strip
          end
        when MimeTokenStream::T_BODY
          reader = java.io.LineNumberReader.new(mts.reader)
          content = ''
          while (line = reader.readLine)
            content << line
            content << "\n"
          end
          current_message[:content] = content
          parts << current_message
          current_message = {}
        end
        mts.next
      end
      parts
    end
  end
end