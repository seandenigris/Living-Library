Extension { #name : #LePage }

{ #category : #'*LivingLibrary' }
LePage >> asLlLepiterPage [

	^ LlLepiterPage new
		databaseId: self database uuid asString36;
		id: self uid asString36;
		yourself
]
