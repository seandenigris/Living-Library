Class {
	#name : #LlPythonMpv,
	#superclass : #Object,
	#instVars : [
		'pythonMpv'
	],
	#category : #'LivingLibrary-PythonMpv'
}

{ #category : #accessing }
LlPythonMpv >> currentTime [
	^ self pythonMpv newCommandFactory
		<< (self pythonMpv => #time_pos);
		sendAndWait
]

{ #category : #accessing }
LlPythonMpv >> filename [
	self pythonMpv newCommandFactory
		<< (self pythonMpv => #filename);
		sendAndWait
]

{ #category : #'as yet unclassified' }
LlPythonMpv >> isPlaying [
	| isPaused |
	self filename ifNil: [ ^ false ].
	isPaused := self pythonMpv newCommandFactory
		<< (self pythonMpv => #pause);
		sendAndWait.
	^ isPaused not
]

{ #category : #accessing }
LlPythonMpv >> onQuit [
	self terminate
]

{ #category : #accessing }
LlPythonMpv >> pause [
	self pythonMpv newCommandFactory
		<< (self pythonMpv => #pause <- true);
		send
]

{ #category : #accessing }
LlPythonMpv >> play [
	self pythonMpv newCommandFactory
		<< (self pythonMpv => #pause <- false);
		send
]

{ #category : #accessing }
LlPythonMpv >> pythonMpv [
	pythonMpv ifNotNil: [ ^ pythonMpv ].
	
	^ pythonMpv := PBApplication uniqueInstance 
		sendSource: 'import mpv
import mpvsilence
mpv.MPV()' 
		withBindings: {}
]

{ #category : #'as yet unclassified' }
LlPythonMpv >> seekTo: aDuration [ 
	"player.seek(offset, reference=""absolute"")"
	
	self pythonMpv newCommandFactory
		<< (P3GCall target: self pythonMpv => #seek  positionalArguments: { aDuration asSeconds } keywordArguments: { #reference -> 'absolute' } asDictionary);
		sendAndWait.
]

{ #category : #accessing }
LlPythonMpv >> show: media [
	"PBApplication uniqueInstance 
		sendSource: 'player.play(filename)'
		withBindings: { 
			#player -> self pythonMpv.
			#filename -> aFile fullName }."
	self pythonMpv newCommandFactory
		<< (P3GCall target: self pythonMpv => #play  positionalArguments: { media file fullName });
		sendAndWait.
	self pause.
	^ self "I am the container because I don't have e.g. tabs"
]

{ #category : #accessing }
LlPythonMpv >> skipSilence [
	PBApplication uniqueInstance newCommandFactory
		<< (P3GCall 
				target: self pythonMpv => #skip_silence
				positionalArguments: nil 
				keywordArguments: { 
					#noise -> -40.
					#duration -> 1 } asDictionary);
		sendAndWait.
]

{ #category : #accessing }
LlPythonMpv >> speed [
	^ self pythonMpv newCommandFactory
		<< (self pythonMpv => #speed);
		sendAndWait
]

{ #category : #accessing }
LlPythonMpv >> speed: aNumber [
	self pythonMpv newCommandFactory
		<< (self pythonMpv => #speed <- aNumber);
		send
]

{ #category : #accessing }
LlPythonMpv >> terminate [
	
	self pythonMpv newCommandFactory
		<< (P3GCall target: self pythonMpv => #terminate);
		sendAndWait.
]
