Trait {
	#name : 'LlTLibraryItem',
	#category : 'LivingLibrary-Support',
	#package : 'LivingLibrary',
	#tag : 'Support'
}

{ #category : 'adding' }
LlTLibraryItem >> libraryAddCopy: anObject [
	anObject work: self.
	^ self library addCopy: anObject of: self
]

{ #category : 'adding' }
LlTLibraryItem >> libraryRemoveCopy: anObject [
	^ self library copy: anObject removeFrom: self
]
