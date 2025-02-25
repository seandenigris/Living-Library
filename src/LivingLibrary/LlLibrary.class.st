"
#Choosing a library

A default library is likely the only one you will need. If you're just starting out, it will be empty, and thus less interesting, so you can check out this example library: {{gtExample:LlLibrary class>>example}}

When you're ready to get to work, the default library can be accessed like this:

```smalltalk
LlLibrary uniqueInstance
```

#Adding Items
There are two methods to add a copy of a work. Send {{gtMethod:LlLibrary>>receive:}} if the copy already ""knows"" its work. Otherwise, you can send {{gtMethod:LlLibrary>>addCopy:of:}} and the library will associate them. NB the former returns `self` and the latter returns the copy.

##Physical Items
Say we have a CD. It's not a work itself, but a copy of that work - say an audiobook. Other copies might be Blueray, VHS, or streaming.
{{gtExample:LlLibrary class>>#exampleAddPhysicalItem}}
##Digital Items
{{gtExample:LlLibrary class>>#exampleAddDigitalItem}}
##Items you don't have any copies of
If there is a work that you want to remain aware of, before you actually have a copy yourself, you can do it like this: {{gtExample:LlLibrary class>>exampleAddSeries}}
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
	#category : #'LivingLibrary-Core'
}

{ #category : #accessing }
LlLibrary class >> example [
	<gtExample>
	^ self
		given: [ LlLibrary new ]
		when: [ :lib |
			lib 
				importAllFrom: self exampleAddDigitalItem;
				importAllFrom: self exampleAddPhysicalItem;
				importAllFrom: self exampleAddSeries;
				importAllFrom: self exampleAddYouTubeVideo;
				yourself ]
		then: [ :lib | lib works should haveSize: 6 ]
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
	^ lib
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

{ #category : #accessing }
LlLibrary class >> exampleAddYouTubeVideo [
	<gtExample>
	| pdfFile copy lib work |
	work := LlAuthoredWork new 
		title: 'Stop Drawing Dead Fish';
		author: MpPerson exampleBretVictor.
	copy := LlYouTubeVideo exampleStopDrawingDeadFish.
	
	lib := LlLibrary new 
		addCopy: copy of: work;
		yourself.
	lib should be hasCardFor: work.
	(lib where copiesOf: work) should haveSize: 1.
	(lib where copiesOf: work) should include: copy.
	^ lib
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

{ #category : #'copies - adding' }
LlLibrary >> addCopy: copy of: work [
	| copies |
	copy work: work.
	copies := self ensureCardFor: work.
	^ copies add: copy.
]

{ #category : #accessing }
LlLibrary >> addressBook [
	
	^ MpAddressBook uniqueInstance
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
LlLibrary >> copies [

	^ self catalog flatCollect: #yourself
]

{ #category : #accessing }
LlLibrary >> copiesOf: aWrittenWork [

	^ catalog at: aWrittenWork ifAbsent: [ #() ]
]

{ #category : #accessing }
LlLibrary >> copy: anObject removeFrom: aWrittenWork [

	| copies |
	anObject work: nil.
	copies := self copiesOf: aWrittenWork.
	^ copies remove: anObject
]

{ #category : #private }
LlLibrary >> ensureCardFor: work [
	work family do: [ :e | 
		self catalog 
			at: e 
			ifAbsentPut: [ 
				e library: self.
				Set new ] ].
	^ self catalog at: work
]

{ #category : #testing }
LlLibrary >> hasCardFor: aWork [
	^ self catalog includesKey: aWork
]

{ #category : #accessing }
LlLibrary >> importAllFrom: aLibrary [
	aLibrary catalog keysAndValuesDo: [ :work :rhsCopies |
		self catalog
			at: work
			ifPresent: [ :myCopies | myCopies addAll: rhsCopies ]
			ifAbsentPut: [ rhsCopies ] ].
]

{ #category : #accessing }
LlLibrary >> printOn: aStream [
	
	| numCopies |
	numCopies := self works 
		inject: 0 
		into: [ :sum :w | sum + (self copiesOf: w) size ].
	aStream
		print: numCopies;
		nextPutAll: ' copies of ';
		print: self works size;
		nextPutAll: ' works'
]

{ #category : #'copies - adding' }
LlLibrary >> receive: aCopy [
	self addCopy: aCopy of: aCopy work
]

{ #category : #private }
LlLibrary >> removeCardFor: work [
	self catalog removeKey: work
]

{ #category : #accessing }
LlLibrary >> removeWork: aLlAuthoredWork [ 
	
	self removeCardFor: aLlAuthoredWork.
	aLlAuthoredWork
		library: nil;
		removeChildren.
]

{ #category : #accessing }
LlLibrary >> rootWorks [
	^ self works select: [ :e | e parent isNil ]
]

{ #category : #accessing }
LlLibrary >> verifyModel [
	
	| libs |
	libs := self works collect: [ :e | e library ] as: IdentitySet.
	libs size = 1 ifFalse: [ self error ].
	libs atRandom == self ifFalse: [ self error ].
	
	self works do: [ :e | 
		| copies |
		copies := self copiesOf: e.
		copies do: [ :c | 
			self assert: c work == e.
			self assert: e library == self ]. ].
]

{ #category : #actions }
LlLibrary >> view: aWrittenWork [

	| copies |
	copies := catalog
		at: aWrittenWork
		ifAbsent: [ self error: 'No copies of ', aWrittenWork asString ].
	copies atRandom present
]

{ #category : #'magritte-accessing' }
LlLibrary >> workClass [
	
	^ LlAuthoredWork
]

{ #category : #accessing }
LlLibrary >> works [
	^ self catalog keys
]

{ #category : #views }
LlLibrary >> works: aValuable gtViewOn: aView title: aString priority: aNumber [
	
	(self works isEmpty) ifTrue: [ ^ aView empty ].
	^ aView tree
		title: aString translated;
		priority: aNumber;
		items: aValuable;
		children: [ :each | 
			(each isKindOf: self workClass)
				ifTrue: [ each treeChildren ]
				ifFalse: [ #() ] ];
		itemText: #displayString;
		actionUpdateButton
]

{ #category : #'magritte-accessing' }
LlLibrary >> worksDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #works;
		classes: { self workClass };
		default: OrderedCollection new;
		readOnly;
		yourself
]

{ #category : #searches }
LlLibrary >> worksGtSearchFor: aSearch [
	<gtSearch>
	
	^ aSearch list
		priority: 5;
		title: 'Works';
		items: [ self works ];
		matchSubstrings;
		itemName: #displayString
]

{ #category : #searches }
LlLibrary >> worksGtSearchNewFor: aSearch [
	<gtSearch>
	
	^ aSearch explicit
		title: 'New Work';
		priority: 50;
		itemName: [ :result | '+ ', result gtDisplayText ];
		search: [ :aContext | 
			| input |
			input := aContext searchQuery trimBoth.
			{ self workClass new 
				title: input; 
				yourself } asAsyncStream ];
		send: [ :anObject | 
			self beAwareOf: anObject.
			anObject ]
]

{ #category : #views }
LlLibrary >> worksGtViewOn: aView [
	<gtView>

	^ self 
		works: [ self rootWorks sort: #nameForAlphabetization ascending ] 
		gtViewOn: aView 
		title: 'Works'
		priority: 25
]

{ #category : #views }
LlLibrary >> worksImportDescending [
	^ self rootWorks sort: #importTimestamp descending
]

{ #category : #views }
LlLibrary >> worksRecentGtViewOn: aView [
	<gtView>
	^ self
		works: [ self worksImportDescending ]
		gtViewOn: aView
		title: 'Recent Works'
		priority: 32
]
