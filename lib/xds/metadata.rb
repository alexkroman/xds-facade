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
        @author.andand.to_soap(builder,object_id) 
        
        @class_code.andand.to_soap(builder,object_id) 
        @confidentiality_code.andand.to_soap(builder,object_id)
        
        create_slot(builder,'creationTime', @creation_time.strftime('%Y%m%d')) if @creation_time
        
        @format_code.andand.to_soap(builder,object_id) 
        @healthcare_facility_type_code.andand.to_soap(builder, object_id)
        
        create_slot(builder,'languageCode', @language_code) if @language_code
        create_extrinsic_object(builder,object_id,@mime_type,"")
        external_identiier(builder,:pateint_id)

        @practice_setting_code.andand.to_soap(builder,object_id)

        
        create_slot(builder,'serviceStartTime', @service_start_time.strftime('%Y%m%d')) if @service_start_time     
        create_slot(builder,'serviceStopTime', @service_stop_time.strftime('%Y%m%d'))  if @service_stop_time

        create_slot(builder,'sourcePatientId', @source_patient_id) if @source_patient_id

        @source_patient_info.andand.to_soap(builer,object_id)
        @type_code.andand.to_soap(builder,object_id)
        
        external_identiier(builder,:unique_id)
        
      end
    end
    
    def load_from_extrinsic_object(eo_node)
      @author = Author.new
      @author.from_extrinsic_object(eo_node)
      @availability_status = CodedAttribute.new(:availability_status)
      @availability_status.from_extrinsic_object(eo_node)
      @class_code = CodedAttribute.new(:class_code)
      @class_code.from_extrinsic_object(eo_node)
      @confidentiality_code = CodedAttribute.new(:confidentiality_code)
      @confidentiality_code.from_extrinsic_object(eo_node)
      
      creation_time_in_hl7ts = get_slot_value(eo_node, 'creationTime')
      @creation_time = Date.strptime(creation_time_in_hl7ts, '%Y%m%d') if creation_time_in_hl7ts

      @format_code = CodedAttribute.new(:format_code)
      @format_code.from_extrinsic_object(eo_node)
      @healthcare_facility_type_code = CodedAttribute.new(:healthcare_facility_type_code)
      @healthcare_facility_type_code.from_extrinsic_object(eo_node)
      @language_code = CodedAttribute.new(:language_code)
      @language_code.from_extrinsic_object(eo_node)
      
      @mime_type = eo_node.attributes['mimeType']
      
      @patient_id = get_external_identifier_value(eo_node, EXTERNAL_ID_SCHEMES[:patient_id][:scheme])
      
      @practice_setting_code = CodedAttribute.new(:practice_setting_code)
      @practice_setting_code.from_extrinsic_object(eo_node)
      
      service_start_time_in_hl7ts = get_slot_value(eo_node, 'serviceStartTime')
      @service_start_time = Date.strptime(service_start_time_in_hl7ts, '%Y%m%d') if service_start_time_in_hl7ts
      service_stop_time_in_hl7ts = get_slot_value(eo_node, 'serviceStopTime')
      @service_stop_time = Date.strptime(service_stop_time_in_hl7ts, '%Y%m%d') if service_stop_time_in_hl7ts

      @source_patient_info = SourcePatientInfo.new
      @source_patient_info.from_extrinsic_object(eo_node)
      
      @size = get_slot_value(eo_node, 'size')
      @source_pateint_id = get_slot_value(eo_node, 'sourcePatientId')
      @type_code = CodedAttribute.new(:type_code)
      @type_code.from_extrinsic_object(eo_node)
      @unique_id = get_external_identifier_value(eo_node, EXTERNAL_ID_SCHEMES[:unique_id][:scheme])
      @uri = get_slot_value(eo_node, 'URI')
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