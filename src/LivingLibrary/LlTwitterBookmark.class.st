"
Apparently, bookmarks are not available via the Twitter API. 
1. Export your bookmarks to JSON files following [these instructions](https://dev.to/divyajyotiuk/exporting-your-twitter-bookmarks-in-markdown-file-19bj)
2. Use me to process these JSON files
"
Class {
	#name : 'LlTwitterBookmark',
	#superclass : 'Object',
	#instVars : [
		'rawData'
	],
	#category : 'LivingLibrary-Twitter',
	#package : 'LivingLibrary',
	#tag : 'Twitter'
}

{ #category : 'accessing' }
LlTwitterBookmark class >> dictionary: aDictionary deepAt: aCollection [

	^ aCollection 
		inject: aDictionary 
		into: [ :result :key |
		result at: key ].
]

{ #category : 'accessing' }
LlTwitterBookmark class >> dictionary: aDictionary deepAt: aCollection ifAbsent: absentBlock [

	^ aCollection 
		inject: aDictionary 
		into: [ :result :key |
		result at: key ifAbsent: absentBlock ].
]

{ #category : 'accessing' }
LlTwitterBookmark class >> dictionary: aDictionary deepAt: aCollection ifPresent: presentBlock ifAbsent: absentBlock [

	| result |
	result :=  aCollection 
		inject: aDictionary 
		into: [ :currentResult :key |
		currentResult 
			at: key 
			ifAbsent: [ ^ absentBlock value ] ].
			
	^ presentBlock cull: result
]

{ #category : 'accessing' }
LlTwitterBookmark class >> fromJsonFile: file [
	
	| results json resultsPath resultPath |
	
	json := STONJSON fromString: file contents.
	resultsPath := #(data bookmark_timeline timeline instructions 1 entries).
	resultPath := #(content itemContent tweet_results result).
	results := self dictionary: json deepAt: resultsPath.
	
	^ results 
		select: [ :e |
			| type typePath hasData |
			typePath := #(content __typename).
			type := self dictionary: e deepAt: typePath.
			hasData := self 
				dictionary: e
				deepAt: resultPath  
				ifPresent: [ true ]
				ifAbsent: [ false ].
			type = 'TimelineTimelineItem' and: [ hasData ] ]
		thenCollect: [ :e |	
			self 
				dictionary: e 
				deepAt: resultPath  
				ifPresent: [ :result |
					self new
				rawData: result;
				yourself ]
				ifAbsent: [ nil ].
			 ].
		
	"Adapted from https://dev.to/divyajyotiuk/exporting-your-twitter-bookmarks-in-markdown-file-19bj"
]

{ #category : 'accessing' }
LlTwitterBookmark class >> fromJsonInFolder: folder [
	
	| jsonFiles |
	jsonFiles := folder filesMatching: '*.json'.
	^ jsonFiles flatCollect: [ :file | self fromJsonFile: file ]
]

{ #category : 'accessing' }
LlTwitterBookmark >> id [
	^ self class
		dictionary: self rawData
		deepAt: #(rest_id)
		ifPresent: [ :result | result ]
		ifAbsent: [ nil ].
]

{ #category : 'accessing' }
LlTwitterBookmark >> rawData [

	^ rawData
]

{ #category : 'accessing' }
LlTwitterBookmark >> rawData: anObject [

	rawData := anObject
]

{ #category : 'accessing' }
LlTwitterBookmark >> text [
	^ self class
		dictionary: self rawData
		deepAt: #(legacy full_text)
		ifPresent: [ :result | result ]
		ifAbsent: [ nil ].
]

{ #category : 'accessing' }
LlTwitterBookmark >> username [
	^ self class
		dictionary: self rawData
		deepAt: #(core user_results result legacy screen_name)
		ifPresent: [ :uname | uname ]
		ifAbsent: [ nil ].
]
