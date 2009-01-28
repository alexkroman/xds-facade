module XDS
  class SourcePatientInfo
    # These fields will need to be entered in HL7v2 format by the user
    attr_accessor :source_patient_identifier, :name, :gender, :date_of_birth, :address
  
    def create_identifiable_type
      it = IdentifiableType.new
      st = SlotType1.new
      st.setName('sourcePatientInfo')
      vlt = ValueListType.new
      vlt.getValue().add("PID-3|#{@source_patient_identifier}")
      vlt.getValue().add("PID-5|#{@name}")
      vlt.getValue().add("PID-8|#{@gender}")
      vlt.getValue().add("PID-7|#{@date_of_birth.strftime('%Y%m%d')}")
      vlt.getValue().add("PID-11|#{@address}")
      st.setValueList(vlt)
      it.getSlot().add(st)
      it
    end
  end
end