OculusRiftSceneKit
==================

Brad Larson

http://www.sunsetlakesoftware.com

[@bradlarson](http://twitter.com/bradlarson)

contact@sunsetlakesoftware.com

## Overview ##

These are a series of classes that add Oculus Rift VR headset support to Scene Kit, as well as at least one sample application to show them in action. These Objective-C classes encapsulate the stereoscopic 3-D rendering required for the Rift, as well as the head tracking it provides. This should hopefully make it pretty easy to rig up virtual reality scenes using Scene Kit's Objective-C API.

<div style="float: right"><img src="http://sunsetlakesoftware.com/sites/default/files/SceneKitOCVR.jpg" /></div>

## License ##

BSD-style, with the full license available with the framework in License.txt.

The Oculus Rift SDK and libraries are covered by their own license, which can be found in the LibOVR directory.

## Usage ##

To use this in a Scene Kit project, you'll need to add the OculusRiftDevice, OculusRiftSceneKitView, and GLProgram classes to your project. 

Configure a window that goes fullscreen with an OculusRiftSceneKitView within it. This class will handle the rendering and head tracking for you. To set up your scene, create an SCNScene containing whatever you want to display in your environment and set that to the scene property on your OculusRiftSceneKitView instance. These classes will handle the rest. You can adjust the position of the head within the scene using the headLocation property on OculusRiftSceneKitView, and the spacing of the virtual eyes using the interpupillaryDistance property.

You'll also need to add the OVR.h and OVRVersion.h headers from LibOVR to your project, and link against the libovr.a library. Finally, I found that I needed to add the -fno-rtti compiler flag to OculusRiftDevice.mm in the Compile Sources build phase to get it to build cleanly.

Again, check out the test application in the examples/ directory to see this in action.

## Acknowledgments ##

I'd like to thank Mike Rotondo and Luke Iannini for their help in solving some of the perspective projection problems. Check out their much more elaborate Oculus Rift and Scene Kit project for more: 

https://github.com/takataka/OpenWorldTest

I've also drawn a good chunk of code from Jeff LaMarche's excellent introduction to Scene Kit, which is well worth reading:

http://iphonedevelopment.blogspot.com/2012/08/an-introduction-to-scenekit.html