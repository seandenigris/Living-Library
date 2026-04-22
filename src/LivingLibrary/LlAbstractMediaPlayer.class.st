Class {
	#name : 'LlAbstractMediaPlayer',
	#superclass : 'Object',
	#instVars : [
		'requestedSpeed'
	],
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'accessing' }
LlAbstractMediaPlayer >> isPlaying: aBoolean [
	
	aBoolean
		ifTrue: [ self play ]
		ifFalse: [ self pause ]
]

{ #category : 'as yet unclassified' }
LlAbstractMediaPlayer >> playerGtViewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Player';
		priority: 25;
		stencil: [ LlMediaPlayerElement on: self ];
		yourself
]

{ #category : 'accessing' }
LlAbstractMediaPlayer >> requestedSpeed [

	^ requestedSpeed
]

{ #category : 'accessing' }
LlAbstractMediaPlayer >> requestedSpeed: aNumber [

	requestedSpeed := aNumber
]

{ #category : 'accessing' }
LlAbstractMediaPlayer >> restorePlayStateAfter: aBlock [
	| playState |
	playState := self isPlaying.
	aBlock value.
	self isPlaying: playState
	
	"Note: this was first needed because it seemed that seeking via Playwright driver plays the video even if it wasn't already"
]

{ #category : 'as yet unclassified' }
LlAbstractMediaPlayer >> speed: aNumber [

	self requestedSpeed: aNumber.
]

{ #category : 'as yet unclassified' }
LlAbstractMediaPlayer >> timeRemaining [

	^ self duration - self currentTime
]

{ #category : 'accessing' }
LlAbstractMediaPlayer >> togglePlayPause [
	self isPlaying
		ifTrue: [ self pause ]
		ifFalse: [ self play ]
]
