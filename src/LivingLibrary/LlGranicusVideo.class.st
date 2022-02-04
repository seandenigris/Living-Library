Class {
	#name : #LlGranicusVideo,
	#superclass : #LlWebVideo,
	#instVars : [
		'subdomain',
		'id'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #accessing }
LlGranicusVideo >> id [

	^ id
]

{ #category : #accessing }
LlGranicusVideo >> id: anObject [

	id := anObject
]

{ #category : #accessing }
LlGranicusVideo >> newPlayer [
	LlMediaPlayer new
		service: 1
]

{ #category : #accessing }
LlGranicusVideo >> subdomain [

	^ subdomain
]

{ #category : #accessing }
LlGranicusVideo >> subdomain: anObject [

	subdomain := anObject
]

{ #category : #accessing }
LlGranicusVideo >> url [

	| template string |
	template := 'https://{subdomain}.granicus.com/MediaPlayer.php?clip_id={id}'.
	string := template format: { 
		#subdomain -> self subdomain.
		#id -> self id } asDictionary.
	^ string asUrl
]

{ #category : #accessing }
LlGranicusVideo >> videoPlayerUrl [
	"Just the video, no index links or agenda"

	| template string |
	template := 'https://{subdomain}.granicus.com/videos/{id}/player'.
	string := template format: { 
		#subdomain -> self subdomain.
		#id -> self id } asDictionary.
	^ string asUrl
]
