"
I am the intersection of a player mode (what you can do) and a service (how you do it).

Modes:
- Live - ongoing event. For example, you can get the currentTime, but can't fastforward
- Historical - we don't know when each thing happenned exactly. We are piecing together after the fact and can only give relative positions
- Recorded - has all the actions you would commonly expect from a player - play/pause, rewind, fast forward

Service
The underlying app we use to present the media. Examples might include:
- Safari
- Chrome
- Quicktime
- VLC

"
Class {
	#name : #LlMediaPlayer,
	#superclass : #Object,
	#instVars : [
		'media'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #accessing }
LlMediaPlayer class >> on: anObject [ 
	^ self new
		media: anObject;
		yourself
]

{ #category : #accessing }
LlMediaPlayer >> currentTime [
	^ (CwSafari new doJavascript: LlYouTubeVideo new jsPlayerGetCurrentTime) seconds
]

{ #category : #accessing }
LlMediaPlayer >> media [

	^ media
]

{ #category : #accessing }
LlMediaPlayer >> media: anObject [

	media := anObject
]

{ #category : #'as yet unclassified' }
LlMediaPlayer >> play [
	self media view.
]
