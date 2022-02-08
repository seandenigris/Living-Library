Class {
	#name : #LlWebVideo,
	#superclass : #LlWebResource,
	#category : #'LivingLibrary-Core'
}

{ #category : #accessing }
LlWebVideo >> currentPosition: aDuration in: page [
	"Subclasses may override if e.g. video has seekable chapters, slides, etc"
	self seekTo: aDuration in: page
]

{ #category : #accessing }
LlWebVideo >> currentPositionIn: page [
	"Subclasses may override if e.g. video has seekable chapters, slides, etc"
	^ self currentTimeIn: page
]

{ #category : #accessing }
LlWebVideo >> currentTimeIn: page [

	^ self videoIn: page doJavaScript: 'currentTime'
]

{ #category : #accessing }
LlWebVideo >> element: selectorString in: page doJavaScript: jsString [
	| element |
	element := page elementReferenceFromSelector: selectorString.
	^ element selfEvaluate: jsString.
]

{ #category : #accessing }
LlWebVideo >> newPlayer [
	^ LlMediaPlayer on: self
]

{ #category : #playing }
LlWebVideo >> pauseIn: page [
	self videoIn: page doJavaScript: 'pause()'.
]

{ #category : #playing }
LlWebVideo >> playIn: page [
	self videoIn: page doJavaScript: 'play()'.
]

{ #category : #playing }
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
