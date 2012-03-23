# encoding: utf-8

# To change this template, choose Tools | Templates
# and open the template in the editor.


$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require File.dirname(__FILE__) + '/helper'
require 'benchmark'

class TestPraatPorters < Test::Unit::TestCase

  def setup
    #@porter = ToE::Porter::ToEPorter.instance
    #@testdocument = ToE::Porter::ToEPorter.read(File.dirname(__FILE__) + "/assets/CompleteToeDocument.toe", @porter)    
  end
  
  
  # assure that import runs in one second or less.
  def test_0000_read_benchmark
    doc = ToE::Porter::ShortTextGridPorter.read(File.dirname(__FILE__) + "/assets/input.ShortTextGrid", nil)
    porter = ToE::Porter::ToEPorter.instance
    porter.write(doc, File.dirname(__FILE__) + "/assets/output.toe")  
  end

end
