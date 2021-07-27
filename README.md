# Overview

## What is a library?

A library is a place to find and read books... Oh wait, they have music too... Oh wait, they also have DVDs... Oh wait, sorry, they also have computers to look things up... and old newspaper captures and...

You get the point.

Even in the real world, a library is a fluid concept, especially as more technology and formats have come along.

Here, in the magical virtual world, the possibilities are exponentially more.

## A _Living_ Library

We define a `library` as a place where one can find `copies` of `authored works`

### Common Actions

#### Choose a library

A default library is provided:

```smalltalk
LlLibrary uniqueInstance
```

# Installation

```smalltalk
EpMonitor current disable.
Metacello new
	baseline: 'LivingLibrary';
	repository: 'github://seandenigris/Living-Library';
	load.
EpMonitor current enable.
```

# Disclaimer

This project is part of a ~20 year (as of 2021) exploration of Alan Kay's Dynabook idea. It's intensely personal and opinionated and I've open sourced it due to repeated requests. Use at your own risk. Any part may change at any time. I'm happy to give support when I have time in the form of explanations, but do not expect me to implement any particular feature, or even accept PRs if they don't feel right. That said, I'm happy to have anyone along on the journey :)

# License Explanation

My original intent was to release my Dynabook libraries under a copy far left license (free use for cooperatives, but negotiated licenses for those utilizing paid labor for profit). I love sharing any work I do, but am disgusted by the propect that (especially multi-billion-dollar) corporations will exploit my work for free, especially toward ends with which I don't philosophically agree. However, after many discussions with colleagues, it appears that at this moment there is just no way to protect one's work from parasites without effectively keeping it from everyone. Even GPL, which doesn't even come close to "solving" the problem stated above, seems enough to put off most people. In closing, now that my intentions are clear, I request the following from any entity utilizing wage labor or selling for profit who uses my work:

1. Attribution
2. Pay for what you use, or don't use it

While there may be no legal means for me to enforce the above given that this code is released under MIT, my intentions should be clear; violate the above at risk to your own conscience.
