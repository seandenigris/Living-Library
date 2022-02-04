Class {
	#name : #LlWebVideo,
	#superclass : #LlWebResource,
	#category : #'LivingLibrary-Core'
}

{ #category : #'as yet unclassified' }
LlWebVideo >> jsPause [
	^ SuJSScript htmlVideos + SuJSScript videoPause
		argumentAt: #video put: 'videos[0]';
		argumentAt: #videosVarName put: 'videos'.
]
