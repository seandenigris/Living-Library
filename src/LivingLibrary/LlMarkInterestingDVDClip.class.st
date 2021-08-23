"
This was the precursor to TakeNote, which adds notetaking methods. I'm not sure where things are headed yet, so I'm keeping everything around.
"
Class {
	#name : 'LlMarkInterestingDVDClip',
	#superclass : 'Object',
	#instVars : [
		'startTime',
		'endTime',
		'dvd'
	],
	#category : 'LivingLibrary-Support'
}

{ #category : 'instance creation' }
LlMarkInterestingDVDClip class >> from: aDVD [
	
	^ self new setDVD: aDVD.
]

{ #category : 'actions' }
LlMarkInterestingDVDClip >> createClip [

	^ LlVideoClip from: dvd startingAt: startTime andEndingAt: endTime.
]

{ #category : 'accessing' }
LlMarkInterestingDVDClip >> defaultSecondsToSkip [
	"This will depend on what users find most useful.  In testing, 3 seconds seemed to work well."

	^ 3.
]

{ #category : 'actions' }
LlMarkInterestingDVDClip >> endHere [

	endTime := dvd position.
	self playClip.
]

{ #category : 'actions' }
LlMarkInterestingDVDClip >> endLaterBy: aNumberOfSeconds [

	endTime := endTime + aNumberOfSeconds.
	dvd position: endTime - 3.
	self playRestOfClip.
]

{ #category : 'private' }
LlMarkInterestingDVDClip >> execute [

"	dvd
		pause;
		section: title startsAt: startTime;
		position: originalTime."
]

{ #category : 'actions' }
LlMarkInterestingDVDClip >> playClip [

	dvd position: startTime.
	dvd play.
	[ [ dvd position < endTime ] whileTrue: [ (Delay forMilliseconds: 100) wait ].
	  dvd pause ] fork.
]

{ #category : 'private' }
LlMarkInterestingDVDClip >> playRestOfClip [

	dvd play.
	[ [ dvd position < endTime ] whileTrue: [ (Delay forMilliseconds: 100) wait ].
	  dvd pause ] fork.
]

{ #category : 'private' }
LlMarkInterestingDVDClip >> playUntilUserMarksEnd [

	dvd play.
]

{ #category : 'private' }
LlMarkInterestingDVDClip >> setDVD: aDVD [ 

	dvd := aDVD.
	startTime := endTime := aDVD position.
	^ self.
]

{ #category : 'actions' }
LlMarkInterestingDVDClip >> startEarlierBy: aNumberOfSeconds [

	startTime := startTime - aNumberOfSeconds.
	dvd position: startTime.
	self playUntilUserMarksEnd.
]
