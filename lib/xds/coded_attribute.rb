module XDS
  class CodedAttribute
    include XDS::Helper
    attr_reader :classification_scheme, :code, :display_name, :coding_scheme
  
    def initialize(attribute_type, code = nil, display_name = nil, coding_scheme = nil)
      case attribute_type
      when :class_code
        @classification_scheme = 'urn:uuid:41a5887f-8865-4c09-adf7-e362475b143a'
      when :confidentiality_code
        @classification_scheme = 'urn:uuid:f4f85eac-e6cb-4883-b524-f2705394840f'
      when :format_code
        @classification_scheme = 'urn:uuid:a09d5840-386c-46f2-b5ad-9c3699a4309d'
      when :healthcare_facility_type_code
        @classification_scheme = 'urn:uuid:f33fb8ac-18af-42cc-ae0e-ed0b0bdb91e1'
      when :practice_setting_code
        @classification_scheme = 'urn:uuid:cccf5598-8b07-4b77-a05e-ae952c785ead'
      when :type_code
        @classification_scheme = 'urn:uuid:f0306f51-975f-434e-a61c-c59651d33983'
      end
      @code = code
      @display_name = display_name
      @coding_scheme=coding_scheme
    end
    
    def to_soap(builder, object_id)      
      create_classification(builder,@classification_scheme,object_id,@code) do |build|
        create_slot(build,"codingScheme",@coding_scheme || [])
        create_name(build,@display_name)        
      end
    end
    
    def from_extrinsic_object(eo_node)
      with_classification(eo_node, @classification_scheme) do |classification|
        @code = classification.attributes['nodeRepresentation']
        localized_string_node = REXML::XPath.first(classification, 'rim:Name/rim:LocalizedString')
        if localized_string_node
          @display_name = localized_string_node.attributes['value']
        end
        @coding_scheme = get_slot_value(classification, 'codingScheme')
      end
    end
  end  
end