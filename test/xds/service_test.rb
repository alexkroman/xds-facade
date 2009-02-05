require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class ServiceTest < Test::Unit::TestCase
  context "An XDS Service" do
    setup do
      @service = XDS::Service.new('http://127.0.0.1:8080/axis2/services/xdsrepositoryb')
    end

    should "provide and register a document set" do
      md = Factory.build(:metadata) 
      document = %{
        
        
        <?xml version="1.0" encoding="UTF-8"?>
        <ClinicalDocument xsi:schemaLocation="urn:hl7-org:v3 http://xreg2.nist.gov:8080/hitspValidation/schema/cdar2c32/infrastructure/cda/C32_CDA.xsd" xmlns:sdtc="urn:hl7-org:sdtc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:hl7-org:v3">
          <typeId extension="POCD_HD000040" root="2.16.840.1.113883.1.3"/>
          <templateId assigningAuthorityName="CDA/R2" root="2.16.840.1.113883.3.27.1776"/>
          <templateId assigningAuthorityName="CCD" root="2.16.840.1.113883.10.20.1"/>
          <templateId assigningAuthorityName="HITSP/C32" root="2.16.840.1.113883.3.88.11.32.1"/>
          <id extension="Laika C32 Test" assigningAuthorityName="Laika: An Open Source EHR Testing Framework projectlaika.org" root="2.16.840.1.113883.3.72"/>
          <code code="34133-9" displayName="Summarization of patient data" codeSystemName="LOINC" codeSystem="2.16.840.1.113883.6.1"/>
          <title>anthony ray</title>
          <effectiveTime value="20090203000000-0500"/>
          <confidentialityCode/>
          <languageCode code="en-US"/>
          <recordTarget>
            <patientRole>
              <id extension="LA0000000568"/>
              <addr>
                <streetAddressLine>123 CITY WEST PKWY #3202</streetAddressLine>
                <city>EDEN PRAIRIE</city>
                <state>MN</state>
                <postalCode>55644</postalCode>
                <country>US</country>
              </addr>
              <telecom value="tel:+1(952)221-1111" use="HP"/>
              <patient>
                <name>
                  <given qualifier="CL">ANTHONY</given>
                  <family qualifier="BR">RAY</family>
                  <suffix>JR.</suffix>
                </name>
                <administrativeGenderCode code="M" displayName="Male" codeSystemName="HL7 AdministrativeGenderCodes" codeSystem="2.16.840.1.113883.5.1">
                  <originalText>AdministrativeGender codes are: M (Male), F (Female) or UN (Undifferentiated).</originalText>
                </administrativeGenderCode>
              </patient>
            </patientRole>
          </recordTarget>
          <custodian>
            <assignedCustodian>
              <representedCustodianOrganization>
                <id/>
              </representedCustodianOrganization>
            </assignedCustodian>
          </custodian>
          <participant typeCode="IND">
            <templateId root="2.16.840.1.113883.3.88.11.32.3"/>
            <time>
            </time>
            <associatedEntity classCode="NOK">
              <code code="GRNDDAU" displayName="Granddaughter" codeSystemName="RoleCode" codeSystem="2.16.840.1.113883.5.111"/>
              <addr>
                <streetAddressLine>444 carla rd</streetAddressLine>
                <city>carla city</city>
                <state>MN</state>
                <postalCode>55877</postalCode>
                <country>US</country>
              </addr>
              <telecom value="tel:+1(998)888-7745" use="HP"/>
              <associatedPerson>
                <name>
                  <given qualifier="CL">carla</given>
                  <family qualifier="BR">ray</family>
                </name>
              </associatedPerson>
            </associatedEntity>
          </participant>
          <documentationOf>
            <serviceEvent classCode="PCPR">
              <effectiveTime>
                <low value="0"/>
                <high value="2010"/>
              </effectiveTime>
              <performer typeCode="PRF">
                <templateId assigningAuthorityName="HITSP/C32" root="2.16.840.1.113883.3.88.11.32.4"/>
                <functionCode code="PP" displayName="Primary Care Provider" codeSystemName="Provider Role" codeSystem="2.16.840.1.113883.12.443">
                </functionCode>
                <time>
                </time>
                <assignedEntity>
                  <id/>
                  <addr>
                    <streetAddressLine>regular prov addr</streetAddressLine>
                    <city>regular prov city</city>
                    <state>MN</state>
                    <postalCode>55644</postalCode>
                    <country>US</country>
                  </addr>
                  <assignedPerson>
                    <name>
                      <given qualifier="CL">ANTON</given>
                      <family qualifier="BR">RE</family>
                    </name>
                  </assignedPerson>
                </assignedEntity>
              </performer>
            </serviceEvent>
          </documentationOf>
          <component>
            <structuredBody>
            </structuredBody>
          </component>
        </ClinicalDocument>
      }
      response = @service.provide_and_register_document_set(md, document)
      puts response
    end

  end
end
