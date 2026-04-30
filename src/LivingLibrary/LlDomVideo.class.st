Class {
	#name : 'LlDomVideo',
	#superclass : 'LlDomElementLocator',
	#category : 'LivingLibrary-Web Driving',
	#package : 'LivingLibrary',
	#tag : 'Web Driving'
}

{ #category : 'as yet unclassified' }
LlDomVideo class >> in: page [
	"Default querySelector is sufficient unless there are multiple videos on a page to distinguish, which can be done via e.g. ID or class"

	^ self
		querySelector: 'video'
		in: page
]

{ #category : 'as yet unclassified' }
LlDomVideo >> currentPosition [
	"Subclasses may override if e.g. video has seekable chapters, slides, etc"
	^ self currentTime
]

{ #category : 'as yet unclassified' }
LlDomVideo >> currentPosition: aDuration [
	"Subclasses may override if e.g. video has seekable chapters, slides, etc"
	self seekTo: aDuration
]

{ #category : 'as yet unclassified' }
LlDomVideo >> currentTime [

	| secondsString |
	secondsString := self doJavaScript: 'currentTime'.
	^ secondsString asNumber seconds
]

{ #category : 'as yet unclassified' }
LlDomVideo >> duration [
	
	| secondsString |
	secondsString := self doJavaScript: 'duration'.
	^ secondsString asNumber seconds.
]

{ #category : 'as yet unclassified' }
LlDomVideo >> isPlaying [
	
	self page exists ifFalse: [ ^ false ].
	
	^ (self doJavaScript: 'paused') not.
]

{ #category : 'as yet unclassified' }
LlDomVideo >> pause [
	self doJavaScript: 'pause()'.
]

{ #category : 'as yet unclassified' }
LlDomVideo >> play [
	self doJavaScript: 'play()'.
]

{ #category : 'as yet unclassified' }
LlDomVideo >> playbackSpeed [
	^ self doJavaScript: 'playbackRate'.
]

{ #category : 'as yet unclassified' }
LlDomVideo >> playbackSpeed: aNumber [
	self doJavaScript: 'playbackRate=', aNumber asString.
]

{ #category : 'as yet unclassified' }
LlDomVideo >> seekTo: aDuration [
	self doJavaScript: 'currentTime = ', aDuration asSeconds asString.
]
