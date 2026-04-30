Class {
	#name : 'LlContainedMedia',
	#superclass : 'Object',
	#instVars : [
		'container'
	],
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LlContainedMedia class >> in: container [

	^ self new
		container: container;
		yourself
]

{ #category : 'accessing' }
LlContainedMedia >> container [
	^ container
]

{ #category : 'accessing' }
LlContainedMedia >> container: anObject [
	container := anObject
]

{ #category : 'accessing' }
LlContainedMedia >> currentTime [
	^ self container currentTime seconds
]

{ #category : 'testing' }
LlContainedMedia >> isPlaying [
	^ self container isPlaying
]

{ #category : 'controlling' }
LlContainedMedia >> pause [
	self container pause
]

{ #category : 'controlling' }
LlContainedMedia >> play [
	self container play
]

{ #category : 'accessing' }
LlContainedMedia >> playbackSpeed [
	^ self container speed
]

{ #category : 'accessing' }
LlContainedMedia >> playbackSpeed: aNumber [
	self container speed: aNumber
]

{ #category : 'controlling' }
LlContainedMedia >> seekTo: aDuration [
	self container seekTo: aDuration
]
