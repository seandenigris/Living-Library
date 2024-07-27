Extension { #name : #RlEmail }

{ #category : #'*LivingLibrary' }
RlEmail >> importWork [

	| work |
	work := LlAuthoredWork titled: self subject.
	LlLibrary uniqueInstance addCopy: self import of: work.
	^ work
]
