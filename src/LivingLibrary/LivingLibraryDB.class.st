Class {
	#name : 'LivingLibraryDB',
	#superclass : 'SpFileDatabase',
	#category : 'LivingLibrary-Persistence',
	#package : 'LivingLibrary',
	#tag : 'Persistence'
}

{ #category : 'accessing' }
LivingLibraryDB class >> backupDirectoryParent [
	^ FileLocator dynabookData
]

{ #category : 'override in subclasses' }
LivingLibraryDB class >> schema [

	^ { 
		BrBible. 
		LlLibrary. 
		LlWorkplace.
		MyPeopleDB }.
]
