Class {
	#name : 'LlBrightCoveVideo',
	#superclass : 'LlWebVideo',
	#instVars : [
		'accountId',
		'playerId',
		'videoId'
	],
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
LlBrightCoveVideo class >> fromVideoTag: aSoupTag [
				
	^ self 
		id: aSoupTag @ 'data-video-id'
		ofAccount: aSoupTag @ 'data-account'
		inPlayer: aSoupTag @ 'data-player'
]

{ #category : 'as yet unclassified' }
LlBrightCoveVideo class >> id: videoId ofAccount: accountId inPlayer: playerId [

	^ self new
		videoId: videoId;
		accountId: accountId;
		playerId: playerId;
		yourself
]

{ #category : 'accessing' }
LlBrightCoveVideo >> accountId [
	^ accountId
]

{ #category : 'accessing' }
LlBrightCoveVideo >> accountId: anObject [
	accountId := anObject
]

{ #category : 'accessing' }
LlBrightCoveVideo >> playerId [
	^ playerId
]

{ #category : 'accessing' }
LlBrightCoveVideo >> playerId: anObject [
	playerId := anObject
]

{ #category : 'as yet unclassified' }
LlBrightCoveVideo >> playerUrl [

	^ 'https://players.brightcove.net' asUrl / self accountId asString / (self playerId, '_default')/ 'index.html'
		queryAt: #videoId put: self videoId asString
]

{ #category : 'as yet unclassified' }
LlBrightCoveVideo >> url [

	^ 'https://players.brightcove.net' asUrl / self accountId / (self playerId, '_default') / 'index.html'
		queryAt: #videoId put: self videoId;
		yourself
]

{ #category : 'accessing' }
LlBrightCoveVideo >> videoId [
	^ videoId
]

{ #category : 'accessing' }
LlBrightCoveVideo >> videoId: anObject [
	videoId := anObject
]
