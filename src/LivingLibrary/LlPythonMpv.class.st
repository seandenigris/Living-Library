Class {
	#name : #LlPythonMpv,
	#superclass : #Object,
	#instVars : [
		'pythonMpv'
	],
	#category : #'LivingLibrary-PythonMpv'
}

{ #category : #'as yet unclassified' }
LlPythonMpv >> play: aFile [
	PBApplication uniqueInstance 
		sendSource: 'player.play(filename)'
		withBindings: { 
			#player -> self pythonMpv.
			#filename -> aFile fullName }.
]

{ #category : #accessing }
LlPythonMpv >> pythonMpv [
	pythonMpv ifNotNil: [ ^ pythonMpv ].
	
	^ pythonMpv := PBApplication uniqueInstance 
		sendSource: 'import mpv
mpv.MPV()' 
		withBindings: {}
]

{ #category : #accessing }
LlPythonMpv >> show: media [

	^ self
]
