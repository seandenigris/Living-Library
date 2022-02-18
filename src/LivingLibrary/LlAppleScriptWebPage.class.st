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
		url: aUrl;
		browser: browser;
		yourself
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

	url := aUrl
]
