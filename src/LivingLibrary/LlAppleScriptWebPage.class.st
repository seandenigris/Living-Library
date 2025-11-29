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
	^ self doJavascriptViaPython: script
	
	"The OsaScript bridge (see `doJavascriptViaOSA:`) is finicky, so trying to use Python instead by default"
]

{ #category : #accessing }
LlAppleScriptWebPage >> doJavascriptViaOSA: script [
	^ self browser doJavascript: script in: self documentIdString
]

{ #category : #accessing }
LlAppleScriptWebPage >> doJavascriptViaPython: script [
	
	^ self pythonInstance do_JavaScript: script string
]

{ #category : #accessing }
LlAppleScriptWebPage >> documentIdString [
	^ 'first document where URL begins with ', self url asString surroundedByDoubleQuotes
]

{ #category : #accessing }
LlAppleScriptWebPage >> elementLocatorFromId: aString [

	^ self elementLocatorFromSelector: '#', aString
]

{ #category : #accessing }
LlAppleScriptWebPage >> elementLocatorFromSelector: aString [ 
	^ LlAppleScriptHtmlElementLocator selector: aString in: self
]

{ #category : #accessing }
LlAppleScriptWebPage >> exists [
	^ self browser applescriptTellTo: 'exists (', self documentIdString, ')'
]

{ #category : #'as yet unclassified' }
LlAppleScriptWebPage >> iframeSrcBeginningWith: aString [
	
	| urlString js jsTemplate |
	
	jsTemplate := 'frameSelector = `iframe[src^={url}]`;
document.querySelector(frameSelector).getAttribute(''src'')'.
	js := jsTemplate format: { #url -> aString surroundedBySingleQuotes } asDictionary.
	urlString := self doJavascriptViaPython: js.

	^ urlString asUrl.
	
	"Implementation notes: 
	- couldn't get this to work with the  OsaScript bridge, so using Python instead. 
	- Query selector syntax adapted from https://stackoverflow.com/a/303961"
]

{ #category : #accessing }
LlAppleScriptWebPage >> isDocumentComplete [

	^ self browser 
		doJavascript: 'document.readyState == "complete"'
		in: self documentIdString.
		
	"Reference: https://developer.mozilla.org/en-US/docs/Web/API/Document/readyState via https://codereview.stackexchange.com/a/91967"
]

{ #category : #'as yet unclassified' }
LlAppleScriptWebPage >> name [

	^ self pythonInstance name callMethod: #get
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

{ #category : #'as yet unclassified' }
LlAppleScriptWebPage >> pythonInstance [

	^ PBApplication start newCommandStringFactory
		script: 'from appscript import *';
		bindingAt: #url put: self url asString;
	    resultExpression: 'app("Safari").documents[its.URL.beginswith(url)][1]';
	    sendAndWait.
	    
	"Appscript reference filtering doc: https://appscript.sourceforge.io/py-appscript/doc_3x/appscript-manual/09_referenceforms.html"
]

{ #category : #'as yet unclassified' }
LlAppleScriptWebPage >> source [
	| sourceString htmlFile result |
	sourceString := self pythonInstance source callMethod: #get.
	htmlFile := Tempfile named: self name asFilename , '.html'.
	htmlFile writeStreamDo: [ :str | str << sourceString ].
	result := RlHTML on: htmlFile.
	^ result
		source: self url;
		yourself.
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
