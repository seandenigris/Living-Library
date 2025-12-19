Class {
	#name : 'LlCalibreLocation',
	#superclass : 'Object',
	#instVars : [
		'resource',
		'location'
	],
	#category : 'LivingLibrary-Calibre',
	#package : 'LivingLibrary',
	#tag : 'Calibre'
}

{ #category : 'examples' }
LlCalibreLocation class >> example [
	<gtExample>

	| location resource |
	^ self
		given: [ 
			location := 'epubcfi(/64/2/4[x9780698161863_EPUB]/8/2:65)'.
			resource := LlCalibreResource example ]
		when: [ 
			self new
				resource: resource;
				location: location;
				yourself ]
		then: [ :result |
			 | url |
			 url := 'calibre://view-book/_/{workID}/{format}?open_at={location}'
			 	format: {
			 		#workID -> resource workID.
			 		#format -> resource format calibreName.
			 		#location -> location } asDictionary.
			 result url should equal: url asUrl ]
]

{ #category : 'accessing' }
LlCalibreLocation >> location [

	^ location
]

{ #category : 'accessing' }
LlCalibreLocation >> location: anObject [

	location := anObject
]

{ #category : 'accessing' }
LlCalibreLocation >> present [
	^ self url open
]

{ #category : 'accessing' }
LlCalibreLocation >> resource [

	^ resource
]

{ #category : 'accessing' }
LlCalibreLocation >> resource: anObject [

	resource := anObject
]

{ #category : 'accessing' }
LlCalibreLocation >> url [
	^ self resource urlForLocation: self location
]
