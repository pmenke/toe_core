# encoding: utf-8

# To change this template, choose Tools | Templates
# and open the template in the editor.


$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require File.dirname(__FILE__) + '/helper'
require 'benchmark'

class TestPraatPorters < Test::Unit::TestCase

  def setup
  end

  def test_2001_elan_porter
    doc = ToE::Porter::ElanPorter.read(File.dirname(__FILE__) + "/assets/input.eaf", nil)
    assert doc
    assert doc.id
    porter = ToE::Porter::ToEPorter.instance
    porter.write(doc, File.dirname(__FILE__) + "/assets/outputEaf.toe")
  end

end
