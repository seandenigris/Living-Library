Extension { #name : 'MpRelatableEntity' }

{ #category : '*LivingLibrary' }
MpRelatableEntity >> llAsCollection [
	^ OrderedCollection with: self
]

{ #category : '*LivingLibrary' }
MpRelatableEntity >> worksGtViewOn: aView [
	<gtView>

	^ self library class
		works: [ self library rootWorks select: [ :w | 
			w authors includes: self ] ]
		ofKind: self library workClass
		gtViewOn: aView 
		title: 'Works'
		priority: 60
]
