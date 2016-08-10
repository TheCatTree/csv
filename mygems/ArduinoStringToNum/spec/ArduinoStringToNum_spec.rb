require 'spec_helper'


describe ArduinoStringToNum do
  
  
  it 'has a version number' do
    expect(ArduinoStringToNum::VERSION).not_to be nil
  end

   context "binary of arduino long" do
    bin_in = ArduinoStringToNum.new(0x0020A107.to_s(2))#128,000,000 long
    it {expect(bin_in.to_long).to eql(128000000)}
 end
 
  context "binary of arduino int" do
    bin_in = ArduinoStringToNum.new(0x840D.to_s(2))#3460 int
    it {expect(bin_in.to_int).to eql(3460)}
 end
  
  context "binary of arduino char" do
    bin_in = ArduinoStringToNum.new(0x61.to_s(2))#3a char
    it {expect(bin_in.to_char).to eql("a")}
 end
 
  context "binary of arduino byte" do
    bin_in = ArduinoStringToNum.new(0x80.to_s(2))#128 byte
    it {expect(bin_in.to_byte).to eql(128)}
 end
 
   context "binary of arduino unsigned long" do
    bin_in = ArduinoStringToNum.new(0xD0110000.to_s(2))#4560
    it {expect(bin_in.to_ulong).to eql(4560)}
 end
 
 context "binary of IEEE 754 == 2.5 " do
    bin_in = ArduinoStringToNum .new(0x00002040.to_s(2)) #little endian bit string of 7.65
   it {expect(bin_in.to_ieee754).to eql(2.5)}
 end
 
 context "binary of IEEE 754 == -7.65 " do
     bin_in = ArduinoStringToNum.new(0xcdccf4c0.to_s(2)) #little endian bit string of -7.65
     it {expect(bin_in.to_ieee754.round(2)).to eql(-7.65)}
 end
 
 context "binary of IEEE 754 == +infinity " do 
    bin_in = ArduinoStringToNum.new(0x0000807f.to_s(2)) #little endian bit string of infinity
    it {expect(bin_in.to_ieee754).to eql(1.0/0.0)}
 end
 
 context "binary of IEEE 754 == -infintiy " do
    bin_in = ArduinoStringToNum.new(0x000080ff.to_s(2)) #little endian bit string of -infinity
    it{expect(bin_in.to_ieee754).to eql(-1.0/0.0)}
 end
 
 context "binary of IEEE 754 == NAN " do
    bin_in = ArduinoStringToNum.new(0xffffff7f.to_s(2)) #little endian bit string of NAN
    it {expect(bin_in.to_ieee754.nan?).to eql(TRUE)}
    
 end
 
 context "binary of IEEE 754 == 0.0 " do
    bin_in = ArduinoStringToNum.new(0x00000000.to_s(2)) #little endian bit string of 0.0
    it {expect(bin_in.to_ieee754).to eql(0.0)}
 end
    
context "binary of IEEE 754 == subnormal " do
    bin_in = ArduinoStringToNum.new(0x01000000.to_s(2)) #little endian bit string of 1.4E-45
    it {expect(bin_in.to_ieee754).to be < (1 * 2**(-126))}
 end    

end
