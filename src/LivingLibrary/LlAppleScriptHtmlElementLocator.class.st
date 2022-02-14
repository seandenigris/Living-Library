Class {
	#name : #LlAppleScriptHtmlElementLocator,
	#superclass : #Object,
	#instVars : [
		'selector'
	],
	#category : #LivingLibrary
}

{ #category : #accessing }
LlAppleScriptHtmlElementLocator class >> selector: aString [ 
	^ self new
		selector: aString;
		yourself
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
	^ CwSafari reference doJavascript: js
]
