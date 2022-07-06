Class {
	#name : #BrBibleVerse,
	#superclass : #Object,
	#instVars : [
		'contents'
	],
	#category : #'LivingLibrary-Bible'
}

{ #category : #accessing }
BrBibleVerse >> contents [
	^ self maLazyFrom: self contentsDescription
]

{ #category : #accessing }
BrBibleVerse >> contents: anObject [
	contents := anObject
]

{ #category : #'magritte-accessing' }
BrBibleVerse >> contentsDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #contents;
		yourself
]

{ #category : #printing }
BrBibleVerse >> printOn: aStream [
	aStream nextPutAll: self contents
]
