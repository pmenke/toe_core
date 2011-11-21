# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'helper'

class TestPorter < Test::Unit::TestCase
  def test_foo
    #TODO: Write test
    
    
    t1 = Time.now
    
    toedocument = ToE::Porter::ToEPorter.read("/Users/pmenke/CompleteToeDocument.toe")
    
    t2 = Time.now
    
    puts "Time: #{t2-t1}"
    
    flunk "TODO: Write test"
    # assert_equal("foo", bar)
  end
end
