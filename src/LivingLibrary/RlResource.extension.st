Extension { #name : #RlResource }

{ #category : #'*LivingLibrary' }
RlResource class >> calibreName [
	^ self typeName asUppercase
]

{ #category : #'*LivingLibrary' }
RlResource >> importWork [

	| work |
	work := LlAuthoredWork titled: self workTitleDefault.
	LlLibrary uniqueInstance addCopy: self import of: work.
	^ work
]

{ #category : #'*LivingLibrary' }
RlResource >> newPlayer [

	^ LlNullMediaPlayer new
]

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
	self propertyAt: #llWork putRemovingNil: anLlAuthoredWork
]

{ #category : #'*LivingLibrary' }
RlResource >> workTitleDefault [
	^ self file base
]
