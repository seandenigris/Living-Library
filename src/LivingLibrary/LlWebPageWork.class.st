Class {
	#name : 'LlWebPageWork',
	#superclass : 'LlAuthoredWork',
	#instVars : [
		'html'
	],
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'accessing' }
LlWebPageWork class >> baseUrl [

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
LlWebPageWork >> delete [

	html ifNotNil: [ html delete ]
]

{ #category : 'accessing' }
LlWebPageWork >> html [
	^ html
]

{ #category : 'accessing' }
LlWebPageWork >> html: anObject [
	html := anObject
]

{ #category : 'as yet unclassified' }
LlWebPageWork >> htmlEnsured [

	html ifNil: [ self htmlSave ].
	^ html
]

{ #category : 'as yet unclassified' }
LlWebPageWork >> htmlSave [

	html := self webPage source import
]

{ #category : 'as yet unclassified' }
LlWebPageWork >> title [

	^ title ifNil: [ title := self titleFromHtml ].
]

{ #category : 'accessing' }
LlWebPageWork >> titleFromHtml [
	"Subclasses should override if a title is scrapable"

	^ ''
]

{ #category : 'as yet unclassified' }
LlWebPageWork >> view [

	self url open
]

{ #category : 'accessing' }
LlWebPageWork >> webPage [

	| page |
	page := CwSafari reference pageAtUrl: self url.
	page waitForDocumentToLoad.
	^ page
]
