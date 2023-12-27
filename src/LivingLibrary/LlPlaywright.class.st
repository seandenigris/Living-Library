Class {
	#name : #LlPlaywright,
	#superclass : #Object,
	#classVars : [
		'PythonInstance'
	],
	#category : #'LivingLibrary-Web Driving-Playwright'
}

{ #category : #initialization }
LlPlaywright class >> initialize [
	SessionManager default registerSystemClassNamed: self name
]

{ #category : #installation }
LlPlaywright class >> install [
	| pyBridgeFolder cmdString playwrightFile |
	pyBridgeFolder := FileLocator imageDirectory / 'PythonBridgeRuntime'.
	playwrightFile := FileLocator home / '.pyenv/shims/playwright'.
	cmdString := 'cd "', pyBridgeFolder fullName, '"; ', playwrightFile fullName, ' install'.
	
	cmdString asSuCommand run
]

{ #category : #initialization }
LlPlaywright class >> shutDown: quitting [
	quitting ifFalse: [ ^ self ].

	PythonInstance ifNotNil: #stop
]

{ #category : #accessing }
LlPlaywright class >> start [
	| template |
	
	PythonInstance ifNotNil: [ ^ self ].
	
	template := 'from playwright.sync_api import sync_playwright'.

	PythonInstance := PBApplication uniqueInstance newCommandStringFactory
    	script: template;
	    resultExpression: 'sync_playwright().start()';
	    sendAndWait.
]

{ #category : #accessing }
LlPlaywright class >> stop [
	PythonInstance ifNil: [ ^ self ].
	
	[ PythonInstance send: #stop ] on: PBPythonError do: [].
	PythonInstance := nil
]

{ #category : #accessing }
LlPlaywright class >> uniqueInstance [
	^ self new
]

{ #category : #accessing }
LlPlaywright >> gtDirFor: aView [
	<gtView>
	
	PythonInstance ifNil: [ ^ aView empty ].
	^ aView forward
		object: [ self pythonInstance ];
		view: #gtDirFor:
]

{ #category : #accessing }
LlPlaywright >> initialize [
	super initialize.
	self class start.
]

{ #category : #convenience }
LlPlaywright >> launch: browser isHeadless: aBoolean [
	"browser - e.g. firefox, chromium, webkit"
	| proxy |
	proxy:= self pythonInstance newCommandFactory
		<< (P3GCall target: self pythonInstance => browser => #launch  positionalArguments: nil keywordArguments: { #headless -> aBoolean } asDictionary);
		sendAndWait.
	^ LlPlaywrightBrowser on: proxy
]

{ #category : #convenience }
LlPlaywright >> pythonInstance [
	PythonInstance ifNil: [ self class start ].
	^ PythonInstance
]

{ #category : #accessing }
LlPlaywright >> show: media [

	| browserProxy pageProxy browser |
	browserProxy := self pythonInstance newCommandFactory
		<< (P3GCall target: self pythonInstance => #firefox => #launch keywordArguments: { #headless -> false } asDictionary);
		sendAndWait.
	pageProxy := browserProxy newCommandFactory
		<< (P3GCall target: browserProxy => #new_page);
		sendAndWait.
	pageProxy newCommandFactory
		<< (P3GCall target: pageProxy => #goto positionalArguments: { media url asString });
		sendAndWait.
	browser := LlPlaywrightBrowser on: browserProxy.
	^ LlPlaywrightPage on: pageProxy inBrowser: browser.
]
