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
