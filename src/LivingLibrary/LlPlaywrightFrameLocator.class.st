"
See {{gtClass:LlPlaywrightLocator}} class comment.

From [the doc](https://playwright.dev/python/docs/api/class-framelocator): *FrameLocator represents a view to the iframe on the page. It captures the logic sufficient to retrieve the iframe and locate elements in that iframe. FrameLocator can be created with either page.frame_locator(selector) or locator.frame_locator(selector) method.*
"
Class {
	#name : 'LlPlaywrightFrameLocator',
	#superclass : 'LlPlaywrightObject',
	#category : 'LivingLibrary-Web Driving-Playwright',
	#package : 'LivingLibrary',
	#tag : 'Web Driving-Playwright'
}

{ #category : 'instance creation' }
LlPlaywrightFrameLocator class >> on: proxy [
	^ self new
		model: proxy;
		yourself
]

{ #category : 'player API' }
LlPlaywrightFrameLocator >> elementLocatorFromSelector: aString [
	
	^ self locator: aString
]

{ #category : 'accessing' }
LlPlaywrightFrameLocator >> locator: aString [
	
	^ self 
		returnA: LlPlaywrightLocator
		fromScript: [ :factory |
				factory << (P3GCall target: self model => #locator positionalArguments: { aString }) ]
]

{ #category : 'accessing' }
LlPlaywrightFrameLocator >> model [

	^ model
]

{ #category : 'accessing' }
LlPlaywrightFrameLocator >> model: aPBProxyObject [
	model := aPBProxyObject
]
