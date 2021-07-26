Class {
	#name : #FlickrApiMethod,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'LivingLibrary-Flickr'
}

{ #category : #'instance creation' }
FlickrApiMethod class >> named: aString [

	^ self new
		name: aString;
		yourself
]

{ #category : #'as yet unclassified' }
FlickrApiMethod >> info [

	^ Flickr new
		set: 'method_name' to: self name;
		get: 'flickr.reflection.getMethodInfo'
]

{ #category : #accessing }
FlickrApiMethod >> name [
	^ name
]

{ #category : #accessing }
FlickrApiMethod >> name: anObject [
	name := anObject
]

{ #category : #printing }
FlickrApiMethod >> printOn: aStream [

	name
		ifNotNil: [ aStream nextPutAll: name ]
		ifNil: [ super printOn: aStream ]
]
