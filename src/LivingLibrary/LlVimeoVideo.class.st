Class {
	#name : 'LlVimeoVideo',
	#superclass : 'Object',
	#instVars : [
		'url'
	],
	#category : 'LivingLibrary'
}

{ #category : 'as yet unclassified' }
LlVimeoVideo class >> atUrl: aString [

	^ self new setUrl: aString asUrl.
]

{ #category : 'as yet unclassified' }
LlVimeoVideo class >> currentlyOpenInSafari [

	^ self new setUrl: CwSafari reference currentUrl.
]

{ #category : 'as yet unclassified' }
LlVimeoVideo >> currentTime [

	^ (CwSafari reference doJavascript: 'document.getElementsByTagName(''video'')[0].currentTime') asNumber seconds.
]

{ #category : 'as yet unclassified' }
LlVimeoVideo >> currentTime: aDuration [

	CwSafari reference doJavascript: 'document.getElementsByTagName(''video'')[0].currentTime = ', aDuration asSeconds asString.
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

{ #category : 'private' }
LlVimeoVideo >> setUrl: aUrl [ 

	url := aUrl.
	^ self.
]

{ #category : 'as yet unclassified' }
LlVimeoVideo >> show [

	CwSafari reference openInNewWindow: url.
	self play.
		
]
