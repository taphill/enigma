class Enigma
  def generate_key
    5.times.map { rand(0..9) }.join.to_i
  end
end
