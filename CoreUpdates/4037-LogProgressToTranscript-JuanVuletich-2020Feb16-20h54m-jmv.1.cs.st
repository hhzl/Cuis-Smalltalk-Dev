'From Cuis 5.0 [latest update: #4035] on 16 February 2020 at 9:01:19 pm'!

!String methodsFor: 'displaying' stamp: 'jmv 2/16/2020 20:59:55'!
displayProgressAt: aPoint from: minVal to: maxVal during: workBlock
	"Display this string as a caption over a progress bar while workBlock is evaluated.

EXAMPLE (Select next 6 lines and Do It)

'Now here''s some Real Progress'
	displayProgressAt: Sensor mousePoint
	from: 0 to: 100
	during: [:barBlock |
		1 to: 100 do: [:x | 
			(Delay forMilliseconds: 10) wait.
			barBlock value: x.]].

['Now here''s some Real Progress'
	displayProgressAt: Sensor mousePoint
	from: 0 to: 100
	during: [:barBlock |
	1 to: 100 do: [:x | barBlock value: x.
			(Delay forMilliseconds: 100) wait]].] fork
	
['Now here''s some Real Progress'
	displayProgressAt: Sensor mousePoint
	from: 0 to: 10
	during: [:barBlock |
	1 to: 30 do: [:x | barBlock value: x \\ 11.
			(Delay forMilliseconds: 100) wait]]] fork

'Now here''s some Real Progress'
	displayProgressAt: Sensor mousePoint
	from: 0 to: 10
	during: [:barBlock |
	1 to: 30 do: [:x | barBlock value: nil.
			(Delay forMilliseconds: 200) wait]].

HOW IT WORKS (Try this in any other language :-)
Since your code (the last 2 lines in the above example) is in a block,
this method gets control to display its heading before, and clean up 
the screen after, its execution.
The key, though, is that the block is supplied with an argument,
named 'bar' in the example, which will update the bar image every 
it is sent the message value: x, where x is in the from:to: range.

The use of ProgressInitiationException allows for avoiding actual
progress display, by catching the exception.
"
	| answer duration |
	Transcript show: self; show: '...'.
	duration _ [
		answer _ ProgressInitiationException 
			display: self
			at: aPoint 
			from: minVal 
			to: maxVal 
			during: workBlock] durationToRun.
	Transcript show: ' done. Took '; show: duration printString; newLine.
	^answer! !

