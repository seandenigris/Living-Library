Trait {
	#name : 'LlTLibraryItem',
	#category : 'LivingLibrary-Support'
}

{ #category : 'adding' }
LlTLibraryItem >> addToLibraryCopy: anObject [
	anObject work: self.
	^ self library addCopy: anObject of: self
]
