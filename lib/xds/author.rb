module XDS
  class Author
    include XDS::Helper
    CLASSIFICATION_SCHEME = 'urn:uuid:93606bcf-9494-43ec-9b4e-a7748d1a838d'
    
    attr_accessor :institution, :person, :role, :specialty
    
    def initialize(institution="",person="", role="",specialty="")
        @institution = institution
        @person = person
        @role=role
        @specialty=specialty
    end
    
    def to_soap(builder, object_id)
      create_classification(builder,CLASSIFICATION_SCHEME,object_id,"") do |build|
        create_slot(builder,'authorInstitution', [@institution])
        create_slot(builder,'authorPerson', @person)
        create_slot(builder,'authorRole', @role)
        create_slot(builder,'authorSpecialty', @specialty)
      end
    end
    
    def from_extrinsic_object(eo_node)
      with_classification(eo_node, CLASSIFICATION_SCHEME) do |classification|
        @institution = get_slot_value(classification, 'authorInstitution')
        @person = get_slot_value(classification, 'authorPerson')
        @role = get_slot_value(classification, 'authorRole')
        @specialty = get_slot_value(classification, 'authorSpecialty')
      end
    end
  end
end