Class {
	#name : #WrittenWorkSpecification,
	#superclass : #TestCase,
	#category : #'LivingLibrary-Specifications'
}

{ #category : #tests }
WrittenWorkSpecification >> testAddEdition [

	| work edition |
	work := self testCreation.
	edition := LlEdition new description: '2nd Edition'.
	work editions add: edition.
	work editions first should equal: edition.
]

{ #category : #tests }
WrittenWorkSpecification >> testCreation [

	| author title work |
	author := MpPerson named: 'Famous Author'. "In real use, send `#meet:` instead to add  author to DB"
	title := 'Cool Book'.
	work := LlAuthoredWork titled: title by: author.
	work title should equal: title.
	work author should equal: author.
	^ work
]

{ #category : #tests }
WrittenWorkSpecification >> testNoAuthor [

	| title work |
	title := 'FDNY FORCIBLE ENTRY REFERENCE GUIDE: TECHNIQUES AND PROCEDURES'.
	work := LlAuthoredWork new
		title: title;
		yourself.
	work title should equal: title
		
]

{ #category : #tests }
WrittenWorkSpecification >> testPrinting [

	| work |
	work := self testCreation.
	work printString should equal: work title surroundedByDoubleQuotes, ' by ', work author fullName.
]
