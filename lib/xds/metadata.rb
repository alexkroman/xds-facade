module XDS
  class Metadata
    
    EXTERNAL_ID_SCHEMES={:patient_id=> {:scheme=>'urn:uuid:58a6f841-87b3-4a3e-92fd-a8ffeff98427',
                                     :value=>'patientId'},
                         :unique_id=>{:scheme=>'urn:uuid:2e82c1f6-a085-4c72-9da3-8640a32e42ab',
                                      :value=>'XDSDocumentEntry.uniqueId'}
                         }
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

    def to_soap(builder)
    object_id = 'the_document'

      builder.RegistryObjectList do 
        @author.to_soap(object_id)
        @class_code.to_soap(object_id)
        @confidentiality_code.to_soap(object_id)
        
        create_slot(builder,'creationTime', creation_time.strftime('%Y%m%d'))
        
        @format_code.to_soap(object_id)
        @healthcare_facility_type_code.to_soap(object_id)
        
        create_slot(builder,'languageCode', @language_code)
        create_extrinsic_object(builder,object_id,@mime_type,"")
        external_identiier(builder,:pateint_id)

        @practice_setting_code.to_soap(build,object_id)

        if @service_start_time
          create_slot(builder,'serviceStartTime', service_start_time.strftime('%Y%m%d'))
        end
        if @service_stop_time
          create_slot(builder,'serviceStopTime', service_stop_time.strftime('%Y%m%d'))
        end

        create_slot(builder,'sourcePatientId', source_patient_id)

        @source_patient_info.to_soap(builer)
        @type_code.to_soap(builder,object_id)
        
        external_identiier(builder,:unique_id)
        
      end
    end
    
    def load_from_extrinsic_object(eo_node)
      
      
    end

    def external_identifier(builder,name)
      EXTERNAL_ID_SCHEMES[name]
      if ei_params
        create_external_identifier(build,ei_params[:scheme],ei_params[:value])  do |build|
          create_name(builder,self.send(name))
        end
      end
    end
 end
end