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

{ #category : 'accessing' }
LlWebPageWork >> html [
	^ html
]

{ #category : 'accessing' }
LlWebPageWork >> html: anObject [
	html := anObject
]

{ #category : 'as yet unclassified' }
LlWebPageWork >> htmlSave [

	html := self webPage source import
]

{ #category : 'as yet unclassified' }
LlWebPageWork >> webPage [

	| page |
	page := CwSafari reference pageAtUrl: self url.
	page waitForDocumentToLoad.
	^ page
]
