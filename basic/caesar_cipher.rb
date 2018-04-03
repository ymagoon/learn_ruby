def caesar_cipher(string, shift)
  cipher = []
  string.each_byte do |c|
    if c + shift <= 122 # z
      cipher << (c + shift).chr
    else
      cipher << (c + shift - 26).chr # reset cipher at a
    end
  end
  cipher.join
end

puts caesar_cipher("stringzxy",3)
