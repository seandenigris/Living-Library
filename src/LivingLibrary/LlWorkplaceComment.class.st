"
So we have two separate problems:
1. How to reach / reference globally - is it in the LlLibrary? Some other DB added to the soup?
2. Is it a work, a copy, both, or neither?
"
Class {
	#name : 'LlWorkplaceComment',
	#superclass : 'LlWebResource',
	#traits : 'DbTDomainObject',
	#classTraits : 'DbTDomainObject classTrait',
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'testing' }
LlWorkplaceComment class >> peCanHandleFromString: aString [
	^ 'https\://[^.]+.workplace.com' asRegex matchesPrefix: aString
]

{ #category : 'accessing' }
LlWorkplaceComment >> group [
	^ self url pathSegments second asNumber
]

{ #category : 'accessing' }
LlWorkplaceComment >> id [
	^ (self url queryAt: #comment_id) asNumber
]

{ #category : 'accessing' }
LlWorkplaceComment >> initialize [

	super initialize.
	self ensureUUID
]

{ #category : 'accessing' }
LlWorkplaceComment >> post [
	^ self url pathSegments fourth asNumber
]

{ #category : 'accessing' }
LlWorkplaceComment >> workplace [
	^ self url host copyUpTo: $.
]
