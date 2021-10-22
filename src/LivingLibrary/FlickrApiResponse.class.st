Class {
	#name : #FlickrApiResponse,
	#superclass : #Object,
	#instVars : [
		'status',
		'data'
	],
	#category : 'LivingLibrary-Flickr'
}

{ #category : #'as yet unclassified' }
FlickrApiResponse class >> neoJsonMapping: mapper [
	mapper for: self customDo: [ :mapping |
		mapping decoder: [ :dict | | dataDict |
			dataDict := Dictionary new.
			(dict keys reject: [ :k | k = 'stat']) do: [ :k | dataDict at: k put: (dict at: k) ].
			self new
				status: (dict at: 'stat');
				data: dataDict;
				yourself ] ]
]

{ #category : #accessing }
FlickrApiResponse >> data [
	^ data
]

{ #category : #accessing }
FlickrApiResponse >> data: anObject [
	data := anObject
]

{ #category : #accessing }
FlickrApiResponse >> status [
	^ status
]

{ #category : #accessing }
FlickrApiResponse >> status: anObject [
	status := anObject
]
