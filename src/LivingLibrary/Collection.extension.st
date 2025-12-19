Extension { #name : 'Collection' }

{ #category : '*LivingLibrary' }
Collection >> llAsAuthorCollection [
	^ self
]

{ #category : '*LivingLibrary' }
Collection >> llAsCollection [
	^ self flatCollect: #llAsCollection
]
