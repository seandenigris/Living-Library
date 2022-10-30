Class {
	#name : #LlWebVideo,
	#superclass : #LlWebResource,
	#category : #'LivingLibrary-Core'
}

{ #category : #'player-media' }
LlWebVideo >> currentPosition: aDuration in: page [
	"Subclasses may override if e.g. video has seekable chapters, slides, etc"
	self seekTo: aDuration in: page
]

{ #category : #'player-media' }
LlWebVideo >> currentPositionIn: page [
	"Subclasses may override if e.g. video has seekable chapters, slides, etc"
	^ self currentTimeIn: page
]

{ #category : #'player-media' }
LlWebVideo >> currentTimeIn: page [

	| secondsString |
	secondsString := self videoIn: page doJavaScript: 'currentTime'.
	^ secondsString asNumber seconds
]

{ #category : #accessing }
LlWebVideo >> defaultDriver: anObject [
	self propertyAt: #defaultDriver put: anObject
]

{ #category : #accessing }
LlWebVideo >> element: selectorString in: page doJavaScript: jsString [
	| element |
	element := page elementLocatorFromSelector: selectorString.
	^ element selfEvaluate: jsString.
]

{ #category : #playing }
LlWebVideo >> isPlayingIn: page [
	^ (self videoIn: page doJavaScript: 'paused') not.
]

{ #category : #accessing }
LlWebVideo >> newPlayer [
	| result |
	result := LlMediaPlayer on: self.
	self 
		propertyAt: #defaultDriver 
		ifPresent: [ :driver | result driver: driver ].
	^ result
]

{ #category : #'player-media' }
LlWebVideo >> pauseIn: page [
	self videoIn: page doJavaScript: 'pause()'.
]

{ #category : #playing }
LlWebVideo >> playIn: page [
	self videoIn: page doJavaScript: 'play()'.
]

{ #category : #'player-media' }
LlWebVideo >> playbackSpeed: aNumber in: page [
	self videoIn: page doJavaScript: 'playbackRate=', aNumber asString.
]

{ #category : #'player-media' }
LlWebVideo >> playbackSpeedIn: page [
	^ self videoIn: page doJavaScript: 'playbackRate'.
]

{ #category : #accessing }
LlWebVideo >> present [
	^ self newPlayer
		play;
		yourself
]

{ #category : #'player-media' }
LlWebVideo >> seekTo: aDuration in: page [
	self videoIn: page doJavaScript: 'currentTime = ', aDuration asSeconds asString.
]

{ #category : #accessing }
LlWebVideo >> videoIn: page doJavaScript: aString [
	^ self element: 'video' in: page doJavaScript: aString
]
