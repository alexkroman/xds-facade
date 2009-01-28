class XDS::Author
  CLASSIFICATION_SCHEME = 'urn:uuid:93606bcf-9494-43ec-9b4e-a7748d1a838d'
  
  attr_accessor :institution, :person, :role, :specialty
  
  def create_classification(object_id)
    classification = ClassificationType.new
    classification.setClassificationScheme(CLASSIFICATION_SCHEME)
    classification.setClassifiedObject(object_id)
    
    dump_value_to_slot(classification, 'authorInstitution', @institution)
    dump_value_to_slot(classification, 'authorPerson', @person)
    dump_value_to_slot(classification, 'authorRole', @role)
    dump_value_to_slot(classification, 'authorSpecialty', @specialty)
    
    classification
  end
  
  def dump_value_to_slot(classification, value_name, value)
    if value
      st = SlotType1.new
      st.setName(value_name)
      vlt = ValueListType.new
      vlt.getValue().add(value)
      st.setValueList(vlt)
      classification.getSlot().add(st)
    end
  end
end