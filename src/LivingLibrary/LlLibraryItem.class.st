Class {
	#name : #LlLibraryItem,
	#superclass : #Object,
	#traits : 'MATPropertyOwner',
	#classTraits : 'MATPropertyOwner classTrait',
	#instVars : [
		'work'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #accessing }
LlLibraryItem class >> gtSpotterNew: aClass for: aStep [
	
	aStep listProcessor
		title: 'New ', aClass label;
		priority: 50;
		itemName: [ :input | '+ ', aClass label, ': ', input ];
		previewObject: [ :input | aClass fromLinkString: input ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :cntxt | 
				| isClass |
				isClass := aClass isClassForString: cntxt textTrimmed.
				isClass ifTrue: [ filter value: cntxt textTrimmed ] ];
		send: [ :input :spotterStep | aClass fromLinkString: input ]
]

{ #category : #accessing }
LlLibraryItem class >> gtSpotterNewFor: aStep [
	<gtSearch>
	
	aStep listProcessor
		title: 'New instance';
		priority: 50;
		allCandidates: [ self allSubclasses ];
		previewObject: [ :input | "aClass fromLinkString:" input ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :cntxt | 
				| isClass |
				"isClass := aClass isClassForString: cntxt textTrimmed.
				isClass ifTrue: [" filter value: cntxt textTrimmed "]" ];
		send: [ :input :spotterStep | "aClass fromLinkString:" input ]
]

{ #category : #accessing }
LlLibraryItem class >> gtSpotterNewSubInstanceFor: aStep [
"	<gtSearch>"
	
	self withAllSubclasses do: [ :cls |
		self gtSpotterNew: cls for: aStep ]
]

{ #category : #testing }
LlLibraryItem class >> isClassForString: aString [
	"Is this string input convertible to an instance of a particular subclass?"
	^ false
]

{ #category : #'magritte-accessing' }
LlLibraryItem >> descriptionWork [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #work;
		classes: { LlAuthoredWork. LlEdition };
		yourself
]

{ #category : #accessing }
LlLibraryItem >> work [
	^ self maLazyInstVarUsing: self descriptionWork
]

{ #category : #accessing }
LlLibraryItem >> work: aWork [
	work := aWork
]
