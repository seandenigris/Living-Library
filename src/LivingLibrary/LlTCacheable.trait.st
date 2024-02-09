Trait {
	#name : #LlTCacheable,
	#category : #'LivingLibrary-Support'
}

{ #category : #caching }
LlTCacheable >> cache [
	^ self propertyAt: #cache ifAbsent: [ nil ]
]

{ #category : #caching }
LlTCacheable >> cache: file [
	self propertyAt: #cache put: file
]

{ #category : #caching }
LlTCacheable >> cached [
	
	self propertyAt: #cache ifPresent: [ :c | ^ c ].
	self cache: self download asRlResource.
	^ self cache
]

{ #category : #'instance creation' }
LlTCacheable >> download [
	self explicitRequirement
]

{ #category : #accessing }
LlTCacheable >> resourceLibrary [
	^ self propertyAt: #resourceLibrary ifAbsent: [ RlResourceLibrary uniqueInstance ]
]

{ #category : #'instance creation' }
LlTCacheable >> saveCache [
	self resourceLibrary import: self cached
]
