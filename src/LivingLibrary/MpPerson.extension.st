Extension { #name : 'MpPerson' }

{ #category : '*LivingLibrary-Core' }
MpPerson >> books [

	^ LlLibrary uniqueInstance works select: [ :e | e authors includes: self ].
]

{ #category : '*LivingLibrary-Core' }
MpPerson >> wrote: bookTitle [

	LlLibrary uniqueInstance beAwareOf: (LlAuthoredWork titled: bookTitle by: self).
]
