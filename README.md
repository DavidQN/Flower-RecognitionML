# Flower Recognition

This IOS application determines the type of flower that the user has taken a
picture of using Machine Learning. The ML model is built off of the 102 Oxford flower dataset, which you can check out [here](http://www.robots.ox.ac.uk/~vgg/data/flowers/102/).

## Getting Started

These instructions will get you a copy of the project up and running on your
local machine for development and testing purposes. See deployment for notes on
how to deploy the project on a live system.

This application can only be run on IOS and MUST be connected to the Mac you are
using since the Xcode simulator does not allow for camera usage and will throw
errors if you try to do so.

### Prerequisites

What software/hardware you will need as well as what you will need to install:

* MacOS Sierra Version 10.12.6 OR MacOS High Sierra
* Xcode 9.2 (latest version)
* Apple/Itunes account (to setup xcode developer account)
* IPhone (with IOS version 11.2 THIS IS VERY IMPORTANT)
* Cocoapods (latest version)

### Installing

When you have all the software and hardware in their correct versions the rest
is rather simple

Step 1:

Make sure you are in the terminal in the right directory after git cloning

```
Flower-Recognition
```

Step 2:

```
pod install
```

Step 3:

```
open .
```

Step 4:

You will be displayed a finder window, double click file

```
Flower-Recognition.xcworkspace
```

This should display the Xcode editor

Step 5:

Connect your iPhone to your Mac

Step 6:

On the top left of the screen is a play button, you will then see the name of
the file and the device name. Click on it and you will see a dropdown, if your
phone is connected to the Mac you should see your device.

Step 6.5:

If this is your first time connecting your device, RIP. You will have to set up
your iPhone. Always allow when prompted and follow instructions displayed. It
should fail the first time. There are many videos online in how to get through
this.

Step 7:

Click the play button on the top left of the Xcode editor and it should build
give it some time

Step 8:

When it is done building check your iPhone and you should have the app, go and
take pictures of flowers and see what you get!

Step 9:

You no longer need to be connected to your Mac since the iPhone now has that
app. Have fun!

## Built With

* Swift
* Python
* CocoaPods - Package manager
* coreML
