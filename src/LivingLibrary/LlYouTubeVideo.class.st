"
Creating:
video := YouTubeVideo of: 'Melissa Etheridge & Joss Stone - Janis Joplin Tribute' at: 'http://www.youtube.com/watch?v=ef-f-l2Pbn8&sns=tw'.
"
Class {
	#name : 'LlYouTubeVideo',
	#superclass : 'LlWebVideo',
	#instVars : [
		'id'
	],
	#classVars : [
		'ApiKey'
	],
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'accessing' }
LlYouTubeVideo class >> apiKey [
	^ ApiKey
]

{ #category : 'accessing' }
LlYouTubeVideo class >> apiKey: anObject [
	"Key created and accessed at https://console.cloud.google.com/apis/credentials"
	
	ApiKey := anObject
]

{ #category : 'example' }
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

{ #category : 'instance creation' }
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

{ #category : 'instance creation' }
LlYouTubeVideo class >> fromString: aString [
	| url |
	url := LlYouTubeUrl fromString: aString.
	^ self new
		id: url id;
		yourself
]

{ #category : 'example' }
LlYouTubeVideo class >> fromStringExample [
	<gtExample>
	self fromStringExampleInput: 'https://youtu.be/A0TafHXszg' shouldSetID: 'A0TafHXszg'.
	self fromStringExampleInput: 'https://youtube.com/embed/A0TafHXszg?loop=1' shouldSetID: 'A0TafHXszg'.
	^ self fromStringExampleInput: 'https://www.youtube.com/watch?v=QOe3FA4wJcQ' shouldSetID: 'QOe3FA4wJcQ'
]

{ #category : 'private-examples' }
LlYouTubeVideo class >> fromStringExampleInput: urlString shouldSetID: idString [
	<gtExample>
	^ self
		given: [ urlString ]
		when: [ :str | self fromString: str ]
		then: [ :video | video id should equal: idString ] 
]

{ #category : 'instance creation' }
LlYouTubeVideo class >> fromUrl: aUrl [

	| youTubeUrl |
	youTubeUrl := LlYouTubeUrl fromString: aUrl asString.

	^ self new
		id: youTubeUrl id;
		yourself
]

{ #category : 'instance creation' }
LlYouTubeVideo class >> peCanHandleFromString: aString [
	^ LlYouTubeUrl peCanHandleFromString: aString
]

{ #category : 'accessing' }
LlYouTubeVideo >> currentTimeIn: page [

	| secondsString |
	secondsString := self playerIn: page doJavaScript: 'getCurrentTime()'.
	^ secondsString asNumber seconds
]

{ #category : 'accessing' }
LlYouTubeVideo >> dataApiJsonParts: aCollection do: aBlock [
	"Adapted from https://stackoverflow.com/a/50076966"
	
	| aUrl partsString |
	
	self class apiKey ifNil: [ ^ self error: 'Google API key not set' ].
	
	partsString := aCollection joinUsing: $,.
	
	aUrl := 'https://www.googleapis.com/youtube/v3/videos' asUrl
		queryAt: #part put: partsString;
		queryAt: #id put: self id;
		queryAt: #key put: self class apiKey;
		yourself.
		
	^ ZnClient new
		forJsonREST;
		contentReader: [ :entity | 
			| json |
			json := ZnUtils defaultJSONReader fromString: entity contents.
			aBlock value: json ];
		get: aUrl.
]

{ #category : 'accessing' }
LlYouTubeVideo >> displayStringOn: aStream [
	aStream
		nextPutAll: 'YouTube Video: ';
		print: self work
]

{ #category : 'private' }
LlYouTubeVideo >> download [

	^ self
		downloadTo: self title asFilename, '.mp4'
		with: [ :aFile | 
			SuGenericUnixCommand new
				template: '/opt/homebrew/bin/yt-dlp {url} -o {outputFile} -t mp4';
				argumentAt: #url put: self url;
				argumentAt: #outputFile put: aFile;
				run ].
]

{ #category : 'accessing' }
LlYouTubeVideo >> duration [

	| number hours min sec parser |
	number := #digit asPParser plus flatten ==> #asNumber.
	hours := number, $H asPParser ==> #first.
	min := number, $M asPParser ==> #first.
	sec := number, $S asPParser ==>  #first.
	parser := 'PT' asPParser, hours optional, min optional, sec optional ==> [ :nodes |
		Duration
			days: 0
			hours: (nodes second ifNil: [ 0 ])
			minutes: (nodes third ifNil: [ 0 ])
			seconds: (nodes fourth ifNil: [ 0 ]) ].
		
	^ self 
		dataApiJsonParts: #(contentDetails)
		do: [ :json |
			| iso8601 |
			iso8601 := (json at: #items) first atPath: { #contentDetails. #duration }.
			parser parse: iso8601 ]
			
	"
	- API call adapted from https://stackoverflow.com/a/15605838
	- ISO 8601 format. See https://en.wikipedia.org/wiki/ISO_8601#Durations"
]

{ #category : 'accessing' }
LlYouTubeVideo >> id [
	^ id
]

{ #category : 'accessing' }
LlYouTubeVideo >> id: aString [
	id := aString
]

{ #category : 'accessing' }
LlYouTubeVideo >> newPlayer [
	^ super newPlayer
		driver: LlApplescriptMediaDriver new;
		yourself
]

{ #category : 'accessing' }
LlYouTubeVideo >> pauseIn: page [ 
	page exists ifFalse: [ self error: 'Page does not exist: ', page url asString ].
	^ self playerIn: page doJavaScript: 'pauseVideo()'.
]

{ #category : 'accessing' }
LlYouTubeVideo >> playIn: page [
	^ self playerIn: page doJavaScript: 'playVideo()'.
]

{ #category : 'accessing' }
LlYouTubeVideo >> playerIn: page doJavaScript: aString [
	"Player API Reference: https://developers.google.com/youtube/iframe_api_reference"

	| playerElement |
	playerElement := page domElementFromSelector: '#movie_player'.
	^ playerElement selfEvaluate: aString.
]

{ #category : 'accessing' }
LlYouTubeVideo >> seekTo: aDuration in: page [
	
	| template js myDuration safeDuration |
	
	"If we try to seek past the end of the video, the currentTime does not update correctly"
	myDuration := self durationIn: page.
	safeDuration := aDuration min: myDuration.
	
	template := 'seekTo({seconds}, {allowSeekAhead})'.
	js := template format: { 
		#seconds -> safeDuration asSeconds. 
		#allowSeekAhead -> true } asDictionary.
	^ self playerIn: page doJavaScript: js.
]

{ #category : 'accessing' }
LlYouTubeVideo >> title [
	
	^ self 
		dataApiJsonParts: #(snippet)
		do: [ :json |
			(json at: #items) first atPath: { #snippet. #title } ]
]

{ #category : 'accessing' }
LlYouTubeVideo >> url [
	^ LlYouTubeUrl fromString: 'https://www.youtube.com/watch?v=' , self id
]
