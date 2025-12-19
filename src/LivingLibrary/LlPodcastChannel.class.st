Class {
	#name : 'LlPodcastChannel',
	#superclass : 'Object',
	#traits : 'PeTRawDataHolder - {#rawDataAt:reader:ifAbsent:}',
	#classTraits : 'PeTRawDataHolder classTrait',
	#category : 'LivingLibrary',
	#package : 'LivingLibrary'
}

{ #category : 'accessing' }
LlPodcastChannel class >> fromRssUrl: aUrl [

	^ self new
		channelXml: (aUrl asRlResource document / 'rss' / 'channel') first;
		yourself
]

{ #category : 'accessing' }
LlPodcastChannel >> channelXml [
	^ self rawData
]

{ #category : 'accessing' }
LlPodcastChannel >> channelXml: anObject [
	self rawData: anObject
]

{ #category : 'as yet unclassified' }
LlPodcastChannel >> description [

	^ self 
		rawDataAt: 'description'
		reader: #contentString
]

{ #category : 'as yet unclassified' }
LlPodcastChannel >> episodes [

	^ (self channelXml / #item) 
		collect: [ :e | LlPodcast fromXml: e ]
		as: OrderedCollection
]

{ #category : 'as yet unclassified' }
LlPodcastChannel >> episodesGtViewFor: aView [
	<gtView>

	^ aView list
		title: 'Episodes';
		priority: 25;
		items: [ self episodes ];
		yourself
]

{ #category : 'as yet unclassified' }
LlPodcastChannel >> rawDataAt: aString reader: aValuable ifAbsent: absentBlock [
		
	| el |
	el := self rawData 
		elementAt: aString
		ifAbsent: [ ^ absentBlock value ].
		
	^ aValuable value: el
]

{ #category : 'accessing' }
LlPodcastChannel >> rawDataGtViewFor: aView context: aContext do: aBlock [
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

{ #category : 'as yet unclassified' }
LlPodcastChannel >> rssUrl [

	^ self 
		rawDataAt: 'atom:link'
		reader: [ :node | (node attributeAt: #href) asUrl ]
]

{ #category : 'as yet unclassified' }
LlPodcastChannel >> showUrl [

	^ self 
		rawDataAt: 'link'
		reader: [ :node | node contentString asUrl ]
]

{ #category : 'accessing' }
LlPodcastChannel >> title [

	^ self 
		rawDataAt: 'title'
		reader: #contentString
]
