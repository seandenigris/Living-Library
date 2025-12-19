Class {
	#name : 'LlYouTubeUrl',
	#superclass : 'LlVideoUrl',
	#category : 'LivingLibrary-URLs, Custom',
	#package : 'LivingLibrary',
	#tag : 'URLs, Custom'
}

{ #category : 'accessing' }
LlYouTubeUrl class >> exampleParsingInput: urlString shouldSetID: idString [
	<gtExample>
	^ self
		given: [ urlString ]
		when: [ :str | self parser parse: str ]
		then: [ :video | video id should equal: idString ] 
]

{ #category : 'accessing' }
LlYouTubeUrl class >> exampleStringInputs [
	
	^ {
		 'https://youtu.be/A0TafHXszg' -> 'A0TafHXszg'.
		 'https://youtube.com/embed/A0TafHXszg?loop=1' -> 'A0TafHXszg'.
		 'https://www.youtube.com/watch?v=QOe3FA4wJcQ' -> 'QOe3FA4wJcQ' }
]

{ #category : 'accessing' }
LlYouTubeUrl class >> fromString: aString [
	| url id hasIdInFile |
	url := aString asUrl.
	hasIdInFile := #('embed' "embedded" 'live') includes: url pathSegments first.	
	id := hasIdInFile
			ifTrue: [ id := url file ]
			ifFalse: [ url host = 'youtu.be'"shortened" 
					ifTrue: [ id := url pathSegments first ]
					ifFalse: [ url queryAt: #v "normal" ] ].
	^ (super fromString: 'https://www.youtube.com/watch') ? (#v -> id)
]

{ #category : 'accessing' }
LlYouTubeUrl class >> fromStringExample [
	<gtExample>
	
	| result |
	
	self exampleStringInputs do: [ :assoc |
		result := self fromString: assoc key.
		result id should equal: assoc value ].
		
	^ result
]

{ #category : 'accessing' }
LlYouTubeUrl class >> peCanHandleFromString: aString [

	[ self fromString: aString ]
		on: Error
		do: [ ^ false ].
		
	^ true
]

{ #category : 'accessing' }
LlYouTubeUrl class >> peCanHandleFromStringExample [
	<gtExample>
	
	| result |
	
	self exampleStringInputs do: [ :assoc |
		result := self peCanHandleFromString: assoc key.
		result should beTrue ].
		
	result := self peCanHandleFromString: 'https://google.com'.
	result should beFalse.
]

{ #category : 'accessing' }
LlYouTubeUrl class >> peExternalDropServicesFor: anObject [
	<peDropService>
	
	(self peCanHandleFromString: anObject) ifFalse: [ {} ].
	
	^ {
		SimpleServiceEntry 
			provider: self 
			label: 'YouTube URL, new instance'
			selector: #fromString:
			description: ''
			buttonLabel: '+' }
]

{ #category : 'accessing' }
LlYouTubeUrl >> asVideo [
	^ LlYouTubeVideo new
		id: self id;
		yourself.
]

{ #category : 'accessing' }
LlYouTubeUrl >> id [
	^ self query at: #v
]
