module XDS
  class Metadata
    include XDS::Helper
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
    
      rol.addIdentifiable(@author.create_classification(object_id))
      rol.addIdentifiable(@class_code.create_classification(object_id))
      rol.addIdentifiable(@confidentiality_code.create_classification(object_id))
    
      rol.addIdentifiable(create_identifiable_type('creationTime', creation_time.strftime('%Y%m%d')))
    
      rol.addIdentifiable(@format_code.create_classification(object_id))
      rol.addIdentifiable(@healthcare_facility_type_code.create_classification(object_id))
      rol.addIdentifiable(create_identifiable_type('languageCode', @language_code))
    
      eo = ExtrinsicObjectType.new
      eo.setMimeType(to_long_name(@mime_type))
      eo.setId(to_axis_uri(object_id))
      rol.addIdentifiable(eo)
    
      rol.addIdentifiable(create_external_identifier(:patient_id))
    
      rol.addIdentifiable(@practice_setting_code.create_classification(object_id))
    
      if @service_start_time
        rol.addIdentifiable(create_identifiable_type('serviceStartTime', service_start_time.strftime('%Y%m%d')))
      end

      if @service_stop_time
        rol.addIdentifiable(create_identifiable_type('serviceStopTime', service_stop_time.strftime('%Y%m%d')))
      end
    
      rol.addIdentifiable(create_identifiable_type('sourcePatientId', source_patient_id))
    
      rol.addIdentifiable(@source_patient_info.create_identifiable_type)
    
      rol.addIdentifiable(@type_code.create_classification(object_id))
    
      rol.addIdentifiable(create_external_identifier(:unique_id))
    
      rol
    end
  
    def create_identifiable_type(slot_name, slot_value)
      it = IdentifiableType.new
      st = SlotType1.new
      st.setName(LongName::Factory.fromString(slot_name,nil))
      vlt = ValueListType.new
      vlts = ValueListTypeSequence.new
      vlts.setValue(LongName::Factory.fromString(slot_value,nil))
      st.setValueList(vlt)
      it.addSlot(st)
    
      it
    end
  
    def create_external_identifier(name)
      ei = ExternalIdentifierType.new
    
      ist = InternationalStringType.new
      lst = LocalizedStringType.new
      case name
      when :patient_id
        ei.setIdentificationScheme(to_reference_uri('urn:uuid:58a6f841-87b3-4a3e-92fd-a8ffeff98427'))
        lst.setValue(to_free_form_text('patientId'))
      when :unique_id
        ei.setIdentificationScheme(to_reference_uri('urn:uuid:2e82c1f6-a085-4c72-9da3-8640a32e42ab'))
        lst.setValue(to_free_form_text('XDSDocumentEntry.uniqueId'))
      end

      ists = InternationalStringTypeSequence.new
      ists.setLocalizedString(lst)
      ist.addInternationalStringTypeSequence(ists)
    
      ei.setName(ist)
      ei.setValue(to_long_name(self.send(name)))
    
      ei
    end


  end
end