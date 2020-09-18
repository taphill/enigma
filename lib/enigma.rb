class Enigma
  def generate_key
    5.times.map { rand(0..9) }.join
  end

  def todays_date
    Time.now.strftime("%d/%m/%y").delete('/')
  end
end
