module XDS
  class Metadata
    attr_accessor :author
    attr_accessor :availability_status
    attr_accessor :class_code
    attr_accessor :confidentiality_code
    attr_accessor :creation_time
    attr_accessor :format_code
    attr_accessor :healthcare_facility_type_code
    attr_accessor :language_code
    attr_accessor :mime_type
    attr_accessor :patient_id
    attr_accessor :practice_setting_code
    attr_accessor :service_start_time, :service_stop_time
    attr_accessor :size
    attr_accessor :source_patient_id
    attr_accessor :source_patient_info
    attr_accessor :type_code
    attr_accessor :unique_id
    attr_accessor :uri
  
    def create_registry_object_list()
      object_id = 'the_document'
      rol = RegistryObjectListType.new
    
      rol.getIdentifiable().add(@author.create_classification(object_id))
      rol.getIdentifiable().add(@class_code.create_classification(object_id))
      rol.getIdentifiable().add(@confidentiality_code.create_classification(object_id))
    
      rol.getIdentifiable().add(create_identifiable_type('creationTime', creation_time.strftime('%Y%m%d')))
    
      rol.getIdentifiable().add(@format_code.create_classification(object_id))
      rol.getIdentifiable().add(@healthcare_facility_type_code.create_classification(object_id))
      rol.getIdentifiable().add(create_identifiable_type('languageCode', @language_code))
    
      eo = ExtrinsicObjectType.new
      eo.setMimeType(@mime_type)
      eo.setId(object_id)
      rol.getIdentifiable().add(eo)
    
      rol.getIdentifiable().add(create_external_identifier(:patient_id))
    
      rol.getIdentifiable().add(@practice_setting_code.create_classification(object_id))
    
      if @service_start_time
        rol.getIdentifiable().add(create_identifiable_type('serviceStartTime', service_start_time.strftime('%Y%m%d')))
      end

      if @service_stop_time
        rol.getIdentifiable().add(create_identifiable_type('serviceStopTime', service_stop_time.strftime('%Y%m%d')))
      end
    
      rol.getIdentifiable().add(create_identifiable_type('sourcePatientId', source_patient_id))
    
      rol.getIdentifiable().add(@source_patient_info.create_identifiable_type)
    
      rol.getIdentifiable().add(@type_code.create_classification(object_id))
    
      rol.getIdentifiable().add(create_external_identifier(:unique_id))
    
      rol
    end
  
    def create_identifiable_type(slot_name, slot_value)
      it = IdentifiableType.new
      st = SlotType1.new
      st.setName(slot_name)
      vlt = ValueListType.new
      vlt.getValue().add(slot_value)
      st.setValueList(vlt)
      it.getSlot().add(st)
    
      it
    end
  
    def create_external_identifier(name)
      ei = ExternalIdentifierType.new
    
      ist = InternationalStringType.new
      lst = LocalizedStringType.new
      case name
      when :patient_id
        ei.setIdentificationScheme('urn:uuid:58a6f841-87b3-4a3e-92fd-a8ffeff98427')
        lst.setValue('patientId')
      when :unique_id
        ei.setIdentificationScheme('urn:uuid:2e82c1f6-a085-4c72-9da3-8640a32e42ab')
        lst.setValue('XDSDocumentEntry.uniqueId')
      end
    
      ist.getLocalizedString().add(lst)
      ei.setName(ist)
      ei.setValue(self.send(name))
    
      ei
    end

  end
end