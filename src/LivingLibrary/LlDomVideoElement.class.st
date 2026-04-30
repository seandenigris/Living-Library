Class {
	#name : 'LlDomVideoElement',
	#superclass : 'LlDomElementLocator',
	#category : 'LivingLibrary-Web Driving',
	#package : 'LivingLibrary',
	#tag : 'Web Driving'
}

{ #category : 'as yet unclassified' }
LlDomVideoElement class >> in: page [
	"Default querySelector is sufficient unless there are multiple videos on a page to distinguish, which can be done via e.g. ID or class"

	^ self
		querySelector: 'video'
		in: page
]

{ #category : 'as yet unclassified' }
LlDomVideoElement >> currentPosition [
	"Subclasses may override if e.g. video has seekable chapters, slides, etc"
	^ self currentTime
]

{ #category : 'as yet unclassified' }
LlDomVideoElement >> currentPosition: aDuration [
	"Subclasses may override if e.g. video has seekable chapters, slides, etc"
	self seekTo: aDuration
]

{ #category : 'as yet unclassified' }
LlDomVideoElement >> currentTime [

	| secondsString |
	secondsString := self doJavaScript: 'currentTime'.
	^ secondsString asNumber seconds
]

{ #category : 'as yet unclassified' }
LlDomVideoElement >> duration [
	
	| secondsString |
	secondsString := self doJavaScript: 'duration'.
	^ secondsString asNumber seconds.
]

{ #category : 'as yet unclassified' }
LlDomVideoElement >> isPlaying [
	
	self page exists ifFalse: [ ^ false ].
	
	^ (self doJavaScript: 'paused') not.
]

{ #category : 'as yet unclassified' }
LlDomVideoElement >> pause [
	self doJavaScript: 'pause()'.
]

{ #category : 'as yet unclassified' }
LlDomVideoElement >> play [
	self doJavaScript: 'play()'.
]

{ #category : 'as yet unclassified' }
LlDomVideoElement >> playbackSpeed [
	^ self doJavaScript: 'playbackRate'.
]

{ #category : 'as yet unclassified' }
LlDomVideoElement >> playbackSpeed: aNumber [
	self doJavaScript: 'playbackRate=', aNumber asString.
]

{ #category : 'as yet unclassified' }
LlDomVideoElement >> seekTo: aDuration [
	self doJavaScript: 'currentTime = ', aDuration asSeconds asString.
]
