module XDS
  class Metadata
    
    EXTERNAL_ID_SCHEMES={:patient_id=> {:scheme=>'urn:uuid:58a6f841-87b3-4a3e-92fd-a8ffeff98427',
                                     :value=>'XDSDocumentEntry.patientId'},
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
    attr_accessor :version_info
    attr_accessor :id
    attr_accessor :ss_unique_id
    attr_accessor :source_id
    attr_accessor :repository_unique_id
    

    def to_soap(builder)
      @id="urn:uid:#{UUID.new.generate}" unless @id

      builder.RegistryObjectList("xmlns"=>"urn:oasis:names:tc:ebxml-regrep:xsd:rim:3.0") do 
         create_extrinsic_object(builder,@id,@mime_type,"urn:uuid:7edca82f-054d-47f2-a032-9b2a5b5186c1") do
          
          create_slot(builder,'languageCode', @language_code) if @language_code
          create_slot(builder,'creationTime', @creation_time) if @creation_time
          create_slot(builder,'serviceStartTime', @service_start_time) if @service_start_time     
          create_slot(builder,'serviceStopTime', @service_stop_time)  if @service_stop_time

          create_slot(builder,'sourcePatientId', @source_patient_id) if @source_patient_id
          @source_patient_info.andand.to_soap(builder)
          
          @version_info.to_soap(builder) if @version_info
          @author.andand.to_soap(builder,@id)       
          @class_code.andand.to_soap(builder,@id) 
          @confidentiality_code.andand.to_soap(builder,@id)     
          @format_code.andand.to_soap(builder,@id) 
          @healthcare_facility_type_code.andand.to_soap(builder, @id)         
          
          @practice_setting_code.andand.to_soap(builder,@id)
          
          @type_code.andand.to_soap(builder,@id)

          external_identifier(builder,:patient_id)
          external_identifier(builder,:unique_id)
        end
       
        builder.RegistryPackage(:id=>"ss01",:objectType=>"urn:oasis:names:tc:ebxml-regrep:ObjectType:RegistryObject:RegistryPackage") do
          create_slot(builder,"submissionTime",Time.now.strftime('%Y%m%d'))
     
          create_classification(builder,"urn:uuid:aa543740-bdda-424e-8c96-df4873be8500","ss01","Initial evaluation","cl01") do
            create_slot(builder,"codingScheme","Connect-a-thon contentTypeCodes")
            create_name(builder,"Initial evaluation")
          end
              
          create_external_identifier(builder,"ss_ei_01","ss01","urn:uuid:96fdda7c-d067-4183-912e-bf5ee74998a8",ss_unique_id)  do |build|
            create_name(builder,"XDSSubmissionSet.uniqueId")
          end
          
          create_external_identifier(builder,"ss_ei_02","ss01","urn:uuid:554ac39e-e3fe-47fe-b233-965d2a147832",source_id)  do |build|
            create_name(builder,"XDSSubmissionSet.sourceId")
          end
          
          create_external_identifier(builder,"ss_ei_03","ss01","urn:uuid:58a6f841-87b3-4a3e-92fd-a8ffeff98427",@source_patient_info.source_patient_identifier)  do |build|
            create_name(builder,"XDSDocumentEntry.patientId")
          end
          
          create_external_identifier(builder,"ss_ei_04","ss01","urn:uuid:6b5aea1a-874d-4603-a4bc-96a0a7b38446",@source_patient_info.source_patient_identifier)  do |build|
            create_name(builder,"XDSSubmissionSet.patientId")
          end
          
          
        end
        builder.Classification(:id=>"ss01_class_id",:classificationScheme=>"urn:uuid:a54d6aa5-d40d-43f9-88c5-b4633d873bdd",:classificationNode=>"urn:uuid:a54d6aa5-d40d-43f9-88c5-b4633d873bdd",:classifiedObject=>"ss01")
        
        
       builder.Association(:id=>"ass_01",:associationType=>"urn:oasis:names:tc:ebxml-regrep:AssociationType:HasMember",:sourceObject=>"ss01",:targetObject=>@id) do
            create_slot(builder,"SubmissionSetStatus","Original")
        end
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
      
      
      @creation_time = get_slot_value(eo_node, 'creationTime')

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
      

      @service_start_time = get_slot_value(eo_node, 'serviceStartTime')
      @service_stop_time = get_slot_value(eo_node, 'serviceStopTime')

      @source_patient_info = SourcePatientInfo.new
      @source_patient_info.from_extrinsic_object(eo_node)
      
      @size = get_slot_value(eo_node, 'size')
      @source_pateint_id = get_slot_value(eo_node, 'sourcePatientId')
      @type_code = CodedAttribute.new(:type_code)
      @type_code.from_extrinsic_object(eo_node)
      @unique_id = get_external_identifier_value(eo_node, EXTERNAL_ID_SCHEMES[:unique_id][:scheme])
      @uri = get_slot_value(eo_node, 'URI')
      @repository_unique_id = get_slot_value(eo_node,"repositoryUniqueId")
    end

    def from_hash(hash, affinity_domain_config)
      if hash['author']
        @author = Author.new(hash['author']['institution'], hash['author']['person'], hash['author']['role'], hash['author']['specialty'])
      end
      @availibility_status = hash['availibility_status']
      @class_code = affinity_domain_config.coded_attribute(:class_code, hash['class_code'])
      @confidentiality_code = affinity_domain_config.coded_attribute(:confidentiality_code, hash['confidentiality_code'])
      @creation_time = hash['creation_time']
      @format_code = affinity_domain_config.coded_attribute(:format_code, hash['format_code'])
      @healthcare_facility_type_code = affinity_domain_config.coded_attribute(:healthcare_facility_type_code, hash['healthcare_facility_type_code'])
      @language_code = affinity_domain_config.coded_attribute(:language_code, hash['language_code'])
      @mime_type = hash['mime_type']
      @patient_id = hash['patient_id']
      @practice_setting_code = affinity_domain_config.coded_attribute(:practice_setting_code, hash['practice_setting_code'])
      @service_start_time = hash['service_start_time']
      @service_stop_time = hash['service_stop_time']
      @source_pateint_id = hash['source_pateint_id']
      @source_patient_info = SourcePatientInfo.new(hash['source_patient_info']) if hash['source_patient_info']
      @type_code = affinity_domain_config.coded_attribute(:type_code, hash['type_code'])
      @unique_id = hash['unique_id']
      @uri = hash['uri']
      @version_info = hash['version_info']
      @ss_unique_id = hash['ss_unique_id']
      @source_id = hash['source_id']
      @repository_unique_id = hash['repository_unique_id']
    end

    def external_identifier(builder,name)
      ei_params = EXTERNAL_ID_SCHEMES[name]
      if ei_params
        create_external_identifier(builder,"urn:uid:#{UUID.new.generate}",@id,ei_params[:scheme],self.send(name))  do |build|
          create_name(builder,ei_params[:value])
        end
      end
    end
 end
end