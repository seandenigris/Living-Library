"
Creating:
video := YouTubeVideo of: 'Melissa Etheridge & Joss Stone - Janis Joplin Tribute' at: 'http://www.youtube.com/watch?v=ef-f-l2Pbn8&sns=tw'.
"
Class {
	#name : #LlYouTubeVideo,
	#superclass : #LlWebVideo,
	#instVars : [
		'id'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #example }
LlYouTubeVideo class >> exampleStopDrawingDeadFish [
	<gtExample>
	"Bret Victor - Stop Drawing Dead Fish"
	^ self
		given: []
		when: [ self new id: 'ZfytHvgHybA'; yourself ]
		then: [ :inst | 
			inst url printString should equal: 'https://www.youtube.com/watch?v=ZfytHvgHybA'.
			inst url id should equal: 'ZfytHvgHybA' ]
]

{ #category : #'instance creation' }
LlYouTubeVideo class >> exampleTranscriptEmptyPage [
	<gtExample>
	^ self
		given: [ LlLibrary exampleAddYouTubeVideo ]
		when: [ :lib |
			| page work |
				work := lib works first.
				page := LePage quTranscriptOwner: work.
				LeDatabase new addPage: page.
				page type stub subjectModelReference willReturn: (OlDummyObjectUIDReferenceForTesting new
					source: lib works;
					uid: work uuid;
					yourself).
					page ]
		then: [ :page | page "children should haveSize: 1" ]
]

{ #category : #example }
LlYouTubeVideo class >> fromLinkStringExample [
	<gtExample>
	self fromStringExampleInput: 'https://youtu.be/A0TafHXszg' shouldSetID: 'A0TafHXszg'.
	self fromStringExampleInput: 'https://youtube.com/embed/A0TafHXszg?loop=1' shouldSetID: 'A0TafHXszg'.
	^ self fromStringExampleInput: 'https://www.youtube.com/watch?v=QOe3FA4wJcQ' shouldSetID: 'QOe3FA4wJcQ'
]

{ #category : #'instance creation' }
LlYouTubeVideo class >> fromString: aString [
	| url id |
	url := aString asUrl.
	id := url pathSegments first = 'embed' "embedded"
		ifTrue: [ id := url file ]
		ifFalse: [ 
			url host = 'youtu.be' "shortened"
				ifTrue: [ id := url pathSegments first ]
				ifFalse: [ url queryAt: #v "normal" ] ].
	^ self new
		id: id;
		yourself
]

{ #category : #'private-examples' }
LlYouTubeVideo class >> fromStringExampleInput: urlString shouldSetID: idString [
	<gtExample>
	^ self
		given: [ urlString ]
		when: [ :str | self fromString: str ]
		then: [ :video | video id should equal: idString ] 
]

{ #category : #accessing }
LlYouTubeVideo >> currentTimeIn: page [

	| secondsString |
	secondsString := self playerIn: page doJavaScript: 'getCurrentTime()'.
	^ secondsString asNumber seconds
]

{ #category : #accessing }
LlYouTubeVideo >> displayStringOn: aStream [
	aStream
		nextPutAll: 'YouTube Video: ';
		print: self work
]

{ #category : #private }
LlYouTubeVideo >> download [

	YouTubeVideoDownloader new download: self.
	
"self cacheLocally.

YouTubeVideoDownloader new download: self.

| agent moviePage parser divs |
agent := Mechanize new.
moviePage := agent getFile: url asString.
parser := HtmlValidator on: moviePage.
divs := parser dom tagsNamed: #div.
watchPlayer := divs detect: [ :d | (d attributes at: #id ifAbsent: [ false ]) = 'watch-player' ].

/* XMLDOMParser choked on input
parser := XMLDOMParser parseDocumentFrom: moviePage readStream. */

| parser stuffBeforeEmbedTag embedTag embedTagRule embedParser |
stuffBeforeEmbedTag := '<embed ' asParser negate star.
embedTagRule := ('<embed ' asParser, '>' asParser negate star, '>' asParser) flatten.
parser := stuffBeforeEmbedTag, embedTagRule ==> [ :n | n second ].
embedTag := parser parse: self asString.
embedParser := HtmlValidator on: embedTag.
embedParser dom children first attributes at: 'flashvars'.

Page source snippet:
fmt_stream_map=34%7C

http%3A%2F%2Fv16.lscache6.c.youtube.com%2Fvideoplayback%3Fip%3D0.0.0.0%26sparams%3Did%252Cexpire%252Cip%252Cipbits%252Citag%252Calgorithm%252Cburst%252Cfactor%252Coc%253AU0dYSFFQVF9FSkNNOF9JSlhB%26fexp%3D906322%252C907605%252C904707%26algorithm%3Dthrottle-factor%26itag%3D34%26ipbits%3D0%26burst%3D40%26sver%3D3%26expire%3D1293156000%26key%3Dyt1%26signature%3D1A6EECDFAD94EE44E564B2F4150DF166B8F44E96.45BA90E1E86F0FFEB7762A8F6C856C6A549C8F7A%26factor%3D1.25%26id%3Dd1585f3cdffa7dc0

%7C%7Ctc.v16.cache6.c.youtube.com%2C18%7C

http%3A%2F%2Fv22.lscache1.c.youtube.com%2Fvideoplayback%3Fip%3D0.0.0.0%26sparams%3Did%252Cexpire%252Cip%252Cipbits%252Citag%252Calgorithm%252Cburst%252Cfactor%252Coc%253AU0dYSFFQVF9FSkNNOF9JSlhB%26fexp%3D906322%252C907605%252C904707%26algorithm%3Dthrottle-factor%26itag%3D18%26ipbits%3D0%26burst%3D40%26sver%3D3%26expire%3D1293156000%26key%3Dyt1%26signature%3DA4DA6EC4CD1ABEB0602824B7F33FF688E1812A80.09462DF5E659007F7DF97181625E56F2ACE64C1C%26factor%3D1.25%26id%3Dd1585f3cdffa7dc0

%7C%7Ctc.v22.cache1.c.youtube.com%2C5%7C

http%3A%2F%2Fv7.lscache6.c.youtube.com%2Fvideoplayback%3Fip%3D0.0.0.0%26sparams%3Did%252Cexpire%252Cip%252Cipbits%252Citag%252Calgorithm%252Cburst%252Cfactor%252Coc%253AU0dYSFFQVF9FSkNNOF9JSlhB%26fexp%3D906322%252C907605%252C904707%26algorithm%3Dthrottle-factor%26itag%3D5%26ipbits%3D0%26burst%3D40%26sver%3D3%26expire%3D1293156000%26key%3Dyt1%26signature%3D31FE56DD813EB456BCBF2260D8B525AADCB9B0BF.0894AF668E668A15A59FBBAF88F0350E148F2076%26factor%3D1.25%26id%3Dd1585f3cdffa7dc0

%7C%7Ctc.v7.cache6.c.youtube.com

rv.2.rating=4.8801843318"
]

{ #category : #accessing }
LlYouTubeVideo >> id [
	^ id
]

{ #category : #accessing }
LlYouTubeVideo >> id: aString [
	id := aString
]

{ #category : #accessing }
LlYouTubeVideo >> newPlayer [
	^ super newPlayer
		driver: LlApplescriptMediaDriver new;
		yourself
]

{ #category : #accessing }
LlYouTubeVideo >> pauseIn: page [ 
	^ self playerIn: page doJavaScript: 'pauseVideo()'.
]

{ #category : #accessing }
LlYouTubeVideo >> playIn: page [
	^ self playerIn: page doJavaScript: 'playVideo()'.
]

{ #category : #accessing }
LlYouTubeVideo >> playerIn: page doJavaScript: aString [
	"Player API Reference: https://developers.google.com/youtube/iframe_api_reference"

	| playerElement |
	playerElement := page elementLocatorFromSelector: '#movie_player'.
	^ playerElement selfEvaluate: aString.
]

{ #category : #accessing }
LlYouTubeVideo >> seekTo: aDuration in: page [
	
	| template js |
	template := 'seekTo({seconds}, {allowSeekAhead})'.
	js := template format: { 
		#seconds -> aDuration asSeconds. 
		#allowSeekAhead -> true } asDictionary.
	^ self playerIn: page doJavaScript: js.
]

{ #category : #accessing }
LlYouTubeVideo >> title [
	"We'd like to get from API"
	self shouldBeImplemented
]

{ #category : #accessing }
LlYouTubeVideo >> url [
	^ (LlYouTubeUrl fromString: 'https://www.youtube.com/watch') ? (#v -> self id)
]
