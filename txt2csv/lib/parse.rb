class Parse

    def self.parse_names (prefixes, suffixes, name_string)

        parsed_name = {pre:"", first:"", middle:"", last:"", suffix:""}

        # get the last word and see if it's a suffix
        # if so, save as suffix and store the next to last word as last_name
        # otherwise store last word as last name

        word = name_string.split
        parsed_name[:suffix] = word.pop if suffixes.include? word.last
        parsed_name[:last] = word.pop
        parsed_name[:pre] = word.shift if prefixes.include? word.first
        parsed_name[:first] = word.shift if word[0] != nil
        parsed_name[:middle] = word.shift if word[0] != nil
        parsed_name.values 
    end
    def self.parse_phone (phone_string)

        parsed_phone = {country_code:"", area_code:"", prefix:"", line:"", extension:""}
        
        #parse extensions
        parsed_phone[:extension] = phone_string.match(/x\d*/).to_s[1..9] if phone_string.include?("x")
        
        if phone_string.include?("(")
            #parse (ddd)ddd-dddd
            parsed_phone[:area_code] = phone_string[1..3]
            parsed_phone[:prefix] = phone_string[5..7]
            parsed_phone[:line] = phone_string[9..12]
        elsif phone_string.match(/^\d-\d/)
            #parse d-ddd-ddd-dddd
            parsed_phone[:country_code] = phone_string[0]
            parsed_phone[:area_code] = phone_string[2..4]
            parsed_phone[:prefix] = phone_string[6..8]
            parsed_phone[:line] = phone_string[10..13]
        else
            #parse ddd.ddd.dddd dots or dashes
            parsed_phone[:area_code] = phone_string[0..2]
            parsed_phone[:prefix] = phone_string[4..6]
            parsed_phone[:line] = phone_string[8..11]
        end

        parsed_phone.values
    end
end


