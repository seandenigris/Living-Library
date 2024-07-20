Class {
	#name : #CcPhotoSpecification,
	#superclass : #BabyPhexample,
	#instVars : [
		'photoUrl',
		'ownerUsername',
		'photoTitle',
		'license',
		'profileUrl'
	],
	#category : #'LivingLibrary-Licensing'
}

{ #category : #asserting }
CcPhotoSpecification >> assert: actual matches: expectedAttributionTemplate [ 

	| expectedAttribution |
	'"<a href="{photoUrl}">{photoTitle}</a>" by <a href="{profileUrl}">{ownerUsername}</a> is licensed under <a href="{licenseName}">{licenseDeedUrl}</a>'.
	expectedAttribution := expectedAttributionTemplate format: {
		#photoTitle -> photoTitle.
		#photoUrl -> photoUrl.
		#ownerUsername -> ownerUsername.
		#profileUrl -> profileUrl.
		#licenseName -> license linkText.
		#licenseDeedUrl -> license deedURL } asDictionary.
	actual should equal: expectedAttribution
]

{ #category : #tests }
CcPhotoSpecification >> setUp [

	photoTitle := 'Creative Commons 10th Birthday Celebration San Francisco'.
	profileUrl := 'http://www.flickr.com/photos/sixteenmilesofstring' asUrl.
	photoUrl := profileUrl / '8256206923/in/set-72157632200936657' asUrl.
	ownerUsername := 'tvol'.
	license := CcLicense attribution version: 2.0.
]

{ #category : #tests }
CcPhotoSpecification >> testAttribution [
	"Adapted from https://wiki.creativecommons.org/Best_practices_for_attribution#This_is_an_ideal_attribution for plain text when you can't hyperlink (e.g. Facebook posts). Of course, we'd like to keep real object (i.e. text with links, which one can then convert into e.g. Markdown, HTML, plain text, etc., but given the current Text mess, we'll leave that as a task for another day..."
	
	| photo |
	photo := self given: #testCreation.
	self assert: photo htmlAttribution matches: '"<a href="{photoUrl}">{photoTitle}</a>" by <a href="{profileUrl}">{ownerUsername}</a> is licensed under <a href="{licenseDeedUrl}">{licenseName}</a>'.
	self assert: photo plainTextAttribution matches: '"{photoTitle}" ({photoUrl}) by {ownerUsername} ({profileUrl}) is licensed under {licenseName} ({licenseDeedUrl})'.
]

{ #category : #tests }
CcPhotoSpecification >> testCreation [

	| photo |
	photo := CcPhoto new
		title: photoTitle;
		url: photoUrl;
		owner: ownerUsername;
		license: license;
		yourself.
	photo title should equal: photoTitle.
	^ photo
]
