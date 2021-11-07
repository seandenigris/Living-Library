Extension { #name : #String }

{ #category : #'*LivingLibrary' }
String >> llAsCollection [
	^ { MpPerson named: self }
]
