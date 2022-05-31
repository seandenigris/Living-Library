Extension { #name : #MpRelatableEntity }

{ #category : #'*LivingLibrary' }
MpRelatableEntity >> gtViewWorksOn: aView [
	<gtView>

	| works |
	works := LlLibrary uniqueInstance works select: [ :w | w authors includes: self ].
	works ifEmpty: [ ^ aView empty ].
	
	^ aView list
		title: 'Works' translated;
		priority: 60;
		items: [ works ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #'*LivingLibrary' }
MpRelatableEntity >> llAsCollection [
	^ OrderedCollection with: self
]
