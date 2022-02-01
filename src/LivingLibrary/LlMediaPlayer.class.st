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
LlMediaPlayer >> currentPosition [
	"Compatibility with other types of players - position may not always be a duration"
	^ self currentTime
]

{ #category : #accessing }
LlMediaPlayer >> currentPosition: aDuration [
	"Compatibility with other types of players - position may not always be a duration"
	^ self currentTime: aDuration
]

{ #category : #accessing }
LlMediaPlayer >> currentTime [
	| asResult |
	asResult := CwSafari new doJavascript: LlYouTubeVideo new jsPlayerGetCurrentTime.
	^ asResult isNumber
		ifTrue: [ asResult seconds ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
LlMediaPlayer >> currentTime: aDuration [
	^ CwSafari new doJavascript: (LlYouTubeVideo new jsPlayerSeekTo: aDuration)
]

{ #category : #accessing }
LlMediaPlayer >> media [

	^ media
]

{ #category : #accessing }
LlMediaPlayer >> media: anObject [

	media := anObject
]

{ #category : #actions }
LlMediaPlayer >> pause [
	| js |
	js := SuJSScript htmlVideos + SuJSScript videoPause
		argumentAt: #video put: 'videos[0]';
		argumentAt: #videosVarName put: 'videos'.
	
	CwSafari new doJavascript: js
]

{ #category : #actions }
LlMediaPlayer >> play [
	| js |
	js := SuJSScript htmlVideos + SuJSScript videoPlay
		argumentAt: #video put: 'videos[0]';
		argumentAt: #videosVarName put: 'videos'.
	
	CwSafari new doJavascript: js
]

{ #category : #actions }
LlMediaPlayer >> view [
	self media view.
]
