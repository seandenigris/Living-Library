Class {
	#name : #LlAppleScriptWebPage,
	#superclass : #Object,
	#instVars : [
		'url',
		'browser'
	],
	#category : #LivingLibrary
}

{ #category : #accessing }
LlAppleScriptWebPage class >> atUrl: aUrl in: browser [
	^ self new
		basicUrl: aUrl;
		browser: browser;
		yourself
]

{ #category : #'as yet unclassified' }
LlAppleScriptWebPage >> basicUrl: aUrl [ 
	url := aUrl
]

{ #category : #accessing }
LlAppleScriptWebPage >> browser [

	^ browser
]

{ #category : #accessing }
LlAppleScriptWebPage >> browser: anObject [

	browser := anObject
]

{ #category : #accessing }
LlAppleScriptWebPage >> documentIdString [
	^ 'first document where URL begins with ', self url asString surroundedByDoubleQuotes
]

{ #category : #accessing }
LlAppleScriptWebPage >> elementLocatorFromSelector: aString [ 
	^ LlAppleScriptHtmlElementLocator selector: aString in: self
]

{ #category : #accessing }
LlAppleScriptWebPage >> onQuit [
	| template script |
	template := 'repeat with t in tabs of windows
		tell t
			if URL is "{url}" then
				close
				exit repeat
			end if
		end tell
	end repeat'.
	script := template format: { #url -> self url asString } asDictionary.
	self browser tellApplicationTo: script
]

{ #category : #accessing }
LlAppleScriptWebPage >> url [
	^ url
]

{ #category : #accessing }
LlAppleScriptWebPage >> url: aUrl [
	| scriptTemplate script |
	scriptTemplate := 'set URL of {document} to "{targetUrl}"'.
	script := scriptTemplate format: {
		#document -> self documentIdString.
		#targetUrl -> aUrl asString } asDictionary.
	self browser applescriptTell: script.
	url := aUrl.
	self waitForDocumentToLoad.
]

{ #category : #accessing }
LlAppleScriptWebPage >> waitForDocumentToLoad [
	
	| isReadyTest testGuardedIfTooEarly |
	isReadyTest := [ 
		self browser 
			doJavascript: 'document.readyState == "complete"'
			in: self documentIdString.
		"Reference: https://developer.mozilla.org/en-US/docs/Web/API/Document/readyState
		via https://codereview.stackexchange.com/a/91967" ].
			
	"testGuardedIfTooEarly := [ 
		isReadyTest
			on: MessageNotUnderstood
			do: [ :ex | 
				(ex signaler isKindOf: ApplescriptReference)
					ifTrue: [ ex return: false ]
					ifFalse: [ ex pass ] ] ]."
			
	[ isReadyTest whileFalse: [ 0.2 seconds wait ] ]
		valueWithin: 10 seconds
		onTimeout: [].
]
