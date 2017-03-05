require 'avro_turf'
require 'minitest/autorun'


class AvroTest < MiniTest::Unit::TestCase
  def setup
    @avro = AvroTurf.new(schemas_path: 'schemas/')

    john = {
      full_name: 'John',
      address: {
        street: '1st st.',
        city: 'Citytown'
      }
    }

    @avro.encode(john, schema_name: 'person')

    @people = [
      john,
      {
        full_name: 'Jane',
        address: {
          street: '2nd st.',
          city: 'Chinatown'
        }
      }]
  end

  # raises `real_parse': Unknown type: {"type"=>"array", "items"=>"person"} (Avro::SchemaParseError)`
  def test_that_this_will_fail
    assert_raises(Avro::SchemaParseError) do
      @avro.encode(@people, schema_name: 'person_list')
    end
  end

  def test_that_this_works
    assert_instance_of(String, @avro.encode(@people, schema_name: 'person_array'))
  end
end