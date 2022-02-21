Class {
	#name : #LlApplescriptMediaDriver,
	#superclass : #Object,
	#category : #LivingLibrary
}

{ #category : #accessing }
LlApplescriptMediaDriver >> browser [

	^ CwSafari reference
]

{ #category : #accessing }
LlApplescriptMediaDriver >> initialize [

	| somethingFromJS |
	super initialize.
	
	somethingFromJS := self browser  doJavascript: '1'.
	somethingFromJS = 1 ifFalse: [ self error: 'Can''t doJavaScript in ', self browser class name, ' browser. You probably need to enable "Allow JavaScript from Apple Events" in the "Develop" menu' ].
]

{ #category : #accessing }
LlApplescriptMediaDriver >> show: media [

	self browser
		openInNewWindow: media url;
		activate.
	
	self waitForDocumentToLoad.
	
	^ LlAppleScriptWebPage atUrl: media url in: self browser
]

{ #category : #accessing }
LlApplescriptMediaDriver >> waitForDocumentToLoad [
	
	[ 
		[ self browser doJavascript: 'document.readyState == "complete"' ]
			whileFalse: [ 0.5 seconds wait ] ]
		valueWithin: 10 seconds
		onTimeout: [].
		
	"Reference: https://developer.mozilla.org/en-US/docs/Web/API/Document/readyState
		via https://codereview.stackexchange.com/a/91967"
]
