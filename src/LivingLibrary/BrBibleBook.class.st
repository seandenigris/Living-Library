Class {
	#name : 'BrBibleBook',
	#superclass : 'Object',
	#instVars : [
		'title',
		'abbreviation',
		'chapters'
	],
	#category : 'LivingLibrary-Bible',
	#package : 'LivingLibrary',
	#tag : 'Bible'
}

{ #category : 'accessing' }
BrBibleBook >> abbreviation [
	^ abbreviation
]

{ #category : 'accessing' }
BrBibleBook >> abbreviation: anObject [
	abbreviation := anObject
]

{ #category : 'converting' }
BrBibleBook >> brAsBook [
	^ self
]

{ #category : 'accessingas yet unclassified' }
BrBibleBook >> chapters [
	^ chapters ifNil: [ chapters := Dictionary new ]
]

{ #category : 'as yet unclassified' }
BrBibleBook >> import: versesString asChapter: anInteger [
	"versesString - 'Brethren, ...

2 Bear ye ..."

	| verseLines verseLinesWithoutNumbers verses |
	verseLines := versesString lines reject: #isEmpty.
	verseLinesWithoutNumbers := {verseLines first}
		, (verseLines allButFirst collect: [ :e | e copyAfter: $  ]).
	verses := verseLinesWithoutNumbers
		collect: [ :e | 
			BrBibleVerse new
				at: 'KJV' put: e;
				yourself ].
	self at: anInteger put: verses
]

{ #category : 'printing' }
BrBibleBook >> printOn: aStream [
	aStream nextPutAll: self title
]

{ #category : 'accessing' }
BrBibleBook >> title [
	^ self maLazyFrom: self titleDescription
]

{ #category : 'accessing' }
BrBibleBook >> title: anObject [
	title := anObject
]

{ #category : 'magritte-accessing' }
BrBibleBook >> titleDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #title;
		yourself
]
