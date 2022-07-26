Class {
	#name : #LlAppleScriptHtmlElementLocator,
	#superclass : #Object,
	#instVars : [
		'selector',
		'page'
	],
	#category : #'LivingLibrary-Web Driving-AppleScript'
}

{ #category : #accessing }
LlAppleScriptHtmlElementLocator class >> selector: aString in: page [
	^ self new
		selector: aString;
		page: page;
		yourself
]

{ #category : #accessing }
LlAppleScriptHtmlElementLocator >> exists [
	| js |
	js := (SuJSScript queryingSelector + ' !== null')
		argumentAt: #selectors put: self selector surroundedByDoubleQuotes;
		yourself.

	^ self page doJavascript: js
]

{ #category : #accessing }
LlAppleScriptHtmlElementLocator >> getAttribute: aString [
	^ self selfEvaluate: 'getAttribute(', aString surroundedBySingleQuotes, ')'
]

{ #category : #accessing }
LlAppleScriptHtmlElementLocator >> page [

	^ page
]

{ #category : #accessing }
LlAppleScriptHtmlElementLocator >> page: anObject [

	page := anObject
]

{ #category : #accessing }
LlAppleScriptHtmlElementLocator >> selector [
	^ selector
]

{ #category : #'as yet unclassified' }
LlAppleScriptHtmlElementLocator >> selector: aString [ 
	selector := aString
]

{ #category : #accessing }
LlAppleScriptHtmlElementLocator >> selfEvaluate: aString [ 
	| js |
	js := (SuJSScript queryingSelector -> aString)
		argumentAt: #selectors put: self selector surroundedByDoubleQuotes;
		yourself.

	^ self page doJavascript: js
]
