Extension { #name : #LeSnippet }

{ #category : #'*LivingLibrary' }
LeSnippet >> asLlLepiterSnippet [

	^ LlLepiterSnippet new
		databaseId: self database uuid asString36;
		id: self uid;
		yourself
]
