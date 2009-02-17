module MIME
  class FixedMimeTokenStream < MimeTokenStream
    def initialize()
      config = MimeEntityConfig.new
      config.max_line_len = 4096
      super(config)
    end
  end
  
  class MimeMessageParser
    def self.parse(input_stream)
      parts = []
      mts = FixedMimeTokenStream.new()
      mts.parse(input_stream)
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