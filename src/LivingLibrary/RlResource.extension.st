Extension { #name : #RlResource }

{ #category : #'*LivingLibrary' }
RlResource >> work [
	^ self propertyAt: #llWork ifAbsent: [ nil ]
]

{ #category : #'*LivingLibrary' }
RlResource >> work: anLlAuthoredWork [
	self propertyAt: #llWork put: anLlAuthoredWork
]
