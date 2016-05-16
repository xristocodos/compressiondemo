# compress text files

def text_input

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
  lossy -= 1 # boolean for lossy [0] = lossless, [1] = lossy


  lyrical_array = text.split(" ")

  lyrical_db = {}

  # iterate over array, store each unique word into hash
  lyrical_array.each do |word|
    if lyrical_db.keys.include?(word)
      lyrical_db[word] += 1
    else
      lyrical_db[word] = 1
    end
  end

  # translation time!
  translation_hash = {}
  freq_array = []

  freq_array = lyrical_db.values.sort.reverse

  lyrical_db.each do |word, count|

    if count >= freq_array[factor]
      if lossy == 1
        translation_hash[word] = word[0]
      elsif lossy == 0
        translation_hash[word] = "%" + word[0]
      end
    end

  end

  puts "\n"
  puts "translation_hash"
  puts translation_hash


  text_compressed = text
  translation_hash.each do | key, value |
    text_compressed = text_compressed.gsub(key, value)
  end


  puts "///////////COMPRESSED TEXT///////////"
  puts text_compressed
  puts "////////COMPRESSED TEXT END//////////"


  text_decompressed = text_compressed
  translation_hash.each do | key, value |
    text_decompressed = text_decompressed.gsub(value, key)
  end
  puts "\n"


  puts "///////////DECOMPRESSED TEXT///////////"
  puts text_decompressed
  puts "////////DECOMPRESSED TEXT END//////////"


  puts "\n\n\n"
  puts "//////////STATS///////////"
  if lossy == 1
    puts "Mode: \t\tLOSSY"
  elsif lossy == 0
    puts "Mode: \t\tLOSSLESS"
  end
  puts "INPUT:\t\t#{text.length} chars"
  puts "FACTOR: \t#{factor}"
  puts "COMPRESSED: \t#{text_compressed.length} chars"
  puts "UNCOMPRESSED:\t#{text_decompressed.length} chars"
end

text_input
# end
