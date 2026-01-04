Class {
	#name : 'LlVideoUrl',
	#superclass : 'ZnUrl',
	#category : 'LivingLibrary-URLs, Custom',
	#package : 'LivingLibrary',
	#tag : 'URLs, Custom'
}

{ #category : 'instance creation' }
LlVideoUrl class >> fromString: aString [

	| cls canonical |
	cls := self allSubclasses
			detect: [ :aClass | aClass peCanHandleFromString: aString ]
			ifFound: [ :aClass | aClass ]
			ifNone: [ self ].

	canonical := cls canonicalFromString: aString.
	^ cls newFrom: canonical
]

{ #category : 'accessing' }
LlVideoUrl >> autoplay: aBoolean [
	"https://vimeo.zendesk.com/hc/en-us/articles/115004485728-Autoplaying-and-looping-embedded-videos"

	aBoolean
		ifTrue: [ self queryAt: 'autoplay' put: 1 ]
		ifFalse: [ self queryRemoveKey: 'autoplay' ].
]

{ #category : 'as yet unclassified' }
LlVideoUrl >> canonicalFromString: aString [

	^ aString asUrl
]
