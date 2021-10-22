Extension { #name : #RlVideo }

{ #category : #'*LivingLibrary' }
RlVideo >> llNewScreencast [
	| timeParser filenameParser |
	timeParser := (#digit asPParser plus flatten delimitedBy: $. asPParser), #any asPParser plus flatten ==> [ :n | Time fromString: n first first, ':', n first third, ':', n first fifth, n second  ].
	filenameParser := 'Screen Recording ' asPParser, (#space asPParser negate plus flatten ==> #asDate), ' at ' asPParser, timeParser ==> [ :n | DateAndTime date: n second time: n fourth ].
	^ super newWork
		propertyAt: #publicationTimestamp put: (filenameParser parse: self file base);
		type: #Screencast;
		yourself
]

{ #category : #'*LivingLibrary' }
RlVideo >> newWork [
	^ super newWork
		type: #Video;
		yourself
]
