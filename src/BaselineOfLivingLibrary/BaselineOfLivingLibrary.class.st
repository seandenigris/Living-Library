"
A likely starting point is ${class:LivingLibrary}$. For a quick start, check out its (likely empty) singleton:
[[[
LivingLibrary uniqueInstance
]]]
"
Class {
	#name : #BaselineOfLivingLibrary,
	#superclass : #BaselineOf,
	#category : #BaselineOfLivingLibrary
}

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
			baseline: 'ResourcesLive' with: [
				spec repository: 'github://seandenigris/ResourcesLive' ];
			baseline: 'SimplePersistence' with: [
				spec repository: 'github://seandenigris/Simple-Persistence' ];
			baseline: 'XPath' with: [
				spec repository: 'github://seandenigris/XML-XPath' ].
		spec package: 'LivingLibrary' with: [
				spec requires: #('Magritte' 'Mocketry' 'MyPeople' 'PharoEnhancements' 'ResourcesLive' 'SimplePersistence' 'XPath' "for bible data"). ]. ].

]
