BizzareDelay
============

***Please read this file before continuing***

BizzareDelay VST/AU Plug-in.

This is a plug-in developed for BizzareContact, a psytrance project from Israel. It is now completely free. 
https://www.facebook.com/BizzareContactMusic

I developed this in 2011, so it's quite old and there are many things that could be improved, however I quite like the plug-in
and have been using it as my main delay plug-in for my music. 

It simulates two delay racks in one: the top one is a straightforward stereo delay with independent controls for each delay. The top one
is designed to Bizzare's specification and it's a saturating tape delay that allows real time control of the delay time on a fine level
for weird psychedelic effects. Even though it's possible to change the delay on a fine level, the fine control still snaps to a full
tempo unit halfway along its range, so it's tempo synced if required.

It is written using Oli Larkin's WDL-OL framework (based on Cockos's IPlug). You need to set it up properly to compile, which is not difficult.

Credits: 
Bogdan Vera - Code, Design
Matt O'Neill - Graphics, Business

***HOW TO COMPILE***

You need to set-up WLD-OL as described by Oli Larkin:
https://github.com/olilarkin/wdl-ol

Unfortunately this means you need to use Xcode 4.2, which means you need to run an older version of OSX. It seems the framework has not been updated recently, and I haven't been able
to recompile the binaries. Will need to get in contact with Oli about this. The old versions I made in 2011 are still online however. At the moment the project will compile correctly in VC++ Express however.

The BizzareDelay project folder is meant to sit somewhere inside the wdl-ol folder, or you can put it somewhere else but make sure you set up your include folders properly. 

You need Visual C++ Express 2010 to compile on Windows. Note also that this was designed for a version of IPlug from 2011 so things
may have changed in the framework since then, so this and that may not work as expected.
