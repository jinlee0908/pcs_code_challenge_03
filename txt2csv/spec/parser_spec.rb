require "spec_helper"

require "parse.rb"

# The format of the names looks to be something like:

#     [prefix] [first_name] [middle_name | middle_initial] last_name [suffix]

# where: 

# * Everything in [square brackets] is optional. 
# * There may be a middle name or a middle initial, but not both. 
# * If there is a middle name or a last name, there will be a first name. (For "M. Jackson", "M." is the first name.)
# * There is always a last name (For "Miss Jane," "Jane" is a last name)
# * Sometimes the last name is hyphenated (as in "Dr. Huntington-Smythe"). Do not split hyphenated last names.

prefixes = ['M.', 'Mrs.', 'Mr.', 'Dr.', 'Ms.', 'Sister', "Lady"]
suffixes = %w(Jr. Sr. II III IV PhD.)

#country_code area_code prefix line extension

describe Parse do

  it "should parse ddd-ddd-dddd xddd phone numbers" do   
    return_array = Parse.parse_phone("123-456-7890 x213")
    expect(return_array).to eq(["", "123","456","7890","213"])
  end

  it "should parse (ddd)ddd-dddd xddd phone numbers" do   
    return_array = Parse.parse_phone("(123)456-7890 x213")
    expect(return_array).to eq(["", "123","456","7890","213"])
  end

  it "should parse d-ddd-ddd-dddd xddd phone numbers" do   
    return_array = Parse.parse_phone("3-123-456-7890 x213")
    expect(return_array).to eq(["3", "123","456","7890","213"])
  end

  it "should parse ddd.ddd.dddd xddd phone numbers" do   
    return_array = Parse.parse_phone("123.456.7890 x213")
    expect(return_array).to eq(["", "123","456","7890","213"])
  end

  it "should parse ddd-ddd-dddd phone numbers" do   
    return_array = Parse.parse_phone("123-456-7890")
    expect(return_array).to eq(["", "123","456","7890",""])
  end

  it "should parse (ddd)ddd-dddd phone numbers" do   
    return_array = Parse.parse_phone("(123)456-7890")
    expect(return_array).to eq(["", "123","456","7890",""])
  end

  it "should parse d-ddd-ddd-dddd phone numbers" do   
    return_array = Parse.parse_phone("3-123-456-7890")
    expect(return_array).to eq(["3", "123","456","7890",""])
  end

  it "should parse ddd.ddd.dddd phone numbers" do   
    return_array = Parse.parse_phone("123.456.7890")
    expect(return_array).to eq(["", "123","456","7890",""])
  end


##old specs to keep
  it "should parse last names" do   
    return_array = Parse.parse_names(prefixes, suffixes, "Madona")
    expect(return_array).to eq(["","","","Madona",""])
  end

  it "should parse suffixes" do
    return_array = Parse.parse_names(prefixes, suffixes, "Madona Jr.")
    expect(return_array).to eq(["","","","Madona","Jr."])
  end

  it "should parse first names" do

    return_array = Parse.parse_names(prefixes, suffixes, "Mary Madona")
    expect(return_array).to eq(["","Mary","","Madona",""])
  end

  it "should parse first names with suffixes " do

    return_array = Parse.parse_names(prefixes, suffixes, "Mary Madona Jr.")
    expect(return_array).to eq(["","Mary","","Madona","Jr."])
  end

  it "should parse middle names" do

    return_array = Parse.parse_names(prefixes, suffixes, "Mary Samuel Madona")
    expect(return_array).to eq(["","Mary","Samuel","Madona",""])
  end

  it "should parse middle initials" do

    return_array = Parse.parse_names(prefixes, suffixes, "Mary S. Madona")
    expect(return_array).to eq(["","Mary","S.","Madona",""])
  end

  it "should parse middle names & suffixes" do
   
    return_array = Parse.parse_names(prefixes, suffixes, "Mary Samuel Madona III")
    expect(return_array).to eq(["","Mary","Samuel","Madona","III"])
  end

  it "should parse prefixes and last names" do
   
    return_array = Parse.parse_names(prefixes, suffixes, "Lady Madona")
    expect(return_array).to eq(["Lady","","","Madona",""])
  end

  it "should parse prefixes and last names and suffixes" do

    return_array = Parse.parse_names(prefixes, suffixes, "Lady Madona III")
    expect(return_array).to eq(["Lady","","","Madona","III"])
  end

  it "should parse prefixes and last names and suffixes" do

    return_array = Parse.parse_names(prefixes, suffixes, "Lady Madona III")
    expect(return_array).to eq(["Lady","","","Madona","III"])
  end

  it "should parse the whole banana" do
  
    return_array = Parse.parse_names(prefixes, suffixes, "Lady Mary Samuel Madona-Richey III")
    expect(return_array).to eq(["Lady","Mary","Samuel","Madona-Richey","III"])
  end

end



