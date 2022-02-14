Class {
	#name : #LlGranicusVideo,
	#superclass : #LlWebVideo,
	#instVars : [
		'subdomain',
		'id'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #accessing }
LlGranicusVideo class >> fromLinkString: aString [
	| url id |
	url := aString asUrl.
	^ self new
		id: (url queryAt: #clip_id);
		subdomain: (url host copyUpTo: $.);
		yourself
]

{ #category : #accessing }
LlGranicusVideo class >> fromLinkStringExample [
	<gtExample>
	^ self 
		given: []
		when: [ 
			self fromLinkString: 'https://sub.granicus.com/MediaPlayer.php?view_id=2&clip_id=1234' ]
		then: [ :video | 
			video url asString should equal: 'https://sub.granicus.com/MediaPlayer.php?clip_id=1234'.
			video id should equal: '1234'.
			video subdomain should equal: 'sub' ]
]

{ #category : #accessing }
LlGranicusVideo >> id [

	^ id
]

{ #category : #accessing }
LlGranicusVideo >> id: anObject [

	id := anObject
]

{ #category : #accessing }
LlGranicusVideo >> subdomain [

	^ subdomain
]

{ #category : #accessing }
LlGranicusVideo >> subdomain: anObject [

	subdomain := anObject
]

{ #category : #accessing }
LlGranicusVideo >> url [

	| template string |
	template := 'https://{subdomain}.granicus.com/MediaPlayer.php?clip_id={id}'.
	string := template format: { 
		#subdomain -> self subdomain.
		#id -> self id } asDictionary.
	^ string asUrl
]

{ #category : #playing }
LlGranicusVideo >> videoIn: page doJavaScript: aString [
	| frame element |
	frame := page frameReferenceFromSelector: '[src*=', self videosBaseUrl asString surroundedByDoubleQuotes, ']'.
	element := frame elementLocatorFromSelector: 'video'.
	^ element selfEvaluate: aString.
]

{ #category : #accessing }
LlGranicusVideo >> videoPlayerUrl [
	"Just the video, no index links or agenda"

	^ self videosBaseUrl /  self id / 'player'
]

{ #category : #accessing }
LlGranicusVideo >> videosBaseUrl [
	
	| template string |
	template := 'https://{subdomain}.granicus.com/videos/'.
	string := template format: { #subdomain -> self subdomain } asDictionary.
	^ string asUrl
]
