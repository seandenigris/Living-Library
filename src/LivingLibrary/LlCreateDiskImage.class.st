Class {
	#name : #LlCreateDiskImage,
	#superclass : #Object,
	#instVars : [
		'completionPercentage',
		'statusSubscriber',
		'hdiutil',
		'updateBlock',
		'deviceFile',
		'target',
		'cancelBlock'
	],
	#category : 'LivingLibrary-Support'
}

{ #category : #'as yet unclassified' }
LlCreateDiskImage class >> from: deviceFile to: target updating: anObject [
	"deviceFile - an FSReference to e.g. /dev/disk3
	 target - an FSReference where the image will be created
	anObject - a block that will receive ???"
	
	^ self new setDeviceFile: deviceFile target: target subscriber: anObject.
]

{ #category : #'as yet unclassified' }
LlCreateDiskImage class >> from: deviceFile to: target updating: aBlock cancelIf: cancelPredicate [
	"deviceFile - an FSReference to e.g. /dev/disk3
	 target - an FSReference where the image will be created
	aBlock - a block that will receive DiskImageStatus announcements"
	
	^ self new setDeviceFile: deviceFile target: target subscriber: aBlock cancelPredicate: cancelPredicate.
]

{ #category : #private }
LlCreateDiskImage >> execute [

	hdiutil := Hdiutil createImageOf: deviceFile at: target.
	hdiutil inspect.
	[ hdiutil isComplete ] whileFalse: [
		self shouldCancel ifTrue: [
			hdiutil cancel.
			^ self ].
		self updateStatus.
		(Delay forSeconds: 1) wait ]
]

{ #category : #private }
LlCreateDiskImage >> setDeviceFile: sourceReference target: targetReference subscriber: anObject [

	completionPercentage := 0.
	deviceFile := sourceReference.
	target := targetReference.
	updateBlock := anObject. "self announcer on: DiskImageStatus do: [ :a | anObject update: a ]"
	self execute.
	^ self.
]

{ #category : #private }
LlCreateDiskImage >> setDeviceFile: sourceReference target: targetReferene subscriber: aBlock cancelPredicate: cancelPredicate [

	completionPercentage := 0.
	deviceFile := sourceReference.
	target := targetReferene.
	updateBlock := aBlock.
	cancelBlock := cancelPredicate.
	self execute.
	^ self.
]

{ #category : #'as yet unclassified' }
LlCreateDiskImage >> shouldCancel [

	^ updateBlock shouldCancel.
]

{ #category : #private }
LlCreateDiskImage >> updateStatus [

	Transcript show: hdiutil completionPercentage; cr.
	updateBlock completionPercentage: hdiutil completionPercentage.
]
