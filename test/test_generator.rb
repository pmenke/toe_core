  
require File.dirname(__FILE__) + '/helper'

class TestGenerator < Test::Unit::TestCase
  #should "probably rename this file and start testing for real" do
  #  flunk "hey buddy, you should probably rename this file and start testing for real"
  #end
  
  def test_0001_generator_present
    assert ToE::Gen::RandomDocumentGenerator.instance
  end
  
  def test_0002_default_document
    @doc = ToE::Gen::RandomDocumentGenerator.instance.generate
    puts @doc.describe
    assert @doc
  end
  
  def test_0010_write_autogen_document
    @porter = ToE::Porter::ToEPorter.instance
    @doc = ToE::Gen::RandomDocumentGenerator.instance.generate(:events=>4)
    @porter.write(@doc, File.dirname(__FILE__) + "/assets/autogen_0001.toe")
    assert true
  end
  
end