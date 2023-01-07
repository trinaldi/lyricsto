module URLBuilder
  def host
   'https://www.azlyrics.com/lyrics' 
  end

  def urlize(text)
    text.downcase.split.reject(&:empty?).join('')
  end

  def build_band_song(band, song)
    band = urlize(band)
    song = urlize(song)
    "#{band}/#{song}"
  end

  def full_url(band, song)
    band_song = build_band_song(band, song)
    "#{host}/#{band_song}.html"
  end
end
