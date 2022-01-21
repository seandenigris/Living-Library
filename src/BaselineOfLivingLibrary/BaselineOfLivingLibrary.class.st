"
## What is a library?

A library is a place to find and read books... Oh wait, they have music too... Oh wait, they also have DVDs... Oh wait, sorry, they also have computers to look things up... and old newspaper captures and...

You get the point.

Even in the real world, a library is a fluid concept, especially as more technology and formats have come along.

Here, in the magical virtual world, the possibilities are exponentially more.

## A *Living* Library

We define a `library` as a place where one can find `copies` of `authored works`. Check out  {{gtClass:LlLibrary|show=#gtCoderLepiterCommentsFor:}} for more info.
"
Class {
	#name : #BaselineOfLivingLibrary,
	#superclass : #BaselineOf,
	#category : #BaselineOfLivingLibrary
}

{ #category : #testing }
BaselineOfLivingLibrary class >> isDynabook [
	^ true
]

{ #category : #baseline }
BaselineOfLivingLibrary >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [
		spec 
			baseline: 'Magritte' with: [
				spec 
					loads: #('Magritte-Bootstrap');
					repository: 'github://seandenigris/Magritte' ];
			baseline: 'Mocketry' with: [
				spec repository: 'github://dionisiydk/Mocketry' ];
			baseline: 'MyPeople' with: [
				spec repository: 'github://seandenigris/My-People' ];
			baseline: 'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements' ];
			baseline: 'QuoteMe' with: [
				spec repository: 'github://seandenigris/Quote-Me' ];
			baseline: 'ResourcesLive' with: [
				spec repository: 'github://seandenigris/Resources-Live' ];
			baseline: 'SimplePersistence' with: [
				spec repository: 'github://seandenigris/Simple-Persistence' ].
		spec package: 'LivingLibrary' with: [
			spec requires: #('Magritte' 'Mocketry' 'MyPeople' 'PharoEnhancements' 'QuoteMe' 'ResourcesLive' 'SimplePersistence') ] ].
				
	spec for: #notGToolkit do: [
		spec baseline: 'XPath' with: [
			spec repository: 'github://seandenigris/XML-XPath' ].
		spec 
			package: 'LivingLibrary' with: [ 
				spec requires: 'XPath' "needed for bible stuff" ] ]
]

{ #category : #accessing }
BaselineOfLivingLibrary >> customProjectAttributes [
	^ self isGTImage
			ifFalse: [ #(notGToolkit) ]
			ifTrue: [ #(GToolkit) ]
]

{ #category : #accessing }
BaselineOfLivingLibrary >> isGTImage [
	
	^ RPackageOrganizer default packageNames anySatisfy: [ :pn | pn beginsWith: 'Lepiter-' ].
	"Implementation note: used to check for GToolkit prefix, but P7 has a GToolkit-Examples package. Lepiter, OTOH, could only be loaded in a GT image"
]
