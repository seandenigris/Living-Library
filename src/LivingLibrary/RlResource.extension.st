Extension { #name : 'RlResource' }

{ #category : '*LivingLibrary' }
RlResource class >> calibreName [
	^ self typeName asUppercase
]

{ #category : '*LivingLibrary' }
RlResource >> newPlayer [

	^ LlNullMediaPlayer new
]

{ #category : '*LivingLibrary' }
RlResource >> newWork [
	^ LlAuthoredWork new
		title: self file base;
		yourself
]

{ #category : '*LivingLibrary' }
RlResource >> work [
	^ self propertyAt: #llWork ifAbsent: [ nil ]
]

{ #category : '*LivingLibrary' }
RlResource >> work: anLlAuthoredWork [
	self propertyAt: #llWork putRemovingNil: anLlAuthoredWork
]

{ #category : '*LivingLibrary' }
RlResource >> workEnsured [

	| work |
	work := self work ifNil: [ LlAuthoredWork titled: self workTitleDefault ].
	self library ifNil: [ self import ].
	LlLibrary uniqueInstance addCopy: self import of: work.
	^ work
]

{ #category : '*LivingLibrary' }
RlResource >> workTitleDefault [
	^ self file base
]
