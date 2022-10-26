Class {
	#name : #LlYouTubeUrl,
	#superclass : #LlVideoUrl,
	#category : #'LivingLibrary-URLs, Custom'
}

{ #category : #accessing }
LlYouTubeUrl class >> exampleParsingInput: urlString shouldSetID: idString [
	<gtExample>
	^ self
		given: [ urlString ]
		when: [ :str | self parser parse: str ]
		then: [ :video | video id should equal: idString ] 
]

{ #category : #accessing }
LlYouTubeUrl class >> parser [
	| root id queryKey queryValue queryAssociation query embedded standard |
	
	root := 'https://youtube.com/' asPParser.
	id := #word asPParser plus flatten.
	queryKey := $= asPParser negate plus flatten.
	queryValue := $& asPParser negate plus flatten.
	queryAssociation := queryKey, $= asPParser, queryValue ==> [ :n | n first -> n last ].
	query := $? asPParser, (queryAssociation separatedBy: $& asPParser).
	embedded := root, 'embed/' asPParser, id, query optional ==> #third.
	standard := root, 'watch' asPParser, query ==> [ :nodes | 
		| idAssoc |
		idAssoc := nodes third detect: [ :assoc | assoc key = 'v' ].
		idAssoc value ].
	^ embedded, standard ==> [ :idString | 
		(LlYouTubeUrl fromString: 'https://www.youtube.com/watch') ? (#v -> idString) ]
]

{ #category : #accessing }
LlYouTubeUrl class >> parserExample [
	<gtExample>
	"self exampleParsingInput: 'https://youtu.be/A0TafHXszg' shouldSetID: 'A0TafHXszg'."
	self exampleParsingInput: 'https://youtube.com/embed/A0TafHXszg?loop=1' shouldSetID: 'A0TafHXszg'.
	^ self exampleParsingInput: 'https://www.youtube.com/watch?v=QOe3FA4wJcQ' shouldSetID: 'QOe3FA4wJcQ'
]

{ #category : #accessing }
LlYouTubeUrl >> id [
	^ self query at: #v
]
