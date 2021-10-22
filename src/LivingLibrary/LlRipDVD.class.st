Class {
	#name : #LlRipDVD,
	#superclass : #Object,
	#instVars : [
		'dvd',
		'announcer'
	],
	#category : 'LivingLibrary-Support'
}

{ #category : #'as yet unclassified' }
LlRipDVD class >> on: aDVD [

	^ self new setDVD: aDVD.
]

{ #category : #'as yet unclassified' }
LlRipDVD >> announcer [

	^ announcer ifNil: [ announcer := Announcer new ].
]

{ #category : #'as yet unclassified' }
LlRipDVD >> execute [

	| target command |
	target := FileSystem disk root resolve: '/Users/sean/jjj.mp4'.
	command := HandBrake transcode: dvd deviceFile to: target.
	command execute.
]

{ #category : #'as yet unclassified' }
LlRipDVD >> on: anAnnouncement do: aBlock [

	^ self announcer on: anAnnouncement do: aBlock.
]

{ #category : #'as yet unclassified' }
LlRipDVD >> setDVD: aDVD [

	dvd := aDVD.
	^ self.
]
