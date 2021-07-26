"
[Creative Commons Licenses](https://creativecommons.org)
"
Class {
	#name : #CcLicense,
	#superclass : #Object,
	#instVars : [
		'name',
		'abbreviation',
		'version'
	],
	#category : #'LivingLibrary-Licensing'
}

{ #category : #'as yet unclassified' }
CcLicense class >> all [

	^ { self attribution. self shareAlike. self noDerivs. self nonCommercial. self nonCommercialShareAlike. self nonCommercialNoDerivs }
]

{ #category : #'as yet unclassified' }
CcLicense class >> attribution [

	^ self new
		name: 'Attribution';
		abbreviation: 'CC BY';
		yourself
]

{ #category : #accessing }
CcLicense class >> exampleAttribution [
	<gtExample>
	^ self
		given: [ self exampleVersion ]
		when: [ :lic | 
			| work author |
			work := LlFlickrPhoto example.
			lic attributionFor: work ]
		then: [ :p | p should equalPillarMarkup: '"*Creative Commons 10th Birthday Celebration San Francisco>https://www.flickr.com/photos/sixteenmilesofstring/8256206923/in/set-72157632200936657*" by *sixteenmilesofstring>https://www.flickr.com/photos/sixteenmilesofstring/* is licensed under *CC BY 2.0>https://creativecommons.org/licenses/by/2.0/*' ]
]

{ #category : #examples }
CcLicense class >> exampleAttributionString [
	<gtExample>
	^ self
		given: [ self exampleVersion ]
		when: [ :lic | 
			| work author |
			work := LlAuthoredWork exampleAntifragile.
			lic atttributionStringFor: work ]
		then: [ :str | str should equal: '"Antifragile" by Nassim Taleb is licensed under CC BY 2.0' ]
]

{ #category : #examples }
CcLicense class >> examplePrinting [
	<gtExample>
	^ self
		given: [ self exampleVersion ]
		when: [ :lic | lic printString ]
		then: [ :str | str should equal: 'CC BY 2.0' ]
]

{ #category : #examples }
CcLicense class >> exampleVersion [
	<gtExample>
	^ self
		given: [ '2.0' ]
		when: [ :version | 
			self attribution
				version: version;
				yourself ]
		then: [ :lic :v | lic version should equal: v ]
]

{ #category : #'as yet unclassified' }
CcLicense class >> noDerivs [

	^ self new
		name: 'Attribution-NoDerivs';
		abbreviation: 'CC BY-ND';
		yourself
]

{ #category : #'as yet unclassified' }
CcLicense class >> nonCommercial [

	^ self new
		name: 'Attribution-NonCommercial';
		abbreviation: 'CC BY-NC';
		yourself
]

{ #category : #'as yet unclassified' }
CcLicense class >> nonCommercialNoDerivs [

	^ self new
		name: 'Attribution-NonCommercial-NoDerivs';
		abbreviation: 'CC BY-NC-ND';
		yourself
]

{ #category : #'as yet unclassified' }
CcLicense class >> nonCommercialShareAlike [

	^ self new
		name: 'Attribution-NonCommercial-ShareAlike';
		abbreviation: 'CC BY-NC-SA';
		yourself
]

{ #category : #'as yet unclassified' }
CcLicense class >> shareAlike [

	^ self new
		name: 'Attribution-ShareAlike';
		abbreviation: 'CC BY-SA';
		yourself
]

{ #category : #comparing }
CcLicense >> = rhs [

	^ self name = rhs name and: [ self abbreviation = rhs abbreviation and: [ self version = rhs version ] ]
]

{ #category : #accessing }
CcLicense >> abbreviation [
	^ abbreviation
]

{ #category : #accessing }
CcLicense >> abbreviation: anObject [
	abbreviation := anObject
]

{ #category : #accessing }
CcLicense >> attributionFor: aWork [
	"Reference: https://creativecommons.org/use-remix/attribution/"
	| template markup |
	template := '"{workTitle}" by {author} is licensed under *{linkText}>{deedURL}*'.
	markup := template format: {
		#workTitle -> aWork ccTitleMarkup.
		#author -> aWork ccAuthorMarkup.
		#linkText -> self linkText.
		#deedURL -> self deedURL } asDictionary.
	^ PRPillarParser parse: markup
]

{ #category : #accessing }
CcLicense >> atttributionStringFor: work [
	^ PRTextWriter write: (self attributionFor: work)
]

{ #category : #accessing }
CcLicense >> deedURL [

	| baseUrl myPath |
	baseUrl :=  'https://creativecommons.org/licenses' asUrl.
	myPath := (self abbreviation allButFirst: 3) asLowercase.
	^ baseUrl / myPath / self version asString addPathSegment: $/
]

{ #category : #comparing }
CcLicense >> hash [
	^ (self name hash bitXor: self abbreviation) bitXor: self version
]

{ #category : #accessing }
CcLicense >> legalCodeURL [

	^ self deedURL / 'legalcode'
]

{ #category : #accessing }
CcLicense >> linkText [
	^ self abbreviation, ' ', self version asString
]

{ #category : #accessing }
CcLicense >> name [
	^ name
]

{ #category : #accessing }
CcLicense >> name: anObject [
	name := anObject
]

{ #category : #accessing }
CcLicense >> printOn: aStream [
	aStream nextPutAll: self linkText
]

{ #category : #accessing }
CcLicense >> version [
	^ version
]

{ #category : #accessing }
CcLicense >> version: anObject [
	version := anObject
]
