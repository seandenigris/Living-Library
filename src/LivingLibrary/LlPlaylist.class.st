Class {
	#name : 'LlPlaylist',
	#superclass : 'LlLibraryItem',
	#instVars : [
		'items'
	],
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'accessing' }
LlPlaylist >> items [

  ^ items
]

{ #category : 'accessing' }
LlPlaylist >> items: anObject [

  items := anObject
]

{ #category : 'views' }
LlPlaylist >> itemsGtViewFor: aView [
  <gtView>
  
  items ifNil: [ ^ aView empty ].
  
  ^ aView columnedList
      title: 'Items';
      items: [ items ];
      column: 'Value' text: [ :each | each gtDisplayString ];
      actionUpdateButton
]

{ #category : 'as yet unclassified' }
LlPlaylist >> newPlayer [
	^ LlPlaylistPlayer on: self.
]
