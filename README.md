# MacOsTwistSearchClient
Twist API MacOS Example App

## Description
**Twist Search Client** is an example MacOS app consuming [Twist Developer API](https://api.twistapp.com/v2/). 

It showcases 2 basic functionalities: login and search.

## Build & Run
To build and run an app, run `pod install`, open up `TwistSearchClient.xcworkspace` and Run from Xcode. 

In debug environment, you can prefill credentials by creating `Credentials.plist` file in the workspace and defining values for *"email"* and *"password"* keys in it.

## Dependencies
This project is using:
* *RxSwift* and *RxCocoa* for defining observable streams and reactive programming.
* *CoreData* for persistent storage.

## Implementation details
* This project is built using *Model-View-ViewModel* architecture. 
* `NavigationService.swift` is a component in charge of presenting views and dependency injection.
* `CoreDataWrapper.swift` is a convenience wrapper for updating and fetching from *CoreData*.
* `Login.swift`is a service provider that handles login functionality.
* `Twist.swift`is a service provider that handles core functionalities for users.

## Todos
This excersize was limited to 12h so there are few things I'd add if I had more time:
* `CoreDataWrapper.swift` uses main thread `viewContext` for all operations which is good enough for this case due to not-too-big updates, but I'd use background context for updates and set up observers on `viewContext`.
* `SearchResult` entity should be an abstraction of all the different results we can get (*thread*, *conversation*), but I wasn't aware of this at first.
* Most of these functionalities are pretty straightforward, but I would test lower levels, especially parsers.
* This my first MacOS app so it took me a while to figure out how to work with windows and views and I wish I had more time to polish UI appereance or logic.
