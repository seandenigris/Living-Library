Class {
	#name : #LlVimeoProtectedVideo,
	#superclass : #LlWebResource,
	#instVars : [
		'id'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #'instance creation' }
LlVimeoProtectedVideo class >> withID: aNumber [

	^ self new
		id: aNumber;
		yourself
]

{ #category : #accessing }
LlVimeoProtectedVideo >> id [

	^ id
]

{ #category : #accessing }
LlVimeoProtectedVideo >> id: anObject [

	id := anObject
]

{ #category : #accessing }
LlVimeoProtectedVideo >> newPlayer [
	^ (LlMediaPlayer on: self cache)
		driver: LlPythonMpv new;
		yourself
]
