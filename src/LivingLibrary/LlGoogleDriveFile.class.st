Class {
	#name : #LlGoogleDriveFile,
	#superclass : #LlWebResource,
	#category : #'LivingLibrary-Core'
}

{ #category : #'instance creation' }
LlGoogleDriveFile class >> fromLinkString: aString [
	^ self new
		url: aString asUrl;
		yourself
]

{ #category : #accessing }
LlGoogleDriveFile >> printOn: aStream [
	aStream
		nextPutAll: 'Google Drive';
		nextPutAll: ' @ ';
		print: self url
]

{ #category : #accessing }
LlGoogleDriveFile >> url: aUrl [

	aUrl host = 'drive.google.com' ifFalse: [ self error: 'invalid google drive URL' ].
	url := 'https://drive.google.com' asUrl addPathSegments: aUrl pathSegments
]
