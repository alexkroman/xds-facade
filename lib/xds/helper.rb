module XDS
  module Helper
    
    
    def create_extrinsic_object(builder,id,mime_type,object_type, &block)    
      builder.ExtrinsicObject("id"=>id,"mimeType"=>mime_type,"objectType"=>object_type) do 
        yield builder if block_given?
      end
    end
    
    def create_external_identifier(builder,scheme, value, &block)
      
      builder.ExternalIdentifier("identificationScheme"=>scheme,"value"=>value) do
        yield builder if block_given?
      end
    end
    
    def create_name(builder,name,&block)
      builder.Name do
       create_localized_string(builder,name)
        yield builder if block_given?
      end
    end
    
    def create_localized_string(builder,value)
       builder.LocalizedString("value"=>value)
    end
    
    def create_slot(builder, name, value_list=[])
      builder.Slot({"name"=>name}) do
        builder.ValueList do
          value_list.each do |val|
            builder.Value(val)
          end
        end
      end
    end
    
    def create_classification(builder,scheme, classified_object,node_rep ,&block)
      builder.Classification("classificationScheme"=>scheme, 
                             "classifiedObject"=>classified_object,
                             "nodeRepresentation"=>node_rep) do
          yield builder if block_given?
      end
    end
    
    def get_slot_value(eo_node, slot_name)
      value_node = REXML::XPath.first(eo_node, "rim:Slot[@name='#{slot_name}']/rim:ValueList/rim:Value", {'rim' => 'urn:oasis:names:tc:ebxml-regrep:xsd:rim:3.0'})
      if value_node
        return value_node.text
      else
        return nil
      end
    end
  end
end
