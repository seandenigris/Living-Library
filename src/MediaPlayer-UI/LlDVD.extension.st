Extension { #name : #LlDVD }

{ #category : #'*mediaplayer-ui' }
LlDVD >> asMorph [

	^ DVDMorph on: self.
]

{ #category : #'*mediaplayer-ui' }
LlDVD >> openAsMorph [

	^ DVDMorph openOn: self.
]
