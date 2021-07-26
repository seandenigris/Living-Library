Class {
	#name : #LlDiskImageStatus,
	#superclass : #Announcement,
	#instVars : [
		'completionPercentage'
	],
	#category : #'LivingLibrary-Support'
}

{ #category : #'as yet unclassified' }
LlDiskImageStatus class >> completionPercentage: aNumber [

	^ self new setCompletionPercentage: aNumber.
]

{ #category : #'as yet unclassified' }
LlDiskImageStatus >> completionPercentage [

	^ completionPercentage.
]

{ #category : #'as yet unclassified' }
LlDiskImageStatus >> setCompletionPercentage: aNumber [

	completionPercentage := aNumber.
	^ self.
]
