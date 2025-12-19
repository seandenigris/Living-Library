Class {
	#name : 'LlVimeoUrl',
	#superclass : 'LlVideoUrl',
	#category : 'LivingLibrary-URLs, Custom',
	#package : 'LivingLibrary',
	#tag : 'URLs, Custom'
}

{ #category : 'accessing' }
LlVimeoUrl >> id [
	^ self pathSegments second asNumber
]
