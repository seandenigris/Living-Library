Class {
	#name : #LlVideoUrl,
	#superclass : #ZnUrl,
	#category : #'LivingLibrary-URLs, Custom'
}

{ #category : #accessing }
LlVideoUrl >> autoplay: aBoolean [
	"https://vimeo.zendesk.com/hc/en-us/articles/115004485728-Autoplaying-and-looping-embedded-videos"

	aBoolean
		ifTrue: [ self queryAt: 'autoplay' put: 1 ]
		ifFalse: [ self queryRemoveKey: 'autoplay' ].
]
