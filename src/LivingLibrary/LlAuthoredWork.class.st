"
This is the most general level at which we discuss a creation. We might say `Alice in Wonderland`, which includes ""all versions, printings, and translations"" ([ref](https://www.w3.org/2001/sw/wiki/Library_terminology_informally_explained))

# Examples

## Series, Adding to

```smalltalk
(FileLocator home / 'Documents' filesMatching: '*.docx') allButFirst collect: [ :e |
	| r w | 
	r := e asRlResource.
	RlResourceLibrary uniqueInstance importer
	resourceable: r;
	strategy: RlInPlaceImportStrategy;
	execute.
	w := LlAuthoredWork titled: 'Issue ', e base squeezeOutNumber asString by: PeGtSpotterResult.
	w parent: self
	w addToLibraryCopy: r ]
```

#Implementation Note:
The ""type"" is currently like a tag. While we started with a class per type ((e.g. book vs. magazine), it seems like there's little benefit until we can justify differing behavior.
"
Class {
	#name : #LlAuthoredWork,
	#superclass : #Object,
	#traits : 'LlTLibraryItem + MATPropertyOwner + MpTAlphabetizable',
	#classTraits : 'LlTLibraryItem classTrait + MATPropertyOwner classTrait + MpTAlphabetizable classTrait',
	#instVars : [
		'title',
		'type',
		'authors',
		'library',
		'editions',
		'parent',
		'children'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #'instance creation' }
LlAuthoredWork class >> article [
	^ self new
			type: #Article;
			yourself
]

{ #category : #example }
LlAuthoredWork class >> exampleAntifragile [
	<gtExample>
	| result |
	result := self titled: 'Antifragile' by: MpPerson exampleNassimTaleb.
	result title should equal: 'Antifragile'.
	^ result
]

{ #category : #example }
LlAuthoredWork class >> exampleHamlet [
	<gtExample>
	| result |
	result := self titled: 'Hamlet' by: 'William Shakespeare'.
	result title should equal: 'Hamlet'.
	^ result
]

{ #category : #accessing }
LlAuthoredWork class >> exampleParentChild [
	"What should happen here? If a child is addd to parent or vice versa, it seems to make sense to make sure they're both added to the library as well. However, then we can't lazily initialize the default library because there's no way to tell if the work has been added to a library or if it's just the default. In fact, a library isn't the work's library until it has been added. What if the libraries are different?"
]

{ #category : #accessing }
LlAuthoredWork class >> exampleStarWarsSeries [
	<gtExample>
	| series newHope strikesBack |
	series := LlAuthoredWork new
		title: 'Star Wars';
		type: #Series;
		yourself.
	newHope := LlAuthoredWork new
		title: 'Episode IV – A New Hope';
		type: #Movie;
		parent: series;
		yourself.
	strikesBack := LlAuthoredWork new
		title: 'Episode V – The Empire Strikes Back';
		type: #Movie;
		parent: series;
		yourself.
	^ series
]

{ #category : #example }
LlAuthoredWork class >> exampleStopDrawingDeadFish [
	<gtExample>
	"Companion is LlYouTubeVideo exampleStopDrawingDeadFish"
	| result |
	result := self titled: 'Stop Drawing Dead Fish' by: MpPerson exampleBretVictor.
	result title should equal: 'Stop Drawing Dead Fish'.
	^ result
]

{ #category : #examples }
LlAuthoredWork class >> exampleTranscriptEmptyPage [
	<gtExample>
	^ self
		given: [ LlLibrary example ]
		when: [ :lib |
			| page work |
				work := lib works first.
				page := LePage quTranscriptOwner: work.
				LeDatabase new addPage: page.
				page type stub subjectModelReference willReturn: (OlDummyObjectUIDReferenceForTesting new
					source: lib works;
					uid: work uuid;
					yourself).
					page ]
		then: [ :page | page "children should haveSize: 1" ]
]

{ #category : #testing }
LlAuthoredWork class >> isAbstract [
	^ false
]

{ #category : #accessing }
LlAuthoredWork class >> knownAuthors [

	^ OrderedCollection streamContents: [ :s | self allSubInstancesDo: [ :b | b authors do: [ :a | s nextPut: a ] ] ].
]

{ #category : #accessing }
LlAuthoredWork class >> newAcademicPaper [
	^ self new
		type: #'Academic Paper';
		yourself
]

{ #category : #accessing }
LlAuthoredWork class >> newEBook [
	^ self new
		type: #'E-book'; "https://en.wikipedia.org/wiki/E-book"
		yourself
]

{ #category : #'instance creation' }
LlAuthoredWork class >> titled: titleString [
	^ self new 
		title: titleString;
		yourself
]

{ #category : #'instance creation' }
LlAuthoredWork class >> titled: titleString by: authorOrCollection [
	^ self new 
		title: titleString;
		authors: authorOrCollection llAsCollection.
]

{ #category : #accessing }
LlAuthoredWork class >> types [
	^ #(#'E-book' #'Academic Paper' Book Article).
]

{ #category : #comparing }
LlAuthoredWork >> = rhs [
	^ self == rhs
]

{ #category : #accessing }
LlAuthoredWork >> addChild: aWork [
	self syncLibraryWith: aWork.	
	self children add: aWork. "Children currently a set so don't worry about duplicate adding"
]

{ #category : #accessing }
LlAuthoredWork >> author [

	self assert: self authors size = 1.
	^ self authors first.
]

{ #category : #accessing }
LlAuthoredWork >> author: person [
	authors := { person }

]

{ #category : #accessing }
LlAuthoredWork >> authors [

	^ authors ifNil: [ authors := OrderedCollection new ]
]

{ #category : #'private-magritte' }
LlAuthoredWork >> authors: aCollection [
	"We need this because Magritte's ToMany Relations replace the whole collection"
	authors := aCollection
]

{ #category : #magritte }
LlAuthoredWork >> authorsDescription [
	<magritteDescription>
	
	^ MAMultipleOptionDescription new
		accessor: #authors;
		label: 'Authors';
		priority: 200;
		default: {};
		options: MpAddressBook default people; 
		yourself
]

{ #category : #accessing }
LlAuthoredWork >> ccAuthorMarkup [
	^ String streamContents: [ :str |
		self authors
			do: [ :e | str << '*' << e fullName << '>' << e website asString << '*'  ]
			separatedBy: [ str space ] ]
]

{ #category : #accessing }
LlAuthoredWork >> children [
	^ children ifNil: [ children := Set new ]
]

{ #category : #'library access' }
LlAuthoredWork >> copies [
	^ self library copiesOf: self
]

{ #category : #accessing }
LlAuthoredWork >> editions [
	^ self maLazyInstVarUsing: self editionsDescription
]

{ #category : #accessing }
LlAuthoredWork >> editions: anObject [
	editions := anObject
]

{ #category : #'magritte-accessing' }
LlAuthoredWork >> editionsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #editions;
		classes: { LlEdition };
		default: OrderedCollection new;
		yourself
]

{ #category : #accessing }
LlAuthoredWork >> family [
	^ OrderedCollection streamContents: [ :str |
		str nextPutAll: self withAncestors.
		self children do: [ :child | str nextPutAll: child withOffspring ] ]
]

{ #category : #private }
LlAuthoredWork >> fullName [
	"Trait compatibility"
	^ self fullTitle
]

{ #category : #accessing }
LlAuthoredWork >> fullTitle [
	^ self pathString 
		ifEmpty: [ self title ]
		ifNotEmpty: [ :p | p, ': ', self title ]
]

{ #category : #'library access' }
LlAuthoredWork >> getCopy [
	^ self copies ifNotEmpty: [ :col | col atRandom ] ifEmpty: [ nil ].
]

{ #category : #accessing }
LlAuthoredWork >> gtViewChildrenFor: aView [

	<gtView>
	self children ifEmpty: [ ^ aView empty ].

	^ aView list
		  title: 'Children' translated;
		  priority: 70;
		  items: [ self children asOrderedCollection ];
		  itemText: [ :w | w title ];
		  actionUpdateButtonTooltip: 'Update'
]

{ #category : #accessing }
LlAuthoredWork >> gtViewCopiesFor: aView [
	<gtView>

	(self library isNil or: [ self copies isEmpty ]) ifTrue: [ ^ aView empty ].
	
	^ aView list
		title: 'Copies' translated;
		priority: 60;
		items: [ self copies asOrderedCollection ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #transcript }
LlAuthoredWork >> gtViewTranscriptFor: aView [
	<gtView>

	(self hasProperty: #transcript) ifFalse: [ ^ aView empty ].
	
	^ aView forward
		title: 'Transcript' translated;
		priority: 65;
		object: [ self transcript lepiterPage ];
		view: #gtLiveFor:;
		actionButtonIcon: LeIcons lepiterIcon
			tooltip: 'Lepiter Page (Inspect)'
			action: [ :aButton :aTab | aButton phlow spawnObject: self transcript lepiterPage ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect Transcript'
			action: [ :aButton :aTab | aButton phlow spawnObject: self transcript ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #accessing }
LlAuthoredWork >> hash [
	^ self identityHash
]

{ #category : #initialization }
LlAuthoredWork >> initialize [

	super initialize.
	type := #unknown.
]

{ #category : #testing }
LlAuthoredWork >> isPlayable [
	^ self copies isNotEmpty
]

{ #category : #comparing }
LlAuthoredWork >> isSameAs: rhs [
	self species = rhs species ifFalse: [ ^ false ].
	^ self title = rhs title and: [ self authors sort hasEqualElements: rhs authors sort ].
]

{ #category : #private }
LlAuthoredWork >> library [
	^ library
	"Implementation Note: This used to be lazily initialized to the Living Library singleton. It is not currently, because in the domain to logically to have a library means the work has been added to that library. So the appropriate place to set this is during that addition. Returning a non-nil before that is logically wrong"
]

{ #category : #debugging }
LlAuthoredWork >> library: anObject [
	library := anObject
]

{ #category : #accessing }
LlAuthoredWork >> license [
	^ self maLazyPropertyUsing: self licenseDescription
]

{ #category : #accessing }
LlAuthoredWork >> license: anObject [
	self propertyAt: #license put: anObject
]

{ #category : #accessing }
LlAuthoredWork >> licenseAttribution [
	^ self license attributionFor: self
]

{ #category : #accessing }
LlAuthoredWork >> licenseDescription [
	<magritteDescription>
	
	^ MASingleOptionDescription new
		accessor: #license;
		priority: 200;
		options: CcLicense all; 
		yourself
]

{ #category : #accessing }
LlAuthoredWork >> newPlayer [
	^ self copies
		ifNotEmpty: [ :cps | cps atRandom newPlayer ]
		ifEmpty: [ self shouldBeImplemented ]
]

{ #category : #accessing }
LlAuthoredWork >> parent [
	^ parent
]

{ #category : #accessing }
LlAuthoredWork >> parent: aWork [
	aWork addChild: self. "Add child first because it will attempt to sync libraries and signal error if impossible"
	parent := aWork.
]

{ #category : #transcript }
LlAuthoredWork >> participants [
	^ self authors
]

{ #category : #accessing }
LlAuthoredWork >> pathString [
	^ parent ifNotNil: [ :p | p fullTitle ] ifNil: [ '' ]
]

{ #category : #printing }
LlAuthoredWork >> printOn: aStream [

	self title 
		isEmptyOrNil ifFalse: [ 
			aStream
				nextPut: $";
				nextPutAll: self fullTitle;
				nextPut: $" ].
	authors isEmptyOrNil ifTrue: [ ^ self ].
	aStream nextPutAll: ' by '.
	authors
		do: [ :e | aStream nextPutAll: e fullName ]
		separatedBy: [ aStream nextPutAll: ', ' ]
]

{ #category : #quotation }
LlAuthoredWork >> quote: aString onPage: aNumber [
	| citation quote |
	citation := QuPageCitation new
			source: self;
			page: aNumber;
			yourself.
	quote := QuQuote new
		content: aString;
		citation: citation;
		yourself.
	self quoteDb add: quote
]

{ #category : #quotation }
LlAuthoredWork >> quoteDb [
	^ QuQuote db
]

{ #category : #quotation }
LlAuthoredWork >> quotes [
	^ self quoteDb select: [ :e | e citation source = self ]
]

{ #category : #actions }
LlAuthoredWork >> searchWebForCopies [

	"Vendors listed in reverse order of moral value because the last tab opened will be on top"	
	'https://www.amazon.com/s?i=stripbooks' asUrl
		queryAt: #k put: self title;
		open.
	'https://www.thriftbooks.com/browse/' asUrl
		queryAt: 'b.search' put: self title;
		open.
	'https://www.worldofbooks.com/en-us/category/all' asUrl
		queryAt: 'search' put: self title;
		open.
	'https://www.betterworldbooks.com/search/results' asUrl
		queryAt: #q put: self title;
		open
]

{ #category : #private }
LlAuthoredWork >> setTitle: titleString author: authorString [

	title := titleString.
	self author: authorString.
	^ self.
]

{ #category : #accessing }
LlAuthoredWork >> syncLibraryWith: aWork [ 
	| isLibraryConflict |
	"If both nil, nothing to set; if both non-nil equal, no action needed"
	aWork library = self library ifTrue: [ ^ self ].
	
	"If we get here, the libraries are not equal"
	isLibraryConflict := aWork library isNotNil and: [ self library  isNotNil ].
	isLibraryConflict ifTrue: [ ^ self error: 'Child and parent work libraries conflict' ].
	
	"If we get here, one library is nil"
	aWork library 
		ifNil: [ self library beAwareOf: aWork ]
		ifNotNil: [ aWork library beAwareOf: self ].
]

{ #category : #accessing }
LlAuthoredWork >> title [

	^ title" ifNil: [ '' ]"
]

{ #category : #accessing }
LlAuthoredWork >> title: aString [
	title := aString

]

{ #category : #magritte }
LlAuthoredWork >> titleDescription [
	<magritteDescription>
	
	^ MAStringDescription new
		accessor: #title;
		label: 'Title';
		default: '';
		priority: 100;
		yourself
]

{ #category : #accessing }
LlAuthoredWork >> transcript [

	^ self 
		propertyAt: #transcript
		ifAbsentPut: [ 
			QuTranscript new
				subjectModel: self;
				yourself ]
]

{ #category : #accessing }
LlAuthoredWork >> transcript: aQuTranscript [
	self propertyAt: #transcript putRemovingNil: aQuTranscript
]

{ #category : #accessing }
LlAuthoredWork >> type [

	^ type.
]

{ #category : #accessing }
LlAuthoredWork >> type: aString [ 
	type := aString.
]

{ #category : #magritte }
LlAuthoredWork >> typeDescription [
    ^ MASingleOptionDescription new
        accessor: #type;
        label: 'Type' ; 
        priority: 50;
        options: self class types;
        beSorted;
"        beRequired; "
        yourself
]

{ #category : #accessing }
LlAuthoredWork >> view [
	self copies 
		ifNotEmpty: [ :col | col atRandom open ]
		ifEmpty: [ self error: 'No copies to view!' ]
]

{ #category : #accessing }
LlAuthoredWork >> viewDescription [
	<magritteActionDescription>
	^ MAActionDescription new
		gtIcon: BrGlamorousVectorIcons playinspect;
		isLabelVisible: true;
		enableBlock: [ false ];
		action: #view;
		yourself
]

{ #category : #accessing }
LlAuthoredWork >> withAncestors [
	^ OrderedCollection streamContents: [ :str |
		str nextPut: self.
		self parent ifNotNil: [ :p | str nextPutAll: p withAncestors ] ]
]

{ #category : #accessing }
LlAuthoredWork >> withOffspring [
	^ OrderedCollection streamContents: [ :str |
		str nextPut: self.
		self children do: [ :child | str nextPutAll: child withOffspring ] ]
]
