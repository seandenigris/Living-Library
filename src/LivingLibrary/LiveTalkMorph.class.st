Class {
	#name : #LiveTalkMorph,
	#superclass : #Object,
	#category : 'LivingLibrary-UI'
}

{ #category : #'as yet unclassified' }
LiveTalkMorph class >> open [
	"self open"

	^ self new open.
]

{ #category : #'as yet unclassified' }
LiveTalkMorph >> open [
	"self open"

	| builder morph |
	builder := UITheme builder.
	morph := (builder newColumn: {
		builder newRow: {
			builder newLabel: 'Title: '.
			builder newAutoAcceptTextEntryFor: (ValueHolder new contents: '') getText: nil setText: #contents: getEnabled: nil help: ''.
			builder newLabel: 'Title: '.
			builder newAutoAcceptTextEntryFor: (ValueHolder new contents: '') getText: nil setText: #contents: getEnabled: nil help: '' }.
		builder newOKButtonFor: self } )
		cellInset: 15;
		layoutInset: 15.
		
	(morph openInWindowLabeled: 'Talk') extent: 400@330.
]
