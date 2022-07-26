Class {
	#name : #LlYouTubeUrl,
	#superclass : #LlVideoUrl,
	#category : #'LivingLibrary-URLs, Custom'
}

{ #category : #accessing }
LlYouTubeUrl >> id [
	^ self query at: #v
]
