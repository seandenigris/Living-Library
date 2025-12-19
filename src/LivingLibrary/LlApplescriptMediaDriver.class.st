Class {
	#name : 'LlApplescriptMediaDriver',
	#superclass : 'Object',
	#category : 'LivingLibrary-Web Driving-AppleScript',
	#package : 'LivingLibrary',
	#tag : 'Web Driving-AppleScript'
}

{ #category : 'accessing' }
LlApplescriptMediaDriver >> browser [

	^ CwSafari reference
]

{ #category : 'accessing' }
LlApplescriptMediaDriver >> initialize [

	| somethingFromJS |
	super initialize.
	
	somethingFromJS := self browser  doJavascript: '1'.
	somethingFromJS = 1 ifFalse: [ self error: 'Can''t doJavaScript in ', self browser class name, ' browser. You probably need to enable "Allow JavaScript from Apple Events" in the "Develop" menu' ].
]

{ #category : 'accessing' }
LlApplescriptMediaDriver >> show: media [

	| result |
	
	self browser
		openInNewWindow: media url;
		activate.
	
	result := LlAppleScriptWebPage atUrl: media url in: self browser.
	result waitForDocumentToLoad.
	^ result
]
