Extension { #name : 'MpRelatableEntity' }

{ #category : '*LivingLibrary' }
MpRelatableEntity >> llAsCollection [
	^ OrderedCollection with: self
]

{ #category : '*LivingLibrary' }
MpRelatableEntity >> worksGtViewOn: aView [
	<gtView>

	| works |
	works := self library works select: [ :w | w authors includes: self ].
	works ifEmpty: [ ^ aView empty ].
	
	^ aView list
		title: 'Works' translated;
		priority: 60;
		items: [ works ];
		actionUpdateButton
]
