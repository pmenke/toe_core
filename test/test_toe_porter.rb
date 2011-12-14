# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require File.dirname(__FILE__) + '/helper'
require 'benchmark'

class TestToEPorter < Test::Unit::TestCase

  def setup
    @testdocument = ToE::Porter::ToEPorter.read(File.dirname(__FILE__) + "/assets/CompleteToeDocument.toe")    
  end
  
  def test_toe_porter_read_test_document
    assert_true(@testdocument.is_a? ToE::Model::ToEDocument )
  end

  def test_read_document_name
    assert("eventdocument1", @testdocument.id)
  end
  
  def test_document_elements_present
    assert_not_equal(0, @testdocument.scale_set.size)
    assert_nothing_raised do
      puts @testdocument.describe
    end
  end
  
  def test_event_links_working
    assert_nothing_raised do
      @testdocument.event_set
      @testdocument.event_set.events
      @testdocument.event_set.events.first
      @testdocument.event_set.events.first.layers
    end
  end

  # check if the first feature responds to all accessors
  # and returns reasonable values.
  def test_feature_fields_complete
    # todo test if all fields of a feature are there
    feature = @testdocument.head.features[0]
    assert feature
    assert feature.type
    assert feature.key
    assert feature.value
  end
  
  def test_scale_fields_complete
    scale = @testdocument.scale_set.first
    assert scale
    %w{id unit mode continuous?}.each do |field|
      puts "<<#{field}>>"
      assert scale.send(field)
    end
  end
  
  def test_layer_structure_complete
    struc = @testdocument.layer_structure
    assert struc
    
    # layer structure has no further attributes
    # assert non-negative number of layers:
    # 1. there is a size value
    # 2. size value is equal to its abs field => positive
    
    layers = struc.layers
    # layers should respond to size method
    assert_respond_to layers, :size
    
    #layer size should be greater or equal 0
    assert layers.size>=0, "number of layers is #{layers.size}, that's not positive."
    
    #@todo assert that a selected layer has all attributes
    layer = @testdocument.layer_structure.layers.first
    #assert layer
    
  end
  
end
