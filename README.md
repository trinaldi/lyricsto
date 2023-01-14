# LyricsTo

Fetch and display lyrics from sources.  
FWIW, this should be a simple script...

## Requirements

`Ruby 3`

Gems: 

```
HTTParty
Nokogiri
Slup
```

## Usage

`lyricsto -a Artist -s Song`

The arguments:  
`-a | --artist [artist name]`  
As the name implies, where you set the artist name

`-s | --song [song_title]`  
Again, as implied, where you set the song title.

`-d | --description`  
Fetch Genius website for the song description. This is a search on their website 
so keep in mind that some results are actually false positives


## Contribute  

I'm open to code reviews, enchancements and all.
