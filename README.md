# LyricsTo

Fetch and display lyrics from sources and fetch song description from Genius. For 
now there's AZLyrics and LyricsFreak.

FWIW, this should be a simple script...

## Requirements

`Ruby`

Gems: 

```
HTTParty
Nokogiri
Slup
```

I've added a `Gemfile`, this way you'll only need `bundler`:

`bundle install`

## Usage

`lyricsto -a Artist -s Song -z[-f|-d]`

The arguments:  
`-a | --artist [artist name]`  
As the name implies, where you set the artist name

`-s | --song [song_title]`  
Again, as implied, where you set the song title.

`-d | --description`  
Fetch Genius website for the song description. This is a search on their website 
so keep in mind that some results are actually false positives

`-z`  
Fetch lyrics from AZLyrics:  
`lyricsto -a 'Beatles' -s 'Happiness Is a Warm Gun' -z`

`-f`  
Fetch lyrics from LyricsFreak:  
`lyricsto -a 'Beatles' -s 'Happiness Is a Warm Gun' -z`


## Contribute  

I'm open to code reviews, enchancements and all.  
Check `.rubocop.yml` and test your code with `rspec`.
