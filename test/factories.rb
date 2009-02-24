Factory.define(:author, :class => XDS::Author) do |a|
  a.institution('CCHIT')
  a.person('Test User')
  a.role('Tester')
  a.specialty('Testing Things')
end

Factory.define(:source_patient_info, :class => XDS::SourcePatientInfo) do |s|
  s.source_patient_identifier('1825a09e14144fc^^^&1.19.6.24.109.42.1.3&ISO')
  s.name('STEPHEN^COLBERT^^^')
  s.date_of_birth(Time.now)
  s.gender('M')
  s.address('101 MIDDLESEX TPKE^^BURLINGTON^MA^01803^USA')
end

Factory.define(:metadata, :class => XDS::Metadata) do |m|
  m.author(Factory.build(:author))
  m.class_code(XDS::CodedAttribute.new(:class_code, 'Consent', 'Consent', 'Connect-a-thon classCodes'))
  m.confidentiality_code(XDS::CodedAttribute.new(:confidentiality_code, 'T', 'Taboo', 'Connect-a-thon confidentialityCodes'))
  m.creation_time(Time.now)
  m.format_code(XDS::CodedAttribute.new(:format_code, 'CDAR2/IHE 1.0', 'CDAR2/IHE 1.0', 'Connect-a-thon formatCodes'))
  m.healthcare_facility_type_code(XDS::CodedAttribute.new(:healthcare_facility_type_code, 'Hospital Unit', 'Hospital Unit', 'Connect-a-thon healthcareFacilityTypeCodes'))
  m.language_code('en-us')
  m.mime_type('text/xml')
  m.patient_id('1825a09e14144fc^^^&1.19.6.24.109.42.1.3&ISO')
  m.practice_setting_code(XDS::CodedAttribute.new(:practice_setting_code, 'Laboratory', 'Laboratory', 'Connect-a-thon practiceSettingCodes'))
  m.source_patient_id('1234^^^projectlaika.org')
  m.source_patient_info(Factory.build(:source_patient_info))
  m.type_code(XDS::CodedAttribute.new(:type_code, '28570-0', 'Procedure Note', 'LOINC'))
  m.unique_id("1.3.6.1.4.1.21367.2005.3.7^14579")
end