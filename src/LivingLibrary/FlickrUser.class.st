Class {
	#name : #FlickrUser,
	#superclass : #Object,
	#instVars : [
		'name',
		'id'
	],
	#category : 'LivingLibrary-Flickr'
}

{ #category : #'as yet unclassified' }
FlickrUser class >> fromUrl: aUrl [

	| response |
	response := Flickr new
		set: 'url' to: aUrl printString;
		get: 'flickr.urls.lookupUser'.
		
	^ self new
		id: ((response data at: 'user') at: 'id');
		name: (((response data at: 'user') at: 'username') at: '_content').
]

{ #category : #'as yet unclassified' }
FlickrUser class >> named: aString [

	^ self new
		name: aString;
		yourself
]

{ #category : #'as yet unclassified' }
FlickrUser >> id [

	| response |
	id ifNotNil: [ ^ id ].
	
	response := Flickr new
		set: 'username' to: self name;
		get: 'flickr.people.findByUsername'.
	^ id := (response data at: 'user') at: 'id'
]

{ #category : #'as yet unclassified' }
FlickrUser >> id: aString [
	
	id := aString
]

{ #category : #private }
FlickrUser >> name [
	^ name
]

{ #category : #private }
FlickrUser >> name: aString [ 
	name := aString
]
