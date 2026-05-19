Extension { #name : 'QuLeTranscriptLineSnippet' }

{ #category : '*LivingLibrary' }
QuLeTranscriptLineSnippet >> asClip [

	^ LlVideoClip
		from: self transcriptable
		startingAt: self position
		andEndingAt: nil.
]
