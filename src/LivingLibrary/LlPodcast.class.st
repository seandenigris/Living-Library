Class {
	#name : 'LlPodcast',
	#superclass : 'Object',
	#traits : 'PeTRawDataHolder - {#rawDataAt:reader:ifAbsent:}',
	#classTraits : 'PeTRawDataHolder classTrait',
	#category : 'LivingLibrary',
	#package : 'LivingLibrary'
}

{ #category : 'instance creation' }
LlPodcast class >> fromXml: aXMLElement [ 

	^ self new
		rawData: aXMLElement;
		yourself
]

{ #category : 'accessing' }
LlPodcast >> author [
	
	^ self 
		rawDataAt: #author
		reader: #contentString
]

{ #category : 'printing' }
LlPodcast >> displayStringOn: aStream [

	aStream
		nextPutAll: self title surroundedByDoubleQuotes;
		nextPutAll: ' by ';
		nextPutAll: self author
]

{ #category : 'playing' }
LlPodcast >> play [

	| node urlString |
	node := self rawDataAt: #enclosure.
	urlString := node attributeAt: 'url'.
	^ urlString asUrl open
]

{ #category : 'magritte-descriptions' }
LlPodcast >> playDescription [
	<magritteActionDescription>
	^ MAActionDescription new
		action: [ :lesson | lesson play ];
		gtIcon: BrGlamorousVectorIcons play;
		isLabelVisible: false;
		shortcut: $c;
		yourself
]

{ #category : 'printing' }
LlPodcast >> printOn: aStream [

	self printFromDisplayStringOn: aStream
]

{ #category : 'private' }
LlPodcast >> rawDataAt: aString reader: aValuable ifAbsent: absentBlock [
		
	^ self rawDataXmlAt: aString reader: aValuable ifAbsent: absentBlock
]

{ #category : 'accessing' }
LlPodcast >> rawDataGtViewFor: aView context: aContext do: aBlock [

	^ self rawDataXmlGtViewFor: aView context: aContext do: aBlock
]

{ #category : 'accessing' }
LlPodcast >> title [
	
	^ self 
		rawDataAt: #title
		reader: #contentString
]
