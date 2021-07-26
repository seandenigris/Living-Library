Class {
	#name : #LivingLibraryBrowser,
	#superclass : #Object,
	#category : #'LivingLibrary-UI'
}

{ #category : #'as yet unclassified' }
LivingLibraryBrowser class >> menuCommandOn: aBuilder [ 

	<worldMenu>
	(aBuilder item: #'Browse Living Library')
		action: [ self open ].
]

{ #category : #'as yet unclassified' }
LivingLibraryBrowser class >> open [

	^ self new open.
]

{ #category : #'as yet unclassified' }
LivingLibraryBrowser >> addWorkTo: aLivingLibrary [

	| type title author book |
	type := LlAuthoredWork types at: (UIManager default chooseFrom: LlAuthoredWork types).
	title := UIManager default request: 'Title'.
	author := Author fromUser.
	book := LlAuthoredWork titled: title by: { author }.
	book type: type.
	aLivingLibrary receive: book.
]

{ #category : #'as yet unclassified' }
LivingLibraryBrowser >> browser [

	| browser |
	browser := GLMTabulator new.
	browser with: [ :t |
		t
			row: #collection;
			row: #quotes.
		t transmit to: #collection; andShow: [ :a | self collectionIn: a ].
		t transmit to: #quotes; from: #collection; andShow: [ :a | self quotesIn: a ] ].
	^ browser.
]

{ #category : #'as yet unclassified' }
LivingLibraryBrowser >> collectionIn: presentation [

	presentation list
		act: [ :list |
			self addWorkTo: list entity.
			list update ]
			icon: GLMUIThemeExtraIcons glamorousAdd
			on: $a
			entitled: 'Add a work';
		act: [ :list | list selection explore ]
			icon: GLMUIThemeExtraIcons glamorousInspect
			on: $i
			entitled: 'Explore object';
		title: 'Collection';
		display: #collection.
]

{ #category : #accessing }
LivingLibraryBrowser >> highlight: aWrittenWork [

	| content page reference quote |
	content := UIManager default request: 'Quoted text'.
	content ifNil: [ ^ self ].
	page := UIManager default request: 'Page number'.
	page ifNil: [ ^ self ].
	reference := QuPageCitation citing: aWrittenWork page: page asNumber.
	quote := QuQuote that: reference said: content.
	aWrittenWork highlight: quote.
]

{ #category : #'as yet unclassified' }
LivingLibraryBrowser >> open [

	self browser openOn: LlLibrary uniqueInstance.
]

{ #category : #'as yet unclassified' }
LivingLibraryBrowser >> quotesIn: aPresentation [
	
	aPresentation list
		title: 'Quotes';
		display: #quotes;
		act: [ :list :work |
			self highlight: work.
			list update ]
			icon: GLMUIThemeExtraIcons glamorousAdd
			on: $a
			entitled: 'Add a quote'.
]
