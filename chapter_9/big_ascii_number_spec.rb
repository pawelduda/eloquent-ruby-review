require './big_ascii_number'

test_ascii = "-**----*--***--***---*---****--**--****--**---**--
*--*--**-----*----*-*--*-*----*-------*-*--*-*--*-
*--*---*---**---**--****-***--***----*---**---***-
*--*---*--*-------*----*----*-*--*--*---*--*----*-
-**---***-****-***-----*-***---**---*----**---**--
--------------------------------------------------
"

describe BigAsciiNumber do
  before :each do
    @big_ascii_number = BigAsciiNumber.new
  end

  it 'should be initialized with 6 empty lines' do
    expect(@big_ascii_number.state).to eq "\n\n\n\n\n\n"
  end

  it 'should insert an extra column of dashes between digits' do
    expect(@big_ascii_number.insert_break.to_s).to eq "-\n-\n-\n-\n-\n-\n"
  end

  it 'should print 0123456789 in ascii' do
    big_ascii_number = BigAsciiNumber.new('0123456789')
    expect(big_ascii_number.to_ascii.to_s).to eq test_ascii
  end

  it 'should end with a column of dashes after conversion' do
    big_ascii_number = BigAsciiNumber.new('123').to_ascii

    big_ascii_number.to_s.each_line do |line|
      expect(line[-2..-1]).to eq "-\n"
    end
  end

  it 'should have a row of dashes below the ascii number' do
    big_ascii_number = BigAsciiNumber.new('123')
    big_ascii_number.to_s.lines[-1][0..-1].split.each do |char|
      expect(char).to eq '-'
    end
  end
end
