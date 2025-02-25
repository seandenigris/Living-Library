Class {
	#name : #LlPodcast,
	#superclass : #Object,
	#traits : 'PeTRawDataHolder - {#rawDataAt:reader:ifAbsent:}',
	#classTraits : 'PeTRawDataHolder classTrait',
	#category : #LivingLibrary
}

{ #category : #'instance creation' }
LlPodcast class >> fromXml: aXMLElement [ 

	^ self new
		rawData: aXMLElement;
		yourself
]

{ #category : #accessing }
LlPodcast >> author [
	
	^ self 
		rawDataAt: #author
		reader: #contentString
]

{ #category : #printing }
LlPodcast >> displayStringOn: aStream [

	aStream
		nextPutAll: self title surroundedByDoubleQuotes;
		nextPutAll: ' by ';
		nextPutAll: self author
]

{ #category : #playing }
LlPodcast >> play [

	| node urlString |
	node := self rawDataAt: #enclosure.
	urlString := node attributeAt: 'url'.
	^ urlString asUrl open
]

{ #category : #'magritte-descriptions' }
LlPodcast >> playDescription [
	<magritteActionDescription>
	^ MAActionDescription new
		action: [ :lesson | lesson play ];
		gtIcon: BrGlamorousVectorIcons play;
		isLabelVisible: false;
		shortcut: $c;
		yourself
]

{ #category : #printing }
LlPodcast >> printOn: aStream [

	self printFromDisplayStringOn: aStream
]

{ #category : #private }
LlPodcast >> rawDataAt: aString reader: aValuable ifAbsent: absentBlock [
		
	| el |
	el := self rawData 
		elementAt: aString
		ifAbsent: [ ^ absentBlock value ].
		
	^ aValuable value: el
]

{ #category : #'GT Views' }
LlPodcast >> rawDataGtViewFor: aView context: aContext do: aBlock [
	"If you want to customize the view (e.g. reload latest data via API on update button), send this message from your view method"
	
	| result |
	result := aView forward
		title: 'XML';
		priority: 75;
		object: [ self rawData ];
		view: #gtItemsFor:;
		inspectButtonFor: [ self rawData ].
		
	aBlock value: result.
	
	^ result
]

{ #category : #accessing }
LlPodcast >> title [
	
	^ self 
		rawDataAt: #title
		reader: #contentString
]
