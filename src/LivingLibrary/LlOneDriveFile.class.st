Class {
	#name : #LlOneDriveFile,
	#superclass : #LlSharePointFile,
	#category : #'LivingLibrary-Core'
}

{ #category : #'as yet unclassified' }
LlOneDriveFile class >> urlSubdomainGrammar [
	"Any valid subdomain which ends in '-my'. Otherwise it would be a SharePoint URL"

	^ super urlSubdomainGrammar, ('-my' asPParser, $. asPParser and).
]

{ #category : #accessing }
LlOneDriveFile >> printOn: aStream [
	aStream
		nextPutAll: 'One Drive';
		nextPutAll: ' @ ';
		print: self url
]
