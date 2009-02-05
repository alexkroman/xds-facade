module XDS
  class SourcePatientInfo
    include XDS::Helper
    # These fields will need to be entered in HL7v2 format by the user
    attr_accessor :source_patient_identifier, :name, :gender, :date_of_birth, :address
  
    def create_identifiable_type
      it = IdentifiableType.new
      st = SlotType1.new
      st.setName(to_long_name('sourcePatientInfo'))
      vlt = ValueListType.new
      
       ["PID-3|#{@source_patient_identifier}", 
         "PID-5|#{@name}",
        "PID-8|#{@gender}",
        "PID-7|#{@date_of_birth.strftime('%Y%m%d')}",
        "PID-11|#{@address}"].each do |value|
        vlts = ValueListTypeSequence.new
        vlts.setValue(to_long_name(value))
        vlt.addValueListTypeSequence(vlts)
    end

      st.setValueList(vlt)
      it.addSlot(st)
      it
    end
  end
end