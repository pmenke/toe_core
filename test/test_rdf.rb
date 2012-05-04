# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require File.dirname(__FILE__) + '/helper'
# require 'benchmark'

class TestRdf < Test::Unit::TestCase

  def setup
    @porter = ToE::Porter::ToEPorter.instance
    @testdocument = ToE::Porter::ToEPorter.read(File.dirname(__FILE__) + "/assets/CompleteToeDocument.toe", @porter)
  end
  
  def test_0001_methods_present
    assert_respond_to @testdocument, :as_rdf
    assert_equal [], @testdocument.as_rdf
  end
  
  def test_0011_to_rdf
    assert_respond_to @testdocument, :to_rdf
    puts @testdocument.to_rdf  
  end
  
  def test_0021_to_rdf
    assert_respond_to @testdocument, :to_ntriples
    puts @testdocument.to_ntriples  
  end
  
end
