module XDS
  class Author
    include XDS::Helper
    CLASSIFICATION_SCHEME = 'urn:uuid:93606bcf-9494-43ec-9b4e-a7748d1a838d'
    
    attr_accessor :institution, :person, :role, :specialty
  
    def create_classification(object_id)
      classification = ClassificationType.new
      uri = ReferenceURI::Factory.fromString(CLASSIFICATION_SCHEME,nil)
      
      classification.setClassificationScheme(uri)
      classification.setClassifiedObject(ReferenceURI::Factory.fromString(object_id,nil))
    
      dump_value_to_slot(classification, 'authorInstitution', @institution)
      dump_value_to_slot(classification, 'authorPerson', @person)
      dump_value_to_slot(classification, 'authorRole', @role)
      dump_value_to_slot(classification, 'authorSpecialty', @specialty)
    
      classification
    end
  
    def dump_value_to_slot(classification, value_name, value)
      if value
        st = SlotType1.new
        st.setName(LongName::Factory.fromString(value_name,nil))
        vlt = ValueListType.new
        vlts = ValueListTypeSequence.new
        vlts.setValue(LongName::Factory.fromString(value,nil))
        vlt.addValueListTypeSequence(vlts)
        st.setValueList(vlt)
        classification.addSlot(st)
      end
    end
    
    
  end
end