Class {
	#name : #LlVimeoUrl,
	#superclass : #LlVideoUrl,
	#category : #'LivingLibrary-URLs, Custom'
}

{ #category : #accessing }
LlVimeoUrl >> id [
	^ self pathSegments second asNumber
]
