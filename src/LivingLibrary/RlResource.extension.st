Extension { #name : #RlResource }

{ #category : #'*LivingLibrary' }
RlResource >> newWork [
	^ LlAuthoredWork new
		title: self file base;
		yourself
]

{ #category : #'*LivingLibrary' }
RlResource >> work [
	^ self propertyAt: #llWork ifAbsent: [ nil ]
]

{ #category : #'*LivingLibrary' }
RlResource >> work: anLlAuthoredWork [
	self propertyAt: #llWork put: anLlAuthoredWork
]
