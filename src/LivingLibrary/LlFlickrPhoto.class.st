"
Is a Flickr Photo a library item? Or a copy/item source? Flickr seems to typically serve [several formats/resolutions](https://www.flickr.com/photos/nickefford/6446227373/sizes/o/), although we could just consider the [original](https://live.staticflickr.com/7001/6446227373_67346a63fe_o.jpg) for now for simplicity sake.
"
Class {
	#name : #LlFlickrPhoto,
	#superclass : #LlWebResource,
	#instVars : [
		'id'
	],
	#category : #'LivingLibrary-Flickr'
}

{ #category : #examples }
LlFlickrPhoto class >> example [
	<gtExample>
	^ self new
		title: 'Creative Commons 10th Birthday Celebration San Francisco';
		author: MpPerson exampleFlickrUser;
		url: 'https://www.flickr.com/photos/sixteenmilesofstring/8256206923/in/set-72157632200936657' asUrl;
		yourself
]

{ #category : #accessing }
LlFlickrPhoto >> asElement [
	^ BlUrlImageElement url: self downloadUrl
]

{ #category : #accessing }
LlFlickrPhoto >> ccAuthorMarkup [
	^ String streamContents: [ :str |
		self authors
			do: [ :e | 
				| flickrURL username |
				username := e propertyAt: #flickrUsername.
				flickrURL := 'https://www.flickr.com/photos/', username, '/'.
				str << '*' << username << '>' << flickrURL << '*'  ]
			separatedBy: [ str space ] ]
]

{ #category : #accessing }
LlFlickrPhoto >> ccTitleMarkup [
	^ '*', self title, '>', url asString, '*'
]

{ #category : #accessing }
LlFlickrPhoto >> downloadUrl [
	| response sizes original |
	response := Flickr new
		set: 'photo_id' to: self id;
		get: 'flickr.photos.getSizes'.
		
	sizes := (response data at: #sizes) at: #size.
	original := sizes detect: [ :dict | (dict at: #label) = 'Original' ].
	^ (original at: 'source') asUrl
]

{ #category : #views }
LlFlickrPhoto >> gtPreviewOn: aView [
	<gtView>
	^ aView pannable
		title: 'Preview';
		priority: 25;
		stencil: [ 
			self asElement
				constraintsDo: [ :c |
					c vertical fitContent.
					c horizontal fitContent ] ];
		yourself
]

{ #category : #accessing }
LlFlickrPhoto >> id [
	^ id
]

{ #category : #accessing }
LlFlickrPhoto >> id: anObject [
	id := anObject
]

{ #category : #accessing }
LlFlickrPhoto >> licenseAttribution [
	^ self work license attributionFor: self
]
