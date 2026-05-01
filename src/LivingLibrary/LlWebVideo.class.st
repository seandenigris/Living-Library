Class {
	#name : 'LlWebVideo',
	#superclass : 'LlWebResource',
	#traits : 'RlTPlayable',
	#classTraits : 'RlTPlayable classTrait',
	#instVars : [
		'querySelector'
	],
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'accessing' }
LlWebVideo >> defaultDriver [
	^ RlApplescriptMediaDriver new
]

{ #category : 'as yet unclassified' }
LlWebVideo >> playableClass [
	^ RlDomVideo
]

{ #category : 'accessing' }
LlWebVideo >> present [
	^ self newPlayer
		play;
		yourself
]

{ #category : 'accessing' }
LlWebVideo >> querySelector [
	^ querySelector ifNil: [ 'video' ]
]

{ #category : 'accessing' }
LlWebVideo >> querySelector: anObject [
	querySelector := anObject
]
