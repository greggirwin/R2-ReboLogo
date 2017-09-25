# R2-ReboLogo
Old Logo Turtle Experiment in R2

As I recall, since the first date in it is 2001, this was one of my first experiments used to learn `parse`.

Ah! I have some old notes in the project dir. From 2002. Time flies.

---

REBOLogo

===Introduction

I discovered REBOL sometime in August of 2001. I took at crack at my first real dialect, Logo, in October. It started working pretty quickly, then I figured out how to add user defined routines to the parser dynamically, and then it went on the shelf. It's got a bit of dust on it, probably wouldn't be a great basis for a real Logo implementation or anything, but there might be a useful nugget or two in there.

I'm not sure what I'll do with it, but I think it would be great to build a Logo system with REBOL. 

Important Note: I only tinkered with Logo a bit here and there, and have only implemented the Turtle part of things. I haven't attempted to match Logo syntax directly in some cases but that's an important thing to consider. Personally, I would rather see a clean-slate, very REBOLish, Logo *inspired* dialect. If you have any thoughts about that, just opinions or design considerations, please add them to this file.

Enjoy!

--Gregg


===Usage Notes and such

The main program contains the parser and world canvas face stuff. REBOLogo-progs.r contains a number of test Logo programs. Feel free to add more! The main script LOADs REBOLogo-progs.r and puts the name of each on in the text-list. Click on a program name to run it.

In REBOLogo-progs.r, each Logo program consists of a name and a block containing the program statements. Remember it's not standard Logo. I haven't written any docs for it yet. Sorry.

If the turtle seems to be walking slowly, it's probably because he's taking small steps.

Use "hide-turtle" and use "show-drawing false" if you have a complex drawing and you're impatient. Turn them back on at the end of your Logo program. The turtle and world do not reset automatically for each script you run.

Yes, the pen is always north-west of the turtle. Hey, I thought I was doing pretty good just making the turtle move his head around. :)

