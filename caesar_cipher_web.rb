require 'sinatra'

@result = "Your message will appear here"

def cipher (text, shift)
  index = 0
  alpha = ('a'..'z').to_a
  capital_alpha = ('A'..'Z').to_a
  ignore = ["!"," ","?", ",",".","'","\""] + (0..9).to_a.map {|i| i.to_s}
  while index < text.length
    if not ignore.include?(text[index])
      if capital_alpha.include?(text[index])
        num = ((capital_alpha.find_index(text[index]) + shift) % 26)
        text[index] = capital_alpha[num]
      else alpha.include?(text[index])
        num = ((alpha.find_index(text[index]) + shift) % 26)
        text[index] = alpha[num]
      end
    end
      index = index + 1
  end
  text
end


get '/' do
  erb :index, :locals => {:result => @result}
end

post '/' do
  text = params['input'].to_s
  shift = params['shift'].to_i
  @result = cipher(text,shift)
  erb :index, :locals => {:result => @result}
end
