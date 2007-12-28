require File.dirname(__FILE__) + '/../../spec_helper'

describe "File.identical?" do  
  before :each do    
    @file1 = 'test.txt'
    @file2 = 'test2.txt'
    @file3 = 'test.lnk'
    File.delete(@file3) if File.exists?(@file3)
     
    File.open(@file1,"w+") { |f| f.puts "file1" }
    File.open(@file2,"w+") { |f| f.puts "file2" }
    File.link(@file1, @file3)
  end
  
  after :each do
    File.unlink(@file3)
    File.delete(@file1) if File.exists?(@file1)    
    File.delete(@file2) if File.exists?(@file2)     
    @file1 = nil
    @file1 = nil
    @file1 = nil
  end

  it "return a Boolean class" do 
    File.identical?(@file1, @file2).class.should == FalseClass
    File.identical?(@file1, @file1).class.should == TrueClass
  end

  it "return true if they are identical" do
    File.identical?(@file1, @file1).should == true
    File.identical?(@file1, @file2).should == false
    File.identical?(@file1, @file3).should == true
  end

  it "raise an exception if the arguments are the wrong type or of incorrect number" do
    lambda { File.identical?(@file1, @file2, @file3) }.should raise_error(ArgumentError)
    lambda { File.identical?(1,1) }.should raise_error(TypeError)
  end

  it "identical? should return true if both named files are identical" do
    begin
      file = '/tmp/i_exist'
      file2 = '/tmp/i_exist_too'
      File.open(file,'w'){|f| f.write 'rubinius'}
      File.open(file2,'w'){|f| f.write 'ruby'}
      File.identical?(file,file).should == true
      File.identical?(file,file2).should == false
    ensure
      File.delete(file) rescue nil
      File.delete(file2) rescue nil
    end
  end  
end
