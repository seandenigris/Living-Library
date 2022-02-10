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
LlWebVideo >> element: selectorString in: page doJavaScript: jsString [
	| element |
	element := page elementReferenceFromSelector: selectorString.
	^ element selfEvaluate: jsString.
]

{ #category : #playing }
LlWebVideo >> isPlayingIn: page [
	^ (self videoIn: page doJavaScript: 'paused') not.
]

{ #category : #accessing }
LlWebVideo >> newPlayer [
	^ LlMediaPlayer on: self
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

{ #category : #'player-media' }
LlWebVideo >> seekTo: aDuration in: page [
	self videoIn: page doJavaScript: 'currentTime = ', aDuration asSeconds asString.
]

{ #category : #accessing }
LlWebVideo >> videoIn: page doJavaScript: aString [
	^ self element: 'video' in: page doJavaScript: aString
]

{ #category : #accessing }
LlWebVideo >> view [
	^ self newPlayer
		view;
		yourself
]
