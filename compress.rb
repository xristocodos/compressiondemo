
#pull in text
#ask for "x-factor"
#pick top x words to make dict
#sub out with dict cipher
#print out: file size before vs after, then new file
#fake "WEISSMAN SCORE ANIMATION"

def text_input
  #TODOMARKER: fileio

  puts "Please enter the filename of text to compress?"
  filename = gets.chomp
  text = File.open(filename, "r"){|file| file.read}
  text_stripped = text.gsub(/\n/," ").downcase.gsub(/[^a-z ]/, '')

  puts "\n"
  puts "Please enter compression factor (cipher key quantity):"
  factor = gets.chomp
  factor = factor.to_i
  
  puts "\n"
  puts "[1] for LOSSLESS, [2] for LOSSY"
  lossy = gets.chomp.to_i
  lossy -= 1 #boolean for lossy [0] = lossless, [1] = lossy


  lyrical_array = text.split(" ")

  #make hash target
  lyrical_db = {}

  #iterate over array, store each unique word into hash
  lyrical_array.each do |word|
    if lyrical_db.keys.include?(word)
      lyrical_db[word] += 1
    else
      lyrical_db[word] = 1
    end
  end

  ##translation time!
  translation_hash = {}
  freq_array = []

  freq_array = lyrical_db.values.sort.reverse
 
  # puts "\n"
  # puts "Lyrical db"
  # puts lyrical_db

  # puts "\n" 
  # puts "freq_array"
  # puts freq_array
    
  # puts "\n"
  # puts "LOOPSTATSLOOPSTATSLOOPSTATSLOOPSTATSLOOPSTATSLOOPSTATSLOOPSTATS"
  # puts "factor = #{factor}"
  # puts "\n"
  # puts "freq_array = #{freq_array}"
  # puts "\n"
  # puts "freq_array[#{factor}] = #{freq_array[factor]}"
  # puts "\n"
  
  lyrical_db.each do |word, count|

    if count >= freq_array[factor]
      if lossy
        translation_hash[word] = word[0]
      else
        translation_hash[word] = "%" + word[0]
      end
    end

  end

  puts "\n"
  puts "translation_hash"
  puts translation_hash


  # text_compressed = translation_hash.map do | key, value |
  #   text = text.gsub(key, value)
  # end
  text_compressed = text
  translation_hash.each do | key, value |
    text_compressed = text_compressed.gsub(key, value)
  end


  puts "///////////COMPRESSED TEXT///////////"
  puts text_compressed
  puts "////////COMPRESSED TEXT END//////////"


  text_decompressed = text_compressed
  translation_hash.each do | key, value |
    text_decompressed = text_decompressed.gsub(value, key)  #FLIPMODE IS THE GREATEST
  end
  puts "\n"

  
  puts "///////////DECOMPRESSED TEXT///////////"
  puts text_decompressed
  puts "////////DECOMPRESSED TEXT END//////////"


  puts "\n\n\n"
  puts "////////STATS/////////"
  if lossy
    puts "Mode: LOSSY"
  else
    puts "Mode: LOSSLESS"
  end
  puts "INPUT: \t#{text.length} chars"
  puts "COMPRESSED: \t#{text_compressed.length} chars"
  puts "UNCOMPRESSED:\t#{text_decompressed.length} chars"
end

text_input
#end

