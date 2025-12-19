Class {
	#name : 'CcLicenseSpecification',
	#superclass : 'TestCase',
	#category : 'LivingLibrary-Licensing',
	#package : 'LivingLibrary',
	#tag : 'Licensing'
}

{ #category : 'tests' }
CcLicenseSpecification >> testDeedUrl [

	| license |
	license := CcLicense nonCommercial version: 4.0.
	license deedURL should equal: 'https://creativecommons.org/licenses/by-nc/4.0/' asUrl
]

{ #category : 'tests' }
CcLicenseSpecification >> testLinkText [

	| license version |
	version := 2.0.
	license := CcLicense nonCommercial version: version.
	license linkText should equal: 'CC BY-NC ', version asString
]
