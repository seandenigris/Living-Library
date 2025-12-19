Extension { #name : 'QuCitation' }

{ #category : '*LivingLibrary' }
QuCitation >> llSourceDescription: aDescription [
	<magritteDescription: #sourceDescription>
	
	^ aDescription
		classes: LlAuthoredWork withAllSubclasses; 
		yourself
]
