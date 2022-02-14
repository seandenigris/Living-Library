Class {
	#name : #LlAppleScriptWebPage,
	#superclass : #Object,
	#instVars : [
		'url'
	],
	#category : #LivingLibrary
}

{ #category : #accessing }
LlAppleScriptWebPage class >> atUrl: aUrl in: browser [
	^ self new
		url: aUrl;
		yourself
]

{ #category : #'as yet unclassified' }
LlAppleScriptWebPage >> elementLocatorFromSelector: aString [ 
	^ LlAppleScriptHtmlElementLocator selector: aString
]

{ #category : #accessing }
LlAppleScriptWebPage >> url: aUrl [

	url := aUrl
]
