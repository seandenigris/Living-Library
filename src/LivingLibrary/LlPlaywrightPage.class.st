"
From [the doc](https://playwright.dev/python/docs/api/class-page): 

*extends: EventEmitter. Page provides methods to interact with a single tab in a Browser, or an extension background page in Chromium. One Browser instance might have multiple Page instances.*
"
Class {
	#name : 'LlPlaywrightPage',
	#superclass : 'LlPlaywrightObject',
	#instVars : [
		'browser'
	],
	#category : 'LivingLibrary-Web Driving-Playwright',
	#package : 'LivingLibrary',
	#tag : 'Web Driving-Playwright'
}

{ #category : 'accessing' }
LlPlaywrightPage class >> on: proxy inBrowser: browser [ 
	^ self new
		model: proxy;
		browser: browser;
		yourself
]

{ #category : 'accessing' }
LlPlaywrightPage >> browser [

	^ browser
]

{ #category : 'accessing' }
LlPlaywrightPage >> browser: anObject [

	browser := anObject
]

{ #category : 'player API' }
LlPlaywrightPage >> elementLocatorFromSelector: aString [
	
	^ self locator: aString
]

{ #category : 'API' }
LlPlaywrightPage >> frameLocator: selectorString [
	"selectorString - any valid CSS selector, plus some custom Playwright additions
	
	Reference: https://playwright.dev/python/docs/api/class-page#page-frame-locator"

	^ self 
		returnA: LlPlaywrightFrameLocator fromScript: [ :factory |
			factory << (P3GCall target: self model => #frame_locator positionalArguments: { selectorString }) ]
]

{ #category : 'player API' }
LlPlaywrightPage >> frameReferenceFromSelector: selectorString [

	^ self frameLocator: selectorString
]

{ #category : 'accessing' }
LlPlaywrightPage >> locator: aString [
	
	^ self 
		returnA: LlPlaywrightLocator
		fromScript: [ :factory |
				factory << (P3GCall target: self model => #locator positionalArguments: { aString }) ]
]

{ #category : 'accessing' }
LlPlaywrightPage >> model [

	^ model
]

{ #category : 'accessing' }
LlPlaywrightPage >> model: anObject [

	model := anObject
]

{ #category : 'accessing' }
LlPlaywrightPage >> onQuit [
	self browser close
]

{ #category : 'accessing' }
LlPlaywrightPage >> url: aUrl [
	
	self model newCommandFactory
		<< (P3GCall target: self model => #goto positionalArguments: { aUrl asString });
		sendAndWait
]
