Class {
	#name : 'LlPlaylistPlayer',
	#superclass : 'LlAbstractMediaPlayer',
	#instVars : [
		'playlist',
		'mediaPlayers',
		'mediaStream'
	],
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'instance' }
LlPlaylistPlayer class >> on: anLlPlaylist [

	^ self new
		playlist: anLlPlaylist;
		yourself
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> currentPosition [
	
	| result |
	result := 0 seconds.
	self playlist items readStreamDo: [ :str |
		| anItem |
		[
			anItem := str next.
			anItem = self playerCurrent media ] 
		whileFalse: [
			result := result + anItem duration ] ].
			
	^ result + self playerCurrent currentTime
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> currentPosition: aDuration [

	| str med localDuration |
	str := self playlist items readStream.
	localDuration := aDuration.
	[ 
		med := str next.
		med duration >= localDuration 
			ifTrue: [ str setToEnd ]
			ifFalse: [ localDuration := localDuration - med duration ]
	]
		doWhileFalse: [ str atEnd ].
		
	self mediaCurrent: med.
	self playerCurrent currentPosition: (med duration min: localDuration)
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> currentTime [

	^ self playerCurrent currentTime
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> isMediaFirst [

	^ self mediaStream position = 0
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> isMediaLast [

	^ self mediaStream atEnd
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> isPlaying [

	^ self playerCurrent isPlaying
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> mediaCurrent [

	^ self mediaStream peek
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> mediaCurrent: anObject [

	self playerCurrent media = anObject ifTrue: [ ^ self ].
	
	self restorePlayStateAfter: [
		"Shut down existing player"
		self playerCurrent
			pause;
			quit.
			
		"Start new player"
		self mediaStream 
			setToStart;
			skipTo: anObject;
			back.
			
		self playerCurrent 
			show;
			pause;
			speed: self requestedSpeed ].
]

{ #category : 'accessing' }
LlPlaylistPlayer >> mediaPlayers [

  ^ mediaPlayers ifNil: [ mediaPlayers := Dictionary new ]
]

{ #category : 'accessing' }
LlPlaylistPlayer >> mediaPlayers: aCollection [

  mediaPlayers := aCollection
]

{ #category : 'accessing' }
LlPlaylistPlayer >> mediaStream [

  ^ mediaStream
]

{ #category : 'accessing' }
LlPlaylistPlayer >> mediaStream: anObject [

  mediaStream := anObject
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> nextSection [
	
	self playerNext
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> pause [

	self playerCurrent pause
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> play [

	self playerCurrent play
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> playerCurrent [

	^ self mediaPlayers
		at: self mediaCurrent
		ifAbsentPut: [ self mediaCurrent newPlayer ]
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> playerGtViewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Player';
		priority: 25;
		stencil: [ LlMediaPlayerElement on: self ];
		yourself
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> playerNext [

	| mediaNext |
	self isMediaLast ifTrue: [ ^ nil ].
	
	mediaNext := self mediaStream savingPositionDo: [ self mediaStream next; peek ].
	self mediaCurrent: mediaNext.
	^ self playerCurrent
		currentTime: 0 seconds;
		yourself
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> playerPrevious [

	| mediaPrevious |
	self isMediaFirst ifTrue: [ ^ nil ].
	
	mediaPrevious := self mediaStream savingPositionDo: [ self mediaStream back; peek ].
	
	self mediaCurrent: mediaPrevious.
	
	^ self playerCurrent
		currentTime: self playerCurrent duration;
		yourself
]

{ #category : 'accessing' }
LlPlaylistPlayer >> playlist [

  ^ playlist
]

{ #category : 'accessing' }
LlPlaylistPlayer >> playlist: anObject [

  playlist := anObject.
  mediaStream := self playlist items readStream
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> quit [
	
	self mediaPlayers do: #quit
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> seekBack: aDuration [ 

	| segmentTimeElapsed |
	segmentTimeElapsed := self playerCurrent currentTime.
	
	segmentTimeElapsed >= aDuration abs
		ifTrue: [ self playerCurrent seekBy: aDuration ]
		ifFalse: [ 
			self isMediaFirst
				ifTrue: [ self playerCurrent currentTime: 0 seconds ]
				ifFalse: [ 
					self playerPrevious.
					self seekBack: aDuration + segmentTimeElapsed ] ]
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> seekBy: aDuration [

	aDuration >= 0 seconds
		ifTrue: [ self seekForward: aDuration ]
		ifFalse: [ self seekBack: aDuration ]
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> seekForward: aDuration [ 

	| segmentTimeRemaining |
	segmentTimeRemaining := self playerCurrent timeRemaining.
	
	segmentTimeRemaining >= aDuration
		ifTrue: [ self playerCurrent seekBy: aDuration ]
		ifFalse: [ 
			self isMediaLast
				ifTrue: [ self playerCurrent seekBy: segmentTimeRemaining ]
				ifFalse: [ 
					self playerNext.
					self seekForward: aDuration - segmentTimeRemaining ] ]
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> speed [

	^ self playerCurrent speed
]

{ #category : 'as yet unclassified' }
LlPlaylistPlayer >> speed: aNumber [

	super speed: aNumber.
	self playerCurrent speed: aNumber
]
