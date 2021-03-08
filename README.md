[![Alt text](https://i.imgur.com/8PAXG61.jpg)](https://apps.apple.com/us/app/dots-the-bill-splitter/id1553039795)

# Dots - The Bill Splitter 
[![Build Status](https://api.travis-ci.com/cs130-w21/dots-ios.svg?branch=master)](https://travis-ci.com/cs130-w21/dots-ios) [![codecov](https://codecov.io/gh/cs130-w21/dots-ios/branch/master/graph/badge.svg?token=hk3Sg8VO6p)](https://codecov.io/gh/cs130-w21/dots-ios) ![Release](https://img.shields.io/github/v/release/cs130-w21/dots-ios?label=release)

Dots - The Bill Splitter is a simple tool in bill splitting scenarios when it comes to unequal bill sharing. Also supports multiple bills balance calculation!
> Split bills with many friends has never been this easy!


<a href="https://apps.apple.com/us/app/dots-the-bill-splitter/id1553039795?itsct=apps_box&amp;itscg=30200" style="display: inline-block; overflow: hidden; border-top-left-radius: 13px; border-top-right-radius: 13px; border-bottom-right-radius: 13px; border-bottom-left-radius: 13px; width: 250px; height: 83px;"><img src="https://tools.applemediaservices.com/api/badges/download-on-the-app-store/black/en-US?size=250x83&amp;releaseDate=1614384000&h=f329641ed526ea427f635cba519350ae" alt="Download on the App Store" style="border-top-left-radius: 13px; border-top-right-radius: 13px; border-bottom-right-radius: 13px; border-bottom-left-radius: 13px; width: 250px; height: 83px;"></a>






## Features

- Uneven bill split calculation
- **Multiple** bills balance calculation 
- Access to all history bills (unless deleted)
- FaceID/TouchID can be enabled to further protect your data
- Sort by creditor
- Hide/Unhide bills that are marked as "paid"
- Simplified add and remove process
- and more...

## Compatibility

- iPhone - Requires iOS 14.0 or later.
- iPad - Requires iPadOS 14.0 or later.
- iPod touch - Requires iOS 14.0 or later.
- Mac - Requires macOS 11 or later and a Mac with Apple M1 chip.

## Trigger Test build
### Online Test build with TravisCI
Go to our [TravisCI Project](https://travis-ci.com/github/cs130-w21/dots-ios) and click "restart build" to trigger a test build.

### Local Testing
First, download our repo and change directory
```
git clone https://github.com/cs130-w21/dots-ios.git
cd dots-ios
```

**Important**: Make sure you have XCode 12 installed to support iOS 14 or later simulators!
Trigger the test build scheme with the following command
```
xcodebuild -project Dots/Dots.xcodeproj -scheme Dots -destination 'platform=iOS Simulator,name=iPhone 12,OS=14.2' build test
```
If the above script does not work because of the version issue, replace `OS=14.2` with your simulator versions provided on the screen. (At least iOS 14)

A test build should be triggerred by now. Wait a few minutes to see the test results. If there are any failures or questions, please submit an issue!

## Privacy Policy
**We respect user's privacy. All user data are stored properly on the device locally and will not be collected.**

[Learn more](https://github.com/cs130-w21/dots-ios/wiki/Privacy-Policy)

## Gallery
<img src="https://i.imgur.com/8dqINhC.png" width=350> <img src="https://i.imgur.com/qHhQl2W.png" width=350> 

<img src="https://i.imgur.com/CggCnYF.png" width=350> <img src="https://i.imgur.com/4U9NRbD.png" width=350>

![multi-device](https://i.imgur.com/z2DXm82.png)

<img src="https://i.imgur.com/o83fehZ.gif" width=350>

