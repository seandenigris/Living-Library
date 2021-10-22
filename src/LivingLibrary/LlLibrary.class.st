"
#Adding Items
##Physical Items
Say we have a CD. It's not a work itself, but a copy of that work - say an audiobook. Other copies might be Blueray, VHS, or streaming.
{{gtExample:LivingLibrary class>>#exampleAddPhysicalItem}}
##Digital Items
{{gtExample:LivingLibrary class>>#exampleAddDigitalItem}}
"
Class {
	#name : #LlLibrary,
	#superclass : #Object,
	#instVars : [
		'catalog'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'LivingLibrary-Core'
}

{ #category : #accessing }
LlLibrary class >> example [

]

{ #category : #accessing }
LlLibrary class >> exampleAdd [
]

{ #category : #accessing }
LlLibrary class >> exampleAddDigitalItem [
	<gtExample>
	| pdfFile copy lib work |
	work := LlAuthoredWork new title: 'Forcible Entry Reference Guide'.
	pdfFile := FileLocator home / 'Documents/Fire Department/Firefighting/Training/FDNY-FORCIBLE ENRTY REFERENCE GUIDE.pdf'.
	copy := pdfFile asRlResource.
	
	lib := LlLibrary new 
		addCopy: copy of: work;
		yourself.
	lib should be hasCardFor: work.
	(lib where copiesOf: work) should haveSize: 1.
	(lib where copiesOf: work) should include: copy.
	^ lib
]

{ #category : #accessing }
LlLibrary class >> exampleAddPhysicalItem [
	<gtExample>
	| copy work lib |
	work := LlAuthoredWork exampleAntifragile.
	copy := LlPhysicalResource new
		description: work title , ' CD';
		location: 'office bookshelf';
		yourself.
	lib := LlLibrary new
		addCopy: copy of: work;
		yourself.
	(lib where copiesOf: work) should haveSize: 1.
	(lib where copiesOf: work) should include: copy.
]

{ #category : #accessing }
LlLibrary class >> exampleAddSeries [
	<gtExample>
	^ self
		given: [ LlLibrary new ]
		when: [ :lib |
			lib 
				beAwareOf: LlAuthoredWork exampleStarWarsSeries;
			yourself ]
		then: [ :a :b | ]
]

{ #category : #persisting }
LlLibrary class >> restoreFrom: aLivingLibrary [

	self uniqueInstance: aLivingLibrary.

]

{ #category : #persisting }
LlLibrary class >> spData [

	^ self uniqueInstance
]

{ #category : #accessing }
LlLibrary class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ].
]

{ #category : #accessing }
LlLibrary class >> uniqueInstance: aLivingLibrary [
	uniqueInstance := aLivingLibrary

]

{ #category : #private }
LlLibrary >> addCopy: copy of: work [
	| copies |
	copy work: work.
	copies := self ensureCardFor: work.
	copies add: copy.
]

{ #category : #actions }
LlLibrary >> beAwareOf: work [
	^ self ensureCardFor: work
]

{ #category : #accessing }
LlLibrary >> catalog [
	^ catalog ifNil: [ catalog := Dictionary new ].
]

{ #category : #'*LivingLibrary-Features' }
LlLibrary >> collection [

	^ self catalog keys.
]

{ #category : #accessing }
LlLibrary >> copiesOf: aWrittenWork [

	^ catalog at: aWrittenWork ifAbsent: [ #() ]
]

{ #category : #private }
LlLibrary >> ensureCardFor: work [
	work family do: [ :e | self catalog at: e ifAbsentPut: [ Bag new ] ].
	^ self catalog at: work
]

{ #category : #accessing }
LlLibrary >> gtGtSpotterFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 5;
		title: 'Works';
		allCandidates: [ self works ];
		filter: GtFilterSubstrings;
		candidatesLimit: 7;
		itemName: #fullTitle;
		send: [ :work | (self copiesOf: work) ifEmpty: [ work ] ]
]

{ #category : #accessing }
LlLibrary >> gtSpotterNewWorkFor: aStep [
	<gtSearch>
	aStep listProcessor
		title: 'New Work';
		priority: 50;
		itemName: [ :input | 'Create new work: ', input ];
		previewObject: [ :input | LlAuthoredWork new title: input; yourself ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :context | 
				| isExisting |
				isExisting := self works anySatisfy: [ :e | 
					e title = context textTrimmed ].
				isExisting ifFalse: [ 
					filter value: context textTrimmed ] ];
		send: [ :newName :spotterStep | 
			| work |
			work := LlAuthoredWork new title: newName; yourself.
			self beAwareOf: work.
			work ]
]

{ #category : #views }
LlLibrary >> gtViewWorksOn: aView [
	<gtView>

	(self works isEmpty) ifTrue: [ ^ aView empty ].
	^ aView tree
		title: 'Works' translated;
		priority: 25;
		items: [ self works ];
		children: [ :each | 
			(each isKindOf: LlAuthoredWork)
				ifTrue: [ self catalog at: each ]
				ifFalse: [ #() ] ];
		itemText: #displayString;
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #testing }
LlLibrary >> hasCardFor: aWork [
	^ self catalog includesKey: aWork
]

{ #category : #actions }
LlLibrary >> receive: aCopy [
	self addCopy: aCopy of: aCopy work
]

{ #category : #actions }
LlLibrary >> view: aWrittenWork [

	| copies |
	copies := catalog
		at: aWrittenWork
		ifAbsent: [ self error: 'No copies of ', aWrittenWork asString ].
	copies atRandom view
]

{ #category : #accessing }
LlLibrary >> works [
	^ self catalog keys sort: (#fullTitle collatedBy: #asLowercase)
]

{ #category : #'magritte-accessing' }
LlLibrary >> worksDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #works;
		classes: { LlAuthoredWork };
		default: OrderedCollection new;
		readOnly;
		yourself
]
