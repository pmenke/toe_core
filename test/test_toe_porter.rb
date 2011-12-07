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
      @testdocument.describe
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

end
