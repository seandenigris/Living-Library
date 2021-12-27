Class {
	#name : #LlYouTubeUrl,
	#superclass : #LlVideoUrl,
	#category : #LivingLibrary
}

{ #category : #accessing }
LlYouTubeUrl >> id [
	^ self query at: #v
]
