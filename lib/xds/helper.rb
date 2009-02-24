module XDS
  module Helper
    
    
    def create_extrinsic_object(builder,id,mime_type,object_type, &block)    
      builder.ExtrinsicObject("id"=>id,"mimeType"=>mime_type,"objectType"=>object_type) do 
        yield builder if block_given?
      end
    end
    
    def create_external_identifier(builder,id,reg_object,scheme, value, &block)
      
      builder.ExternalIdentifier("id"=>id,"registryObject"=>reg_object,"identificationScheme"=>scheme,"value"=>value) do
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
    
    def create_classification(builder,scheme, classified_object,node_rep ,id=UUID.new.generate,&block)
      builder.Classification("classificationScheme"=>scheme, 
                             "classifiedObject"=>classified_object,
                             "nodeRepresentation"=>node_rep,
                             "id"=>id) do
                      
          yield builder if block_given?
      end
    end
    
    def with_classification(eo_node, classification_scheme, &block)
      if block_given?
        classification = REXML::XPath.first(eo_node, "rim:Classification[@classificationScheme='#{classification_scheme}']", {'rim' => 'urn:oasis:names:tc:ebxml-regrep:xsd:rim:3.0'})
        if classification
          yield classification
        end
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
    
    def get_slot_values(eo_node, slot_name)
      value_nodes = REXML::XPath.match(eo_node, "rim:Slot[@name='#{slot_name}']/rim:ValueList/rim:Value", {'rim' => 'urn:oasis:names:tc:ebxml-regrep:xsd:rim:3.0'})
      if value_nodes
        return value_nodes.map {|n| n.text}
      else
        return nil
      end
    end
    
    def get_external_identifier_value(eo_node, scheme)
      ei_node = REXML::XPath.first(eo_node, "rim:ExternalIdentifier[@identificationScheme='#{scheme}']", {'rim' => 'urn:oasis:names:tc:ebxml-regrep:xsd:rim:3.0'})
      ei_node.attributes['value'] if ei_node
    end
  end
end
