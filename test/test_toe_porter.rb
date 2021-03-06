# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require File.dirname(__FILE__) + '/helper'
require 'benchmark'

class TestToEPorter < Test::Unit::TestCase

  def setup
    @porter = ToE::Porter::ToEPorter.instance
    @testdocument = ToE::Porter::ToEPorter.read(File.dirname(__FILE__) + "/assets/CompleteToeDocument.toe", @porter)    
  end
  
  
  # assure that import runs in one second or less.
  def test_0000_read_benchmark
    n = 128.0
    t = Benchmark.realtime{ n.to_i.times { setup } }
    puts "Benchmark: one import in about #{(t*1000.0/n)} milliseconds."
    assert (1.0*n) > t, "read benchmark took longer than one second."
  end
  
  def test_0001_write_benchmark
    n = 128.0
    t = Benchmark.realtime{ n.to_i.times { @porter.write(@testdocument, File.dirname(__FILE__) + "/assets/OutputDocument.toe") } }
    puts "Benchmark: one export in about #{(t*1000.0/n)} milliseconds."
    assert (1.0*n) > t, "write benchmark took longer than one second."
  end
  
  def test_0003_list_storage
    assert_nothing_raised do
      puts "Storage Size: #{@porter.storage_size}"
      #puts @porter.list_storage
    end
  end
  
  def test_0005_immediate_export
    assert_nothing_raised do
      @porter.write(@testdocument, File.dirname(__FILE__) + "/assets/OutputDocument.toe")
    end
  end
  
  def test_0008_marshaling_dump_speed
    n = 64.0
    @mfile = File.open(File.dirname(__FILE__) + "/assets/MarshalledDocument.dat", "w+")
    otime = Benchmark.realtime do
      n.to_i.times do
        Marshal.dump(@testdocument, @mfile)
      end
    end
    puts "avg marshal export: #{1000.0*otime/n} milliseconds"
    assert true
  end
  
  def test_0009_marshaling_load_speed
    n = 64.0
    @indoc = nil
    #@mfile = File.open(File.dirname(__FILE__) + "/assets/MarshalledDocument.dat", "r")
    #@indoc = Marshal.load(@mfile) { |o|
    #  puts "MO: #{o.class.name}"
    #}
    #assert true
    #return
    itime = Benchmark.realtime do
      n.to_i.times do
        @mfile = File.open(File.dirname(__FILE__) + "/assets/MarshalledDocument.dat", "r")
        @indoc = Marshal.load(@mfile) { |o|
          puts "MO: #{o.class.name}"
        }
      end
      #puts @indoc.describe
      assert @indoc
    end
    
    puts "avg marshal import: #{1000.0*itime/n} milliseconds"
    assert @indoc
  end
  
  def test_1010_toe_porter_read_test_document
    assert_true(@testdocument.is_a? ToE::Model::ToEDocument )
  end

  def test_1020_read_document_name
    assert("eventdocument1", @testdocument.id)
  end
  
  def test_1030_store_resolving
    assert_equal("eventdocument1", @porter.resolve(@testdocument))
  end
  
  def test_1040_document_elements_present
    assert_not_equal(0, @testdocument.scale_set.size)
    #assert_nothing_raised do
    #puts @testdocument.describe
    #end
  end
  
  def test_1050_event_links_working
    assert_nothing_raised do
      @testdocument.event_set
      @testdocument.event_set.events
      @testdocument.event_set.events.first
      @testdocument.event_set.events.first.layers
    end
  end

  # check if the first feature of the sample document responds to all accessors
  # and returns reasonable values.
  def test_1100_feature_fields_complete
    # todo test if all fields of a feature are there
    feature = @testdocument.head.features[0]
    assert feature
    assert feature.type
    assert feature.key
    assert feature.value
  end
  
  # check if the first scale of the sample document responds to all accessors
  # and returns reasonable values
  def test_1200_scale_fields_complete
    scale = @testdocument.scale_set.first
    assert scale
    %w{id unit mode continuous?}.each do |field|
      #puts "<<#{field}>>"
      assert scale.respond_to?(field), "Scale is missing #{field} field."
    end
  end
  
  # check if the layer structure of the sample document responds to all accessors
  # and returns reasonable values
  def test_1300_layer_structure_complete
    struc = @testdocument.layer_structure
    assert struc, "There is no layer structure object."
    
    # layer structure has no further attributes
    # assert non-negative number of layers:
    # 1. there is a size value
    # 2. size value is equal to its abs field => positive
    
    # get variable with layer collection for convenience
    layers = struc.layers
    # check whether this variable contains an object
    assert layers, "layers collection could not be retrieved from document."
    
    # layers should respond to size method
    assert_respond_to layers, :size
    
    #layer size should be greater or equal 0
    assert layers.size>=0, "number of layers is #{layers.size}, that's not positive."
    
    # get variable with first layer for convenience
    layer = layers.first   
    # check whether this variable contains an object
    assert layer, "There is no first layer object in this document."
    
    # assert that a selected layer has all attributes
    %w{name content_structure data_type}.each do |field|
      assert_respond_to layer, field.to_sym, "layer object does not respond to \"#{field}\" method"
      assert layer.send(field), "send does not work on \"#{field}\" method"
      #assert scale.send(field)
    end
    
    #@todo (med) assert that layer connectors exist and contain all relevant attributes
    #connector = 
    
  end

  # check if the event set of the sample document responds to all accessors
  # and returns reasonable values
  def test_1400_event_set_complete
    # @todo complete tests for event set
    assert true
  end
  
end
