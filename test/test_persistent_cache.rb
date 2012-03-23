  
require File.dirname(__FILE__) + '/helper'

class TestPersistentCache < Test::Unit::TestCase
  #should "probably rename this file and start testing for real" do
  #  flunk "hey buddy, you should probably rename this file and start testing for real"
  #end
  
  def test_step
    8.times do 
      step1 = ToE::ToECache.instance.step
      step2 = ToE::ToECache.instance.step
      puts "#{step1}, #{step2}"
      assert_equal 1, step2-step1
    end
  end
  
end