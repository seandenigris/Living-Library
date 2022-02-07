Class {
	#name : #LlPlaywrightBrowser,
	#superclass : #LlPlaywrightObject,
	#category : #'LivingLibrary-Playwright'
}

{ #category : #'instance creation' }
LlPlaywrightBrowser class >> on: proxy [
	^ self new
		model: proxy;
		yourself
]

{ #category : #accessing }
LlPlaywrightBrowser >> close [
	^ self model newCommandFactory
		<< (P3GCall target: self model => #close positionalArguments: { });
		sendAndWait.
]

{ #category : #accessing }
LlPlaywrightBrowser >> model [

	^ model
]

{ #category : #accessing }
LlPlaywrightBrowser >> model: aPBProxyObject [
	model := aPBProxyObject
]

{ #category : #accessing }
LlPlaywrightBrowser >> openOn: aUrl [
]
