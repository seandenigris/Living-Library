Class {
	#name : 'LlVimeoVideo',
	#superclass : 'LlWebVideo',
	#instVars : [
		'id'
	],
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
LlVimeoVideo class >> atUrl: aString [

	^ self new url: aString asUrl.
]

{ #category : 'as yet unclassified' }
LlVimeoVideo class >> currentlyOpenInSafari [

	^ self new url: CwSafari reference currentUrl.
]

{ #category : 'instance creation' }
LlVimeoVideo class >> fromString: aString [
	| url id |
	url := aString asUrl.
	id := url pathSegments first.
	^ self new
		id: id;
		yourself
]

{ #category : 'accessing' }
LlVimeoVideo class >> withID: aNumber [

	^ self new
		id: aNumber;
		yourself
]

{ #category : 'as yet unclassified' }
LlVimeoVideo >> currentTime [

	^ (CwSafari reference doJavascript: 'document.getElementsByTagName(''video'')[0].currentTime') asNumber seconds.
]

{ #category : 'as yet unclassified' }
LlVimeoVideo >> currentTime: aDuration [

	CwSafari reference doJavascript: 'document.getElementsByTagName(''video'')[0].currentTime = ', aDuration asSeconds asString.
]

{ #category : 'accessing' }
LlVimeoVideo >> id [

	^ id
]

{ #category : 'accessing' }
LlVimeoVideo >> id: aNumber [

	id := aNumber
]

{ #category : 'as yet unclassified' }
LlVimeoVideo >> play [
	"There is a bug.  I don't know if it's in Vimeo, Safari, or elsewhere, but you have to use click the first time, and after that, the video tag works.  I think the simplest solution would be to use the click for #play and the video tag for all the other API methods.
	Via the play button: 'document.getElementsByClassName(''play_button'')[0].click()'
	Via the video tag: 'document.getElementsByTagName(''video'')[0].play()'"

	| isPlaying |
	isPlaying := (CwSafari reference doJavascript: 'document.getElementsByClassName(''play_button'')[0].value') =  '"playing"'.
	
	isPlaying ifTrue: [ ^ self ].
	
	CwSafari reference doJavascript: 'document.getElementsByClassName(''play_button'')[0].click()'.
]

{ #category : 'accessing' }
LlVimeoVideo >> playerUrl [
	^ 'https://player.vimeo.com/video' asUrl / self id
]

{ #category : 'as yet unclassified' }
LlVimeoVideo >> show [

	CwSafari reference openInNewWindow: id.
	self play.
		
]

{ #category : 'accessing' }
LlVimeoVideo >> url [
	^ 'https://vimeo.com' asUrl / self id
]
