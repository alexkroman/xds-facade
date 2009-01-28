module XDS
  class CodedAttribute

    attr_accessor :code, :display_name, :coding_scheme
    attr_reader :classification_scheme
  
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
    end
  
    def create_classification(object_id)
      classification = ClassificationType.new
      classification.setClassificationScheme(@classification_scheme)
      classification.setClassifiedObject(object_id)
      classification.setNodeRepresentation(@code)
    
      ist = InternationalStringType.new
      lst = LocalizedStringType.new
      lst.setValue(@display_name)
      ist.getLocalizedString().add(lst)

      classification.setName(ist)
    
      st = SlotType1.new
      st.setName("codingScheme")
      vlt = ValueListType.new
      vlt.getValue().add(@coding_scheme)
      st.setValueList(vlt)
      classification.getSlot().add(st)
    
      classification
    end
  end
end