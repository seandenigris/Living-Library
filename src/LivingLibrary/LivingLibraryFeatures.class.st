"
Scenario: Live talk
	I'm at a conference. Dale is giving a talk about GLASS. There will be things I want to remember. So what systems are effected? It's tied to the calendar, notetaking.

Scenario: E-Book
	I have an ebook that I downloaded from the internet. I want it, and the information I derive from it, to be modelled. The intention is a little fuzzy because, like always, I don't know exactly how it will be used.
"
Class {
	#name : #LivingLibraryFeatures,
	#superclass : #TestCase,
	#category : #'LivingLibrary-Features'
}

{ #category : #'as yet unclassified' }
LivingLibraryFeatures >> testImportAcademicPaper [

	| library author title paper |
	library := LlLibrary new.
	author := MpPerson named: 'Ivan Edward Sutherland'.
	title := 'Sketchpad: A man-machine graphical communication system'.
	paper := LlAuthoredWork newAcademicPaper 
		title: title;
		author: author.
	library beAwareOf: paper.
	(library hasCardFor: paper) should be: true
]

{ #category : #'as yet unclassified' }
LivingLibraryFeatures >> testImportEBookIntoSystem [

	| library author1 author2 title ebook |
	library := LlLibrary new.
	author1 := MpPerson named: 'Matt Wynne'.
	author2 := MpPerson named: 'Aslak Hellesoy'.
	title := 'The Cucumber Book'.
	ebook := LlAuthoredWork newEBook
		title: title;
		authors: { author1. author2 }
		yourself.
	library beAwareOf: ebook.
	(library hasCardFor: ebook) should be: true
]

{ #category : #'as yet unclassified' }
LivingLibraryFeatures >> testImportElectronicWrittenWork [
	"Use case: I find an electronic document online. Now I find a quote in it that I want to remember. The important pieces to encode are the quote info (in this case author and content), and where I found it; namely this document, possibly including a page number.
	
	The text in this case is:

	'Nassim Taleb.
He writes about stock trading and risk. But I thought this quote was equally suitable for guys like you and me, when it
comes to getting better with women.
<double quote>Knowledge is reached by removing junk from people's heads.<double quote>'

	Simplisticly, what I'd like to have happen is to select the text and have the system try and figure out what to do with it. Remembering a quote is fairly common, and a template from this case is [author name]...[quote surrounded by double quotes].
	
	Now, what is this document in relation to the quote? It's a secondary source. I.e. it is not the place where the author issued the quote, but another document that is citing it. In this case, I do not know where the quote comes from, so it's almost not 'by' the author, but attributed to him.
	
	Let's try a feature:
		Given I find a quote in an electronic written document
		When I ask to remember it - which could mean for example selecting it and then choosing something from a context menu
		Then I sould see the quote - in this case a morph representing the quote in the world.
		
		There's a hole in the theory here. Ideally, everything I do would be experienced at the logical level, not the application implementation level. So the fact that I'm in a browser, dealing with a pdf is why so much work has to be done. So let me table this for a moment until I find another document. Although, I could just assume that"
]

{ #category : #'as yet unclassified' }
LivingLibraryFeatures >> testRetrievePdf [

	| pdfFile |
"	pdfFile := FileLocator imageDirectory / 'FDNY FE GUIDE Page 1.pdf'.
	copy := LLibraryCopy new
		work: (1);
		file: pdfFile;
		yourself.
	LivingLibrary instance receive:
	pdfFile exists should beTrue"
]

{ #category : #'as yet unclassified' }
LivingLibraryFeatures >> testTalebUseCase [
	"Use case: I find an electronic document online. Now I find a quote in it that I want to remember. The important pieces to encode are the quote info (in this case author and content), and where I found it; namely this document, possibly including a page number.
	
	The text in this case is:

	'Nassim Taleb.
He writes about stock trading and risk. But I thought this quote was equally suitable for guys like you and me, when it
comes to getting better with women.
<double quote>Knowledge is reached by removing junk from people's heads.<double quote>'

	Simplisticly, what I'd like to have happen is to select the text and have the system try and figure out what to do with it. Remembering a quote is fairly common, and a template from this case is [author name]...[quote surrounded by double quotes].
	
	Now, what is this document in relation to the quote? It's a secondary source. I.e. it is not the place where the author issued the quote, but another document that is citing it. In this case, I do not know where the quote comes from, so it's almost not 'by' the author, but attributed to him.
	
	Let's try a feature:
		Given I find a quote in an electronic written document
		When I ask to remember it - which could mean for example selecting it and then choosing something from a context menu
		Then I sould see the quote - in this case a morph representing the quote in the world.
		
		There's a hole in the theory here. Ideally, everything I do would be experienced at the logical level, not the application implementation level. So the fact that I'm in a browser, dealing with a pdf is why so much work has to be done. So let me table this for a moment until I find another document. Although, I could just assume that"
]
