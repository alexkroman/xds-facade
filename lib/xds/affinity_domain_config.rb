module XDS
  class AffinityDomainConfig
    CODE_TYPE_NAME_TO_CODED_ATTRIBUTE = {
      'classCode' => :class_code,
      'confidentialityCode' => :confidentiality_code,
      'formatCode' => :format_code,
      'healthcareFacilityTypeCode' => :healthcare_facility_type_code,
      'practiceSettingCode' => :practice_setting_code,
      'typeCode' => :type_code
    }
    
    def initialize(config_file)
      config_doc = REXML::Document.new(File.new(config_file, 'r'))
      @code_types = {}
      config_doc.root.elements.each('CodeType') do |code_type|
        code_type_name = code_type.attributes['name']
        if CODE_TYPE_NAME_TO_CODED_ATTRIBUTE[code_type_name]
          attribute_type = CODE_TYPE_NAME_TO_CODED_ATTRIBUTE[code_type_name]
          @code_types[attribute_type] = [] unless @code_types[attribute_type]
          code_type.elements.each('Code') do |code|
            code_value = code.attributes['code']
            display_name = code.attributes['display']
            coding_scheme = code.attributes['codingScheme']
            @code_types[attribute_type] << CodedAttribute.new(attribute_type, code_value, display_name, coding_scheme)
          end
        end
      end
    end
    
    def coded_attribute(attribute_type, code)
      if @code_types[attribute_type]
        @code_types[attribute_type].find() {|ca| ca.code.eql?(code)}
      end
    end
    
    def select_options(attribute_type)
      if @code_types[attribute_type]
        @code_types[attribute_type].map {|ca| [ca.display_name, ca.code]}
      end
    end
  end
end