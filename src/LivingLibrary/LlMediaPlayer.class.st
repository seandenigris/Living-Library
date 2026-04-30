"
I am the intersection of a player `mode` (what you can do) and a `service` (how you do it).

##Modes
- Live - ongoing event. For example, you can get the currentTime, but can't fastforward
- Historical - we don't know when each thing happenned exactly. We are piecing together after the fact and can only give relative positions
- Recorded - has all the actions you would commonly expect from a player - play/pause, rewind, fast forward

##Services
The underlying app we use to present the media. Examples might include:
- Safari
- Chrome
- Quicktime
- VLC
 
 So far, we have Safari via AppleEvents and Playwright. In both cases, there are two points of variability - how you find page/frame where the video element lives, and how you find the video element itself. It might make sense to put this information declaratively/generically in the media and have the player use that.
"
Class {
	#name : 'LlMediaPlayer',
	#superclass : 'LlAbstractMediaPlayer',
	#instVars : [
		'mediaContainer',
		'driver',
		'media'
	],
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'accessing' }
LlMediaPlayer class >> on: anObject [ 
	^ self new
		media: anObject;
		yourself
]

{ #category : 'accessing' }
LlMediaPlayer >> currentPosition [
	^ self playable currentPosition
]

{ #category : 'accessing' }
LlMediaPlayer >> currentPosition: anObject [
	self restorePlayStateAfter: [
		self playable currentPosition: anObject ]
]

{ #category : 'accessing' }
LlMediaPlayer >> currentTime [
	^ self playable currentTime
]

{ #category : 'accessing' }
LlMediaPlayer >> currentTime: aDuration [
	self restorePlayStateAfter: [
		self playable seekTo: aDuration ]
]

{ #category : 'accessing' }
LlMediaPlayer >> driver [

	^ driver ifNil: [ driver := LlPlaywright uniqueInstance ]
]

{ #category : 'accessing' }
LlMediaPlayer >> driver: anObject [

	driver := anObject
]

{ #category : 'as yet unclassified' }
LlMediaPlayer >> duration [

	^ self media duration
]

{ #category : 'accessing' }
LlMediaPlayer >> isPlaying [
	^ self playable isPlaying
]

{ #category : 'as yet unclassified' }
LlMediaPlayer >> isRunning [
	^ mediaContainer isNil
]

{ #category : 'accessing' }
LlMediaPlayer >> media [

	^ media
]

{ #category : 'accessing' }
LlMediaPlayer >> media: anObject [

	media := anObject
]

{ #category : 'actions' }
LlMediaPlayer >> mediaContainer [
	mediaContainer ifNil: [ self show ].
	
	^ mediaContainer
]

{ #category : 'accessing' }
LlMediaPlayer >> nextSection [
	self media nextSectionIn: self mediaContainer.
	self play.
	self requestedSpeed ifNotNil: [ :spd | self speed: spd ]
]

{ #category : 'actions' }
LlMediaPlayer >> pause [
	self playable pause
]

{ #category : 'actions' }
LlMediaPlayer >> play [
	self playable play
]

{ #category : 'actions' }
LlMediaPlayer >> playable [

	self flag: 'this is hard-coded and must be delegated!'.
	^ LlDomVideoElement in: self mediaContainer
]

{ #category : 'accessing' }
LlMediaPlayer >> previousSection [
	self media previousSectionIn: self mediaContainer.
	self play.
	self requestedSpeed ifNotNil: [ :spd | self speed: spd ]
]

{ #category : 'accessing' }
LlMediaPlayer >> quit [
	self reset
]

{ #category : 'accessing' }
LlMediaPlayer >> reset [
	mediaContainer ifNil: [ ^ self ].
	mediaContainer onQuit.
	mediaContainer := nil.
]

{ #category : 'accessing' }
LlMediaPlayer >> seekBy: aDuration [
	| target |
	target := self currentTime + aDuration max: 0 seconds.
	self currentTime: target
]

{ #category : 'actions' }
LlMediaPlayer >> show [
	self flag: 'possibly need to self media showWith: self driver to account for login, but maybe there is another solution. Leaning more and more towards custom Player classes'.
	mediaContainer := self driver show: self media.
]

{ #category : 'accessing' }
LlMediaPlayer >> speed [
	^ self playable playbackSpeed
]

{ #category : 'accessing' }
LlMediaPlayer >> speed: aNumber [

	super speed: aNumber.
	self playable playbackSpeed: aNumber
]
