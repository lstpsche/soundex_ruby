class Soundex
  attr_accessor :coefs
  def initialize
    @coefs = { "eng": { "b"=> 1, "f"=> 1, "p"=> 1, "v"=> 1,
                        "c"=> 2, "g"=> 2, "j"=> 2, "k"=> 2, "q"=> 2, "s"=> 2, "x"=> 2, "z"=> 2,
                        "d"=> 3, "t"=> 3,
                        "l"=> 4,
                        "m"=> 5, "n"=> 5,
                        "r"=> 6,
                        "a"=> nil, "e"=> nil, "i"=> nil, "o"=> nil, "u"=> nil, "y"=> nil }}
  end

  def eng(word:, input: false, output: false)
    # input from console if needed
    word = input_from_console if input

    # throw out letters "h" and "w"
    letters = word.split("").reject { |letter| letter == "h" || letter == "w" }

    # memorize first letter
    first_letter = letters.first.dup

    # replace letters with their coefficients
    letters_coef = letters.map { |letter| coefs[:eng][letter] }

    # replace first symbol with memorized first letter in upcase
    letters_coef[0] = first_letter.upcase

    # shorten all same coefs sequences
    shorten(arr: letters_coef, start: 0)

    # cut final code at 4 symbols
    coded_word = cut_string(string: letters_coef.join, symb_num: 4).join

    # output in console if needed
    puts "#{word} => #{coded_word}" if output

    # return coded word
    coded_word
  end

  private

  def input_from_console
    puts "Enter a word you want to code with Soundex:"
    gets.chomp
  end

  def shorten(arr:, start:, memo: 0)
    if arr[start] == memo
      arr[start] = nil
    else
      memo = arr[start]
    end

    if start == arr.size - 1
      arr.reject(&:nil?)
    else
      shorten(arr: arr, start: start + 1, memo: memo)
    end
  end

  def cut_string(string:, symb_num:)
    string = string.split("")
    (0...symb_num).each_with_object([]) do |ind, new_arr|
      new_arr << string[ind]
    end.map do |elem|
      elem.nil? ? "0" : elem
    end
  end
end
