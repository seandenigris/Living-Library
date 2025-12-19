"
I keep getting more and more general. I started life as a DVDClip, then OpticalDiskClip. Eventually, I will probably become an AVClip or MediaClip. I delegate all the playing to the underlying media, which have common interfaces, like play, pause, etc.

This might help chasing down the process bug:
VideoClip allInstances collect: [ :e |
	e instVarNamed: 'backgroundProcess' ]
"
Class {
	#name : 'LlVideoClip',
	#superclass : 'Object',
	#instVars : [
		'startTime',
		'endTime',
		'video'
	],
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LlVideoClip class >> from: aVideo startingAt: startString andEndingAt: endString [ 

	^ self new setVideo: aVideo startTime: startString endTime: endString.
]

{ #category : 'as yet unclassified' }
LlVideoClip >> asMorph [
	
	| morph playButton builder pauseButton controls |
	builder := UITheme builder.
	morph := UserObjectMorph on: self.
	playButton := builder newButtonFor: self action: #play label: 'Play' help: ''.
	pauseButton := builder newButtonFor: self action: #pause label: 'Pause' help: ''.
	controls := builder newColumn: {
		builder newRow: { playButton. pauseButton }.
		builder newTextEntry model: self; accessor: #subtitle; get }.
	morph addControls: controls.
	^ morph.
]

{ #category : 'accessing' }
LlVideoClip >> doesNotUnderstand: aMessage [
	^ (self video respondsTo: aMessage selector)
		ifTrue: [ aMessage sendTo: self video ]
		ifFalse: [ super doesNotUnderstand: aMessage ]
]

{ #category : 'playing' }
LlVideoClip >> newPlayer [

	^ self video newPlayer
		media: self;
		currentPosition: self startPosition;
		yourself
]

{ #category : 'playing' }
LlVideoClip >> printOn: aStream [

	| prettyStartTime prettyEndTime |
	prettyStartTime := startTime roundTo: (Duration seconds: 1).
	prettyEndTime := endTime roundTo: (Duration seconds: 1).
	aStream nextPutAll: 'Clip from ', prettyStartTime asString, ' to ', prettyEndTime asString, ' in '.
	video printOn: aStream.
]

{ #category : 'private' }
LlVideoClip >> setVideo: aVideo startTime: startPosition endTime: endPosition [

	video := aVideo.
	startTime := startPosition.
	endTime := endPosition.
	^ self.
]

{ #category : 'playing' }
LlVideoClip >> startPosition [
	^ startTime
]

{ #category : 'accessing' }
LlVideoClip >> startPosition: position [
	startTime := position
]

{ #category : 'playing' }
LlVideoClip >> video [
	^ video
]
