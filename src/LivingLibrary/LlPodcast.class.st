Class {
	#name : #LlPodcast,
	#superclass : #Object,
	#traits : 'PeTRawDataHolder - {#rawDataAt:reader:ifAbsent:}',
	#classTraits : 'PeTRawDataHolder classTrait',
	#category : #LivingLibrary
}

{ #category : #accessing }
LlPodcast class >> fromRssUrl: aUrl [

	^ self new
		channelXml: (aUrl asRlResource document / 'rss' / 'channel') first;
		yourself
]

{ #category : #accessing }
LlPodcast >> channelXml [
	^ self rawData
]

{ #category : #accessing }
LlPodcast >> channelXml: anObject [
	self rawData: anObject
]

{ #category : #'as yet unclassified' }
LlPodcast >> description [

	^ self 
		rawDataAt: 'description'
		reader: #contentString
]

{ #category : #'as yet unclassified' }
LlPodcast >> episodes [

	^ self channelXml / #item
]

{ #category : #'as yet unclassified' }
LlPodcast >> rawDataAt: aString reader: aValuable ifAbsent: absentBlock [
		
	| el |
	el := self rawData 
		elementAt: aString
		ifAbsent: [ ^ absentBlock value ].
		
	^ aValuable value: el
]

{ #category : #accessing }
LlPodcast >> rawDataGtViewFor: aView context: aContext do: aBlock [
	"If you want to customize the view (e.g. reload latest data via API on update button), send this message from your view method"
	
	| result |
	result := aView forward
		title: 'XML';
		priority: 75;
		object: [ self channelXml ];
		view: #gtItemsFor:;
		inspectButtonFor: [ self rawData ].
		
	aBlock value: result.
	
	^ result
]

{ #category : #'as yet unclassified' }
LlPodcast >> rssUrl [

	^ self 
		rawDataAt: 'atom:link'
		reader: [ :node | (node attributeAt: #href) asUrl ]
]

{ #category : #'as yet unclassified' }
LlPodcast >> showUrl [

	^ self 
		rawDataAt: 'link'
		reader: [ :node | node contentString asUrl ]
]

{ #category : #accessing }
LlPodcast >> title [

	^ self 
		rawDataAt: 'title'
		reader: #contentString
]
