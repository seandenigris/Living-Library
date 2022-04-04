Extension { #name : #RlMp3 }

{ #category : #'*LivingLibrary' }
RlMp3 >> newPlayer [
	^ (LlMediaPlayer on: self)
		driver: LlPythonMpv new;
		yourself
]

{ #category : #'*LivingLibrary' }
RlMp3 >> playIn: container [
	container play
]
