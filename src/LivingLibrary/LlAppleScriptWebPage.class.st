Class {
	#name : #LlAppleScriptWebPage,
	#superclass : #Object,
	#instVars : [
		'url',
		'browser'
	],
	#category : #'LivingLibrary-Web Driving-AppleScript'
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
LlAppleScriptWebPage >> cookie [
	"https://stackoverflow.com/a/57909990"
	^ self doJavascript: 'document.cookie'
]

{ #category : #accessing }
LlAppleScriptWebPage >> doJavascript: script [
	^ self browser doJavascript: script in: self documentIdString
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
LlAppleScriptWebPage >> exists [
	^ self browser applescriptTellTo: 'exists (', self documentIdString, ')'
]

{ #category : #accessing }
LlAppleScriptWebPage >> isDocumentComplete [

	^ self browser 
		doJavascript: 'document.readyState == "complete"'
		in: self documentIdString.
		
	"Reference: https://developer.mozilla.org/en-US/docs/Web/API/Document/readyState via https://codereview.stackexchange.com/a/91967"
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
LlAppleScriptWebPage >> printOn: aStream [

	aStream
		nextPutAll: self documentIdString;
		nextPutAll: ' ('.
	super printOn: aStream.
	aStream nextPut: $)
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
	self browser applescriptTellTo: script.
	url := aUrl.
	self waitForDocumentToLoad.
]

{ #category : #accessing }
LlAppleScriptWebPage >> waitForDocumentToLoad [
			
	[ [ self exists and: [  self isDocumentComplete ] ] whileFalse: [ 0.2 seconds wait ] ]
		valueWithin: 10 seconds
		onTimeout: [].
]
