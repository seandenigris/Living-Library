Class {
	#name : 'LlUnknownDiskInfo',
	#superclass : 'Object',
	#category : 'LivingLibrary-Support',
	#package : 'LivingLibrary',
	#tag : 'Support'
}

{ #category : 'as yet unclassified' }
LlUnknownDiskInfo >> = diskInfo [

	^ true.
]

{ #category : 'as yet unclassified' }
LlUnknownDiskInfo >> ifUnknown: aBlock [

	^ aBlock value.
]

{ #category : 'as yet unclassified' }
LlUnknownDiskInfo >> rawOutput [
	self shouldBeImplemented.
]
