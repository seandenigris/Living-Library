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
	#name : #LlMediaPlayer,
	#superclass : #Object,
	#instVars : [
		'media',
		'driver',
		'mediaContainer'
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
	^ self media currentPositionIn: self mediaContainer
]

{ #category : #accessing }
LlMediaPlayer >> currentPosition: anObject [
	self media currentPosition: anObject in: self mediaContainer
]

{ #category : #accessing }
LlMediaPlayer >> currentTime [
	^ self media currentTimeIn: self mediaContainer
]

{ #category : #accessing }
LlMediaPlayer >> currentTime: aDuration [
	^ self media seekTo: aDuration in: self mediaContainer
]

{ #category : #accessing }
LlMediaPlayer >> driver [

	^ driver
]

{ #category : #accessing }
LlMediaPlayer >> driver: anObject [

	driver := anObject
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
LlMediaPlayer >> mediaContainer [
	^ mediaContainer
]

{ #category : #accessing }
LlMediaPlayer >> nextSection [
	^ self media nextSectionIn: self mediaContainer
]

{ #category : #actions }
LlMediaPlayer >> pause [
	self media pauseIn: self mediaContainer
]

{ #category : #actions }
LlMediaPlayer >> play [
	self media playIn: self mediaContainer
]

{ #category : #accessing }
LlMediaPlayer >> previousSection [
	^ self media previousSectionIn: self mediaContainer
]

{ #category : #actions }
LlMediaPlayer >> view [
	mediaContainer := self driver show: self media
]
