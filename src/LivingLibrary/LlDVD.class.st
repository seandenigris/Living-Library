"
# Ripping
The easiest way seems to be to use the Handbrake tool. However, there doesn't seem to be one group of settings that is optimal for every situation.
## Scenarios
Per [winxdvd](https://www.winxdvd.com/resource/best-handbrake-settings-for-dvd-to-mp4.htm), here are some setting suggestions:
- Mp4 - best balance of speed, size and quality - use medium presets; possibly doing a 3-5 minute trial to check and tweak
- Plex
	- if it is a interlaced DVD, you need to enable Decomb and Detelecine
	- Video Codec: H.264 (X264)
	- Framerate (fps):30; Peak Framerate
	- Encoder Preset: Slower
	- Encoder Tune: Film
	- Encoder Profile: High
	- Encoder Level: 4.1
	- Constant Quality: 18
	- As for the Audio tab, you can change the Mixdown to 5.1 Channels (if there is) to get surround sound. Or you can choose Stereo. Bitrate 160 is ok.

"
Class {
	#name : #LlDVD,
	#superclass : #LlOpticalDisc,
	#instVars : [
		'videoFile',
		'diskImage',
		'drutilDiscInfo',
		'drutilStatus',
		'notes',
		'sections',
		'observers'
	],
	#category : 'LivingLibrary-Core'
}

{ #category : #utility }
LlDVD class >> currentDVD [
	"How do we know which disk is the DVD drive?  Some options (not suer how workable):
		* disktool fsType = udf
		* "
	| diskName |
	diskName := self nameOfDiskInDrive.
	^ self fromDiskName: diskName.
]

{ #category : #'instance creation' }
LlDVD class >> currentlyInDrive [

	^ self new setInfoFromCurrentDisc.
]

{ #category : #'instance creation' }
LlDVD class >> fromDiskImage: anFSReference [

	^ self new setDiskImage: anFSReference.
]

{ #category : #'instance creation' }
LlDVD class >> fromDiskName: aString [ 

	^ self new setTitle: '' diskName: aString.
]

{ #category : #playing }
LlDVD class >> play: titleString for: aMind [ 

	^ (self titled: titleString)
		playFor: aMind;
		yourself.
]

{ #category : #playing }
LlDVD class >> playCurrent [

	^ self currentDVD
		play;
		yourself.
]

{ #category : #'instance creation' }
LlDVD class >> rippedTo: aDirectoryEntryFile [

"	^ self new localImage: aDirectoryEntryFile"
]

{ #category : #mind }
LlDVD >> beObservedBy: aMind [ 

	observers add: aMind.
]

{ #category : #playing }
LlDVD >> bestFormat [

	videoFile ifNotNil: [ :f | ^ f ].
	(diskImage isKindOf: LlVideoDVDImage) ifTrue: [ ^ diskImage ].
	self isPresent
		ifTrue: [ DVDPlayer reference play ]
		ifFalse: [ self error: 'Disk not in drive' ].
]

{ #category : #'as yet unclassified' }
LlDVD >> cacheUpdating: anObject [

	self createDiskImageUpdating: anObject.
]

{ #category : #'as yet unclassified' }
LlDVD >> cacheUpdating: aBlock cancelIf: cancelPredicate [

	self createDiskImageUpdating: aBlock cancelIf: cancelPredicate.
]

{ #category : #'as yet unclassified' }
LlDVD >> createDiskImageUpdating: anObject [
	"anObject will be sent status updates"

	| imageFileName |
	imageFileName := self diskName, '.dmg'.
	Resources library importAs: imageFileName after: [ :fileReference |
		LlCreateDiskImage
			from: self deviceFile
			to: fileReference
			updating: anObject.
		diskImage := fileReference ].
]

{ #category : #'as yet unclassified' }
LlDVD >> createDiskImageUpdating: aBlock cancelIf: cancelPredicate [

	| imageFileName |
	imageFileName := self diskName, '.dmg'.
	Resources library importAs: imageFileName after: [ :fileReference |
		LlCreateDiskImage
			from: self deviceFile
			to: fileReference
			updating: aBlock
			cancelIf: cancelPredicate.
		diskImage := fileReference ].
]

{ #category : #private }
LlDVD >> deviceFile [

	self isMounted ifFalse: [ self error: 'DVD has no device file becuase it''s not mounted' ].
	^ self diskutilInfo deviceFile.
]

{ #category : #'as yet unclassified' }
LlDVD >> discPrintOn: aStream [

	aStream nextPutAll: self diskName.
]

{ #category : #private }
LlDVD >> diskName [

	^ diskName ifNil: [ diskName := self diskutilInfo volumeName ].
]

{ #category : #private }
LlDVD >> diskutilInfo [

	^ diskutilInfo ifUnknown: [ diskutilInfo := diskImage diskutilInfo ].
]

{ #category : #private }
LlDVD >> drutilDiscinfo [

	^ drutilDiscinfo.
]

{ #category : #private }
LlDVD >> drutilStatus [

	^ drutilStatus.
]

{ #category : #initialization }
LlDVD >> initialize [

	diskutilInfo := LlUnknownDiskInfo new.
	drutilStatus := LlUnknownDiskInfo new.
	drutilDiscinfo := LlUnknownDiskInfo new.
	diskImage := LlNoDiskImage new.
	^ self.
]

{ #category : #initialization }
LlDVD >> initializer [

	observers := OrderedCollection  new.
	sections := OrderedCollection new.
	notes := Note note: 'Notes on ', self title near: 0.
]

{ #category : #'as yet unclassified' }
LlDVD >> isMounted [

	^ diskImage isMounted or: [ self isInDrive ].
]

{ #category : #'making clips' }
LlDVD >> markInterestingClip [

	self pause.
	^ LlMarkInterestingDVDClip from: self.
]

{ #category : #'making clips' }
LlDVD >> markStartOfSection [

	self pause.
	^ MarkStartOfOpticalDiscSection from: self.
]

{ #category : #private }
LlDVD >> note: aString [ 

	notes note: aString near: self position.
]

{ #category : #mind }
LlDVD >> note: informationString asA: typeString [

	self pause.
	self observer consider: informationString asA: typeString.
]

{ #category : #accessing }
LlDVD >> notes [

	^ notes.
]

{ #category : #mind }
LlDVD >> observer [

	^ Mind ofSean.
]

{ #category : #'as yet unclassified' }
LlDVD >> onDiskImageStatusUpdateDo: aBlock [

	self announcer on: LlDiskImageStatus do: aBlock.
]

{ #category : #mind }
LlDVD >> playFor: aPerson [

	aPerson lookAt: self.
	self play.
]

{ #category : #accessing }
LlDVD >> playLength [

	^ self player dvdPlayLength.
]

{ #category : #private }
LlDVD >> player [

	^ self bestFormat player.
]

{ #category : #playing }
LlDVD >> position [

	^ self player position.
]

{ #category : #playing }
LlDVD >> position: aDuration [

	self player position: aDuration.
]

{ #category : #private }
LlDVD >> realDiskutilInfo [

	^ diskutilInfo ifUnknown: [ diskutilInfo := diskImage diskutilInfo ].
]

{ #category : #accessing }
LlDVD >> rip [
	
	self inform: 'See ', self className, '''s class comment, "Ripping" section'.
	
	"Implementation (or lack thereof) note: I could spend a lot of time programmatizing this, but at the end of the day, will it be worth the effort? How much faster/easier will it be vs. just following the fairly simple directions?"
]

{ #category : #'as yet unclassified' }
LlDVD >> ripper [

	^ LlRipDVD on: self.
]

{ #category : #private }
LlDVD >> section: aTitleString startsAt: aNumberOfSeconds [

	
	sections add: (DVDClip 
					from: self
					startingAt: aNumberOfSeconds
					andEndingAt: self playLength).
]

{ #category : #accessing }
LlDVD >> sections [

	^ sections copy.
]

{ #category : #private }
LlDVD >> setDiskImage: anFSReference [ 

	diskImage := LlVideoDVDImage on: anFSReference.
	diskutilInfo := diskImage diskutilInfo.
	^ self.
]

{ #category : #private }
LlDVD >> setInfoFromCurrentDisc [
	"We have no idea what uniquely identifies a disc, so just save everything and we'll parse/filter/whatever when the need arises"
	
	drutilStatus := DrUtil status execute.
	drutilDiscinfo := DrUtil discinfo execute.
	diskutilInfo := (Diskutil informationAbout: drutilStatus deviceFile) execute.
	^ self.
]

{ #category : #private }
LlDVD >> setTitle: titleString diskName: nameString [

	title := titleString.
	diskName := nameString.
	^ self.
]

{ #category : #copying }
LlDVD >> size [

	^ self diskutilInfo size.
]

{ #category : #accessing }
LlDVD >> state [

	^ DVDPlayer reference dvdState.
]

{ #category : #mind }
LlDVD >> takeNote [

	self pause.
	^ TakeNote on: self.
]

{ #category : #accessing }
LlDVD >> timeRemaining [

	^ self player timeRemaining.
]

{ #category : #'as yet unclassified' }
LlDVD >> togglePlayAndPause [

	| file |
	file := self bestFormat.
	file isPlaying
		ifTrue: [ file pause ]
		ifFalse: [ file play ].
]

{ #category : #'as yet unclassified' }
LlDVD >> unsubscribe: anObject [

	self announcer unsubscribe: anObject.
]
