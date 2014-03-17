OSSpritz
========
![image](osspritz-video-short.gif)

An open-source implementation for iOS of the reading system developed by Spritz INC. The aim of this project was to port the functionality of the javascript implementation [OpenSpritz](https://github.com/Miserlou/OpenSpritz).

Installation
--------------

OSSpritz can be installed by copying the files inside the *OSSpritz* directory.

There is also a *OpenSpritzDemo/OSSpritz.podspec* **podspec file** you can easily add OSSpritz to your project adding this line to your Podfile:

	pod "OSSpritz", :podspec => "https://raw.github.com/Fr4ncis/openspritz-ios/master/OpenSpritzDemo/OSSpritz.podspec"
	
We will soon fully support Cocoapods to provide an even easier method to integrate it in your project.

Getting started
---------------

After importing the needed files, you just need an OSSpritzLabel object, which manages a text and the reading mechanism.

The OSSpritzLabel can either be instantiated **programmatically**:

	    OSSpritzLabel *osLabel = [[OSSpritzLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
	    
or **inside a nib file** by creating in Interface Builder a UIView and then in third tab on the right panel (Identity inspector) setting the *Custom class* parameter as *OSSpritzLabel*.

Don't forget to use either `#import "OSSpritzLabel.h"` or `#import <OSSpritzLabel.h>` (when using Cocoapods) in the classes referencing the OSSpritzLabel object.

### How to use it

The interface is really straightforward:

	@property (nonatomic, strong) NSString *text;
	@property (nonatomic, assign) int wordsPerMinute;

	- (void)start;
	- (void)pause;
	
You first need to set the text to be read.

	    osLabel.text = @"This is the text I want to be read."
	   
Then you can start it:

		[osLabel start];

The reading speed can be adjusted on-the-fly by setting *wordsPerMinute*. You can pause anytime by using `pause` and restart when it's over by using `start` again.

Technical details
-----------------

The library has been written using ARC. It can still be used on non-ARC projects by enabling the `-fobj-arc` compiler flag on openspritz classes (OSSpritz.m and OSSpritzLabel.m).

The library supports **iOS 7 only** but it should be easily backported to iOS 5/6 by replacing `[@"m" sizeWithAttributes:@{NSFontAttributeName:font}]`.

Demo Project
------------
You don't need to import OpenSpritzDemo project, but it's a good start to understand how to use the library.

Contributors
------------

This is an open-source project, feel free to contribute to the project. I would like to thank [rmirabelli](https://github.com/rmirabelli) for his early contribution.

Considerations & Donations
--------------------------

This started as an hobby project, with no intent to piss off the guys at **Spritz Inc.**. My main goal is to learn how to lead an open-source public project, so it's more of a learning experience than anything else. I hope you appreciate the effort ;)

If you want to get some specific features implemented first or you need help to set it up in your own project, [get in touch](mailto:ego@fr4ncis.net).

To speed-up development [donations](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=YGWQ2AVJHZVVE) are very welcome.
