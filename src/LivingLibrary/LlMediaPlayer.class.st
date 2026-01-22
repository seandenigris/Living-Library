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
	#superclass : 'Object',
	#instVars : [
		'media',
		'driver',
		'mediaContainer',
		'requestedSpeed'
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
	^ self media currentPositionIn: self mediaContainer
]

{ #category : 'accessing' }
LlMediaPlayer >> currentPosition: anObject [
	self restorePlayStateAfter: [
		self media 
			currentPosition: anObject 
			in: self mediaContainer ]
]

{ #category : 'accessing' }
LlMediaPlayer >> currentTime [
	^ self media currentTimeIn: self mediaContainer
]

{ #category : 'accessing' }
LlMediaPlayer >> currentTime: aDuration [
	self restorePlayStateAfter: [
		self media 
			seekTo: aDuration 
			in: self mediaContainer ]
]

{ #category : 'accessing' }
LlMediaPlayer >> driver [

	^ driver ifNil: [ driver := LlPlaywright uniqueInstance ]
]

{ #category : 'accessing' }
LlMediaPlayer >> driver: anObject [

	driver := anObject
]

{ #category : 'accessing' }
LlMediaPlayer >> isPlaying [
	^ self media isPlayingIn: self mediaContainer
]

{ #category : 'accessing' }
LlMediaPlayer >> isPlaying: aBoolean [
	
	aBoolean
		ifTrue: [ self play ]
		ifFalse: [ self pause ]
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
	self media pauseIn: self mediaContainer
]

{ #category : 'actions' }
LlMediaPlayer >> play [
	self media playIn: self mediaContainer
]

{ #category : 'as yet unclassified' }
LlMediaPlayer >> playerGtViewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Player';
		priority: 25;
		stencil: [ LlMediaPlayerElement on: self ];
		yourself
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
LlMediaPlayer >> requestedSpeed [

	^ requestedSpeed
]

{ #category : 'accessing' }
LlMediaPlayer >> requestedSpeed: aNumber [

	requestedSpeed := aNumber
]

{ #category : 'accessing' }
LlMediaPlayer >> reset [
	mediaContainer ifNil: [ ^ self ].
	mediaContainer onQuit.
	mediaContainer := nil.
]

{ #category : 'accessing' }
LlMediaPlayer >> restorePlayStateAfter: aBlock [
	| playState |
	playState := self isPlaying.
	aBlock value.
	self isPlaying: playState
	
	"Note: this was first needed because it seemed that seeking via Playwright driver plays the video even if it wasn't already"
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
	^ self media playbackSpeedIn: self mediaContainer
]

{ #category : 'accessing' }
LlMediaPlayer >> speed: aNumber [

	self requestedSpeed: aNumber.
	self media playbackSpeed: aNumber in: self mediaContainer
]

{ #category : 'accessing' }
LlMediaPlayer >> togglePlayPause [
	self isPlaying
		ifTrue: [ self pause ]
		ifFalse: [ self play ]
]
