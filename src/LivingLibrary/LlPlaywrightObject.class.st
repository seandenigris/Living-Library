Class {
	#name : #LlPlaywrightObject,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'LivingLibrary-Web Driving-Playwright'
}

{ #category : #accessing }
LlPlaywrightObject >> returnA: aClass fromScript: aBlock [

	| factory |
	factory := self model newCommandFactory.
	aBlock value: factory.
	^ aClass on: factory sendAndWait
]
