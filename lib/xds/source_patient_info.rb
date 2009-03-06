module XDS
  class SourcePatientInfo
    include XDS::Helper
    # These fields will need to be entered in HL7v2 format by the user
    attr_accessor :source_patient_identifier, :name, :gender, :date_of_birth, :address
  
    def initialize(args={})
        @source_patient_identifier = args[:source_patient_identifier] || ""
        @name = args[:name] || ""
        @gender = args[:gender] || ""
        @date_of_birth = args[:date_of_birth] || ""
        @address = args[:address]
    end
  
    def to_soap(builder)         
        create_slot(builder,"sourcePatientInfo",value_list)
    end
    
    def from_extrinsic_object(eo_node)
      patient_values = get_slot_values(eo_node, 'sourcePatientInfo')
      @source_patient_identifier = match_and_strip(patient_values, 'PID-3')
      @name = match_and_strip(patient_values, 'PID-5')
      @gender = match_and_strip(patient_values, 'PID-8')
      @date_of_birth = match_and_strip(patient_values, 'PID-7')
      @address = match_and_strip(patient_values, 'PID-11')
    end
    
    def value_list
      ["PID-3|#{@source_patient_identifier}", 
          "PID-5|#{@name}",
          "PID-8|#{@gender}",
          "PID-7|#{@date_of_birth}",
          "PID-11|#{@address}"]
          
    end

    def match_and_strip(slot_values, pid_segment)
      slot_value = slot_values.find {|field_value| field_value.match("^#{pid_segment}\\|.*")}
      if slot_value
        md = slot_value.match("^#{pid_segment}\\|(.+)")
        if md
          return md[1]
        else
          return nil
        end
      else
        return nil
      end
    end

  end
end