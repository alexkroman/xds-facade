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
    
    def value_list
      ["PID-3|#{@source_patient_identifier}", 
           "PID-5|#{@name}",
          "PID-8|#{@gender}",
          "PID-7|#{@date_of_birth.strftime('%Y%m%d')}",
          "PID-11|#{@address}"]
          
    end
  end
end