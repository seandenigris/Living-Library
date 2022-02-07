Class {
	#name : #LlPlaywrightBrowser,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #'instance creation' }
LlPlaywrightBrowser class >> on: proxy [
	^ self new
		model: proxy;
		yourself
]

{ #category : #accessing }
LlPlaywrightBrowser >> model: aPBProxyObject [
	model := aPBProxyObject
]

{ #category : #accessing }
LlPlaywrightBrowser >> openOn: aUrl [
]
