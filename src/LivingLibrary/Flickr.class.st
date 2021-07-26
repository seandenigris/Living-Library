"
""Global setup""
Flickr
	userID: myUserID;
	apiKey: myApiKey.

""Generic usage""	
Flickr new
	set: 'photo_id' to: '4975793876';
	get: 'flickr.photos.getInfo'.

""Smalltalk model""	
(FlickrUser named: 'Rebel Shea') id.

(FlickrUser fromUrl: 'https://www.flickr.com/photos/rebelshea/4975793876' asUrl) id.
"
Class {
	#name : #Flickr,
	#superclass : #Object,
	#instVars : [
		'userID',
		'apiKey',
		'format',
		'client',
		'arguments'
	],
	#classInstVars : [
		'userID',
		'apiKey'
	],
	#category : #'LivingLibrary-Flickr'
}

{ #category : #accessing }
Flickr class >> apiKey [
	^ apiKey
]

{ #category : #accessing }
Flickr class >> apiKey: anObject [
	apiKey := anObject
]

{ #category : #accessing }
Flickr class >> userID [
	^ userID
]

{ #category : #accessing }
Flickr class >> userID: anObject [
	userID := anObject
]

{ #category : #private }
Flickr >> arguments [

	^ arguments ifNil: [ arguments := Dictionary new ]
]

{ #category : #'as yet unclassified' }
Flickr >> baseUrl [

	^ 'https://api.flickr.com/services/rest/?' asUrl
]

{ #category : #accessing }
Flickr >> format [
	^ format ifNil: [ format := 'json' ]
]

{ #category : #accessing }
Flickr >> format: anObject [
	format := anObject
]

{ #category : #'as yet unclassified' }
Flickr >> get: methodString [ 

	| url jsonString |
	url := self baseUrl
		queryAt: 'api_key' put: self class apiKey;
		queryAt: 'user_id' put: self class userID;
		queryAt: 'method' put: methodString;
		queryAt: 'format' put: self format;
		queryAt: 'nojsoncallback' put: 1.
	self arguments keysAndValuesDo: [ :k :v | url queryAt: k put: v ].

	jsonString := ZnClient new
		url: url;
		get.
		
	^ (NeoJSONReader on: jsonString readStream) nextAs: FlickrApiResponse
]

{ #category : #'as yet unclassified' }
Flickr >> methods [

	| response |
	response := self get: 'flickr.reflection.getMethods'.
	^ ((response data at: 'methods') at: 'method') collect: [ :e | FlickrApiMethod named: (e at: '_content') ]
]

{ #category : #'as yet unclassified' }
Flickr >> set: keyString to: valueString [

	self arguments at: keyString put: valueString
]
