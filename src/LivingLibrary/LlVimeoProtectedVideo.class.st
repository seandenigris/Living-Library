Class {
	#name : #LlVimeoProtectedVideo,
	#superclass : #LlVimeoVideo,
	#instVars : [
		'pageUrl',
		'unlistedHash'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #'as yet unclassified' }
LlVimeoProtectedVideo class >> fromUrl: aUrlOrString [

	| aUrl |
	aUrl := aUrlOrString asUrl.
	^ self
		withID: aUrl lastPathSegment
		andUnlistedHash: (aUrl queryAt: #h)
]

{ #category : #'instance creation' }
LlVimeoProtectedVideo class >> withID: aNumberOrString andUnlistedHash: aString [

	^ self new
		id: aNumberOrString asString;
		unlistedHash: aString;
		yourself
]

{ #category : #'as yet unclassified' }
LlVimeoProtectedVideo >> newPlayer [
	^ super newPlayer
		driver: LlApplescriptMediaDriver new;
		yourself
]

{ #category : #accessing }
LlVimeoProtectedVideo >> unlistedHash [
	^ unlistedHash
]

{ #category : #accessing }
LlVimeoProtectedVideo >> unlistedHash: anObject [
	unlistedHash := anObject
]

{ #category : #'as yet unclassified' }
LlVimeoProtectedVideo >> url [

	^ super url / self unlistedHash
]
