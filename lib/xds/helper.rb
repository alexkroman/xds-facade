module XDS
  module Helper
    
     def to_reference_uri(value)
       ReferenceURI::Factory.fromString(value,nil)
     end

     def to_long_name(value)
       LongName::Factory.fromString(value,nil)
     end

     def to_axis_uri(value)
       org.apache.axis2.databinding.types.URI.new(value)
     end

     def to_free_form_text(value)
      fft = FreeFormText.new
      fft.setFreeFormText(value)
      fft
    end
    
    
  end
end
