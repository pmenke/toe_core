require File.dirname(__FILE__) + '/helper'

class TestToeCore < Test::Unit::TestCase
  
  def get_data_for_snippet(snippet)
    parser = ::LibXML::XML::Parser.string(snippet)
    doc = parser.parse
    el_data = doc.child
    puts el_data.name
    contents = el_data.find_first("./child::*")
    puts contents.name
    data = ::ToE::Model::Data.read(contents)
    return data
  end
  
  def test_3001_string
    data = get_data_for_snippet(<<-ROSEMARY)
      <Data>
        <String>HelloWorld</String>
      </Data>
    ROSEMARY
    assert data
    assert_equal true, data.is_a?(String)
    assert_equal "HelloWorld", data
  end
  
  def test_3011_int
    data = get_data_for_snippet(<<-ROSEMARY)
      <Data>
        <Int>42</Int>
      </Data>
    ROSEMARY
    assert data
    assert_equal true, data.is_a?(Integer)
    assert_equal 42, data
  end

  def test_3021_float
    data = get_data_for_snippet(<<-ROSEMARY)
      <Data>
        <Float>1234.5678</Float>
      </Data>
    ROSEMARY
    assert data
    assert_equal true, data.is_a?(Float)
    assert_in_delta 0.001, 1234.5678, data
  end

  def test_3031_bool
    data = get_data_for_snippet(<<-ROSEMARY)
      <Data>
        <Bool>true</Bool>
      </Data>
    ROSEMARY
    assert data
    assert_equal true, (data.is_a?(TrueClass)||data.is_a?(FalseClass))
    assert_equal true, data   
  end

  def test_3032_bool
    data = get_data_for_snippet(<<-ROSEMARY)
      <Data>
        <Bool>TRUE</Bool>
      </Data>
    ROSEMARY
    assert data
    assert_equal true, (data.is_a?(TrueClass)||data.is_a?(FalseClass))
    assert_equal true, data   
  end
  
  def test_3033_bool
    data = get_data_for_snippet(<<-ROSEMARY)
      <Data>
        <Bool>yes</Bool>
      </Data>
    ROSEMARY
    assert data
    assert_equal true, (data.is_a?(TrueClass)||data.is_a?(FalseClass))
    assert_equal true, data   
  end
  
  def test_3034_bool
    data = get_data_for_snippet(<<-ROSEMARY)
      <Data>
        <Bool>1</Bool>
      </Data>
    ROSEMARY
    assert data
    assert_equal true, (data.is_a?(TrueClass)||data.is_a?(FalseClass))
    assert_equal true, data   
  end
  
  def test_3035_bool
    data = get_data_for_snippet(<<-ROSEMARY)
      <Data>
        <Bool>0</Bool>
      </Data>
    ROSEMARY
    puts data
    # assert data
    assert_equal true, (data.is_a?(TrueClass)||data.is_a?(FalseClass))
    assert_equal false, data   
  end
  
  def test_4001_list_int
    data = get_data_for_snippet(<<-ROSEMARY)
      <Data>
        <List>
          <Int>1</Int>
          <Int>2</Int>
          <Int>3</Int>
        </List>
      </Data>
    ROSEMARY
    assert data
    assert_equal Array, data.class
    assert_equal 3, data.size
  end
  
    def test_4001_map_int
    data = get_data_for_snippet(<<-ROSEMARY)
      <Data>
        <Map>
          <Int key="red">1</Int>
          <Int key="blue">2</Int>
          <Int key="green">3</Int>
        </Map>
      </Data>
    ROSEMARY
    assert data
    assert_equal true, data.is_a?(Hash)
    # assert_equal 3, data.size
    assert data.has_key?("red")
    assert data.has_key?("blue")
    assert data.has_key?("green")
    assert_equal 1, data["red"]
    assert_equal 2, data["blue"]
    assert_equal 3, data["green"]
  end
  
  def test_9001_event_read_write
    
    assert_nothing_raised do
    
      doc = ToEDocument.new
      scale = Scale.new(doc)
      doc.scale_set << scale
      layer = Layer.new(doc)
      doc.layer_structure << layer
      ev = Event.create_interval_event(value: "Hello", min: 0.0, max: 1.0, scale: scale)
      layer.add_event(ev)
    
    end
    
  end
    
end
