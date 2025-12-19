Class {
	#name : 'CcPhoto',
	#superclass : 'Object',
	#instVars : [
		'title',
		'url',
		'owner',
		'license'
	],
	#category : 'LivingLibrary-Licensing',
	#package : 'LivingLibrary',
	#tag : 'Licensing'
}

{ #category : 'private' }
CcPhoto >> fillAttributionTemplate: expectedAttributionTemplate [
	^ expectedAttributionTemplate
		format: {		
			#photoTitle -> self title.
			#photoUrl -> self url.
			#ownerUsername -> self ownerUsername.
			#profileUrl -> self profileUrl.
			#licenseName -> self license linkText.
			#licenseDeedUrl -> self license deedURL } asDictionary
]

{ #category : 'attributing' }
CcPhoto >> htmlAttribution [
	^ self fillAttributionTemplate: '"<a href="{photoUrl}">{photoTitle}</a>" by <a href="{profileUrl}">{ownerUsername}</a> is licensed under <a href="{licenseDeedUrl}">{licenseName}</a>'
]

{ #category : 'accessing' }
CcPhoto >> license [
	^ license
]

{ #category : 'accessing' }
CcPhoto >> license: anObject [
	license := anObject
]

{ #category : 'accessing' }
CcPhoto >> owner [
	^ owner
]

{ #category : 'accessing' }
CcPhoto >> owner: anObject [
	owner := anObject
]

{ #category : 'accessing' }
CcPhoto >> ownerUsername [

	^ owner
]

{ #category : 'attributing' }
CcPhoto >> plainTextAttribution [

	^ self fillAttributionTemplate: '"{photoTitle}" ({photoUrl}) by {ownerUsername} ({profileUrl}) is licensed under {licenseName} ({licenseDeedUrl})'.
]

{ #category : 'accessing' }
CcPhoto >> profileUrl [
	^ url copy
			clearPath;
			addPathSegments: (url pathSegments first: 2);
			yourself
]

{ #category : 'accessing' }
CcPhoto >> title [
	^ title
]

{ #category : 'accessing' }
CcPhoto >> title: anObject [
	title := anObject
]

{ #category : 'accessing' }
CcPhoto >> url [
	^ url
]

{ #category : 'accessing' }
CcPhoto >> url: anObject [
	url := anObject
]
