Class {
	#name : #WrittenWorkSpecification,
	#superclass : #TestCase,
	#category : #'LivingLibrary-Specifications'
}

{ #category : #tests }
WrittenWorkSpecification >> testAddEdition [

	| work edition |
	work := self given: #testCreation.
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
WrittenWorkSpecification >> testLibraryControl [
	| work library |
	work := self given: #testCreation.
	library := LivingLibrary new.
	library beAwareOf: work.
	library works add: work.
	library works should include: work
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
WrittenWorkSpecification >> testPdfCopy [

	| title work library |
	library := context mock: 'library'.
	title := 'FDNY FORCIBLE ENTRY REFERENCE GUIDE: TECHNIQUES AND PROCEDURES'.
	work := LlAuthoredWork new
		title: title;
		library: library;
		yourself.
	library should receive: #copyOf:; with: work.
	work anyCopy.
		
]

{ #category : #tests }
WrittenWorkSpecification >> testPrinting [

	| work |
	work := self given: #testCreation.
	work printString should equal: work title surroundedByDoubleQuotes, ' by ', work author fullName.
]
