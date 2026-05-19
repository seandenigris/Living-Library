Extension { #name : 'QuLeTranscriptLineSnippetViewModel' }

{ #category : '*LivingLibrary' }
QuLeTranscriptLineSnippetViewModel >> videoClipGtActionFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Create clip';
		icon: BrGlamorousVectorIcons performance;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 10;
		action: [ :aButton :aSnippetElement | 
			aSnippetElement phlow spawnObject: aSnippetElement snippet asClip ]
]
