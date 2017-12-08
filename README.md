# MacOsTwistSearchClient
Twist API MacOS Example App

## Description
Twist Search Client is an example MacOS app consuming [Twist Developer API](https://api.twistapp.com/v2/). It showcases 2 basic functionalities: login and search.

## Build & Run
To build and run an app, run `pod install`, open up `TwistSearchClient.xcworkspace` and Run from Xcode. 
In debug environment, you can prefill credentials by creating `Credentials.plist` file in the workspace and defining values for "email" and "password" keys in it.

## Dependencies
This project is using RxSwift, RxCocoa and CoreData for persistent storage.
