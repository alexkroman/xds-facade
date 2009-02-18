require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class MimeMessageParserTest < Test::Unit::TestCase
  context "A MimeMessageParser" do
    setup do
      @file_input_stream = java.io.FileInputStream.new(File.expand_path(File.dirname(__FILE__) + '/../data/mime_message.txt'))
      @content_type = 'multipart/related; boundary=MIMEBoundaryurn_uuid_AE54CA7CD31A4A6AC31234898619749'
    end
    
    should "parse a mime message" do
      parts = MIME::MimeMessageParser.parse(@file_input_stream, @content_type)
      assert parts
      assert_equal "<0.urn:uuid:AE54CA7CD31A4A6AC31234898619750@apache.org>", parts[0][:content_id]
      assert_equal 'application/xop+xml; charset=UTF-8; type="application/soap+xml"', parts[0][:content_type]
      assert_equal "<1.urn:uuid:AE54CA7CD31A4A6AC31234898619752@apache.org>", parts[1][:content_id]
      assert_equal 'text/plain', parts[1][:content_type]
      
    end
    
    teardown do
      @file_input_stream.close
    end
    
  end
end