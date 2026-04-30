Class {
	#name : 'LlDomElementLocator',
	#superclass : 'Object',
	#instVars : [
		'querySelector',
		'page'
	],
	#category : 'LivingLibrary-Web Driving-AppleScript',
	#package : 'LivingLibrary',
	#tag : 'Web Driving-AppleScript'
}

{ #category : 'accessing' }
LlDomElementLocator class >> querySelector: aString in: page [
	^ self new
		querySelector: aString;
		page: page;
		yourself
]

{ #category : 'as yet unclassified' }
LlDomElementLocator >> doJavaScript: aString [
	^ self selfEvaluate: aString.
]

{ #category : 'accessing' }
LlDomElementLocator >> exists [
	| js |
	js := (SuJSScript queryingSelector + ' !== null')
		argumentAt: #selectors put: self querySelector surroundedByDoubleQuotes;
		yourself.

	^ self page doJavascript: js
]

{ #category : 'accessing' }
LlDomElementLocator >> getAttribute: aString [
	^ self selfEvaluate: 'getAttribute(', aString surroundedBySingleQuotes, ')'
]

{ #category : 'as yet unclassified' }
LlDomElementLocator >> innerHTML [

	^ RlHTML fromString: (self selfEvaluate: 'innerHTML')
]

{ #category : 'accessing' }
LlDomElementLocator >> page [

	^ page
]

{ #category : 'accessing' }
LlDomElementLocator >> page: anObject [

	page := anObject
]

{ #category : 'accessing' }
LlDomElementLocator >> querySelector [
	^ querySelector
]

{ #category : 'as yet unclassified' }
LlDomElementLocator >> querySelector: aString [ 
	querySelector := aString
]

{ #category : 'accessing' }
LlDomElementLocator >> selfEvaluate: aString [ 
	| js |
	js := (SuJSScript queryingSelector -> aString)
		argumentAt: #selectors put: self querySelector surroundedByDoubleQuotes;
		yourself.

	^ self page doJavascript: js
]

{ #category : 'as yet unclassified' }
LlDomElementLocator >> textContent [

	^ self selfEvaluate: 'textContent'
]
