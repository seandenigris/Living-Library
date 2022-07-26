Class {
	#name : #LlMpvJSONDriver,
	#superclass : #Object,
	#instVars : [
		'pythonMpv'
	],
	#category : #'LivingLibrary-PythonMpv'
}

{ #category : #accessing }
LlMpvJSONDriver >> currentTime [
	^ self pythonMpv newCommandFactory
		<< (self pythonMpv => #time_pos);
		sendAndWait
]

{ #category : #accessing }
LlMpvJSONDriver >> exampleCommand [

	LibC resultOfCommand: 'echo ''{ "command": ["get_property", "playback-time"] }'' | /opt/homebrew/bin/socat - /tmp/mpvsocket'
]

{ #category : #accessing }
LlMpvJSONDriver >> filename [
	self pythonMpv newCommandFactory
		<< (self pythonMpv => #filename);
		sendAndWait
]

{ #category : #'as yet unclassified' }
LlMpvJSONDriver >> isPlaying [
	| isPaused |
	self filename ifNil: [ ^ false ].
	isPaused := self pythonMpv newCommandFactory
		<< (self pythonMpv => #pause);
		sendAndWait.
	^ isPaused not
]

{ #category : #accessing }
LlMpvJSONDriver >> onQuit [
	self terminate
]

{ #category : #accessing }
LlMpvJSONDriver >> pause [
	self pythonMpv newCommandFactory
		<< (self pythonMpv => #pause <- true);
		send
]

{ #category : #accessing }
LlMpvJSONDriver >> play [
	self pythonMpv newCommandFactory
		<< (self pythonMpv => #pause <- false);
		send
]

{ #category : #accessing }
LlMpvJSONDriver >> pythonMpv [
	pythonMpv ifNotNil: [ ^ pythonMpv ].
	
	^ pythonMpv := PBApplication uniqueInstance 
		sendSource: 'import mpv
import mpvsilence
mpv.MPV()' 
		withBindings: {}
]

{ #category : #'as yet unclassified' }
LlMpvJSONDriver >> seekTo: aDuration [ 
	"player.seek(offset, reference=""absolute"")"
	
	self pythonMpv newCommandFactory
		<< (P3GCall target: self pythonMpv => #seek  positionalArguments: { aDuration asSeconds } keywordArguments: { #reference -> 'absolute' } asDictionary);
		sendAndWait.
]

{ #category : #accessing }
LlMpvJSONDriver >> show: media [
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
LlMpvJSONDriver >> skipSilence [
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
LlMpvJSONDriver >> speed [
	^ self pythonMpv newCommandFactory
		<< (self pythonMpv => #speed);
		sendAndWait
]

{ #category : #accessing }
LlMpvJSONDriver >> speed: aNumber [
	self pythonMpv newCommandFactory
		<< (self pythonMpv => #speed <- aNumber);
		send
]

{ #category : #accessing }
LlMpvJSONDriver >> terminate [
	
	self pythonMpv newCommandFactory
		<< (P3GCall target: self pythonMpv => #terminate);
		sendAndWait.
]
