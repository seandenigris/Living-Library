Class {
	#name : #LlVimeoUrl,
	#superclass : #LlVideoUrl,
	#category : #LivingLibrary
}

{ #category : #accessing }
LlVimeoUrl >> id [
	^ self pathSegments second asNumber
]
