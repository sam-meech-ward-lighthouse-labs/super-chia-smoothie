## Server

* what is a serv3r?
  - software running on a computer that acts as a server.

##  Parse

* Used to be a great backend for mobile devs.
* Facebook purchased parse.
* Facebook closed down parse.
* Facebook open sourced parse.

* Parse server, or firebase or whatever other platforms as a service are good options for a backend for a mobile dev. 

## Parse in iOS

1. Add `pod 'Parse'`
2. Authenticate with parse server:

```swift
// Initialize Parse
let configuration = ParseClientConfiguration { clientConfiguration in
  clientConfiguration.applicationId = "YOUR_APP_ID"
  clientConfiguration.server = "URL_TO_YOUR_PARSE_SERVER"
}
Parse.initialize(with: configuration)
```

3. Party. Start persisting data.

https://docs.parseplatform.org/ios/guide

---

## Links

* Setup parse server https://github.com/lighthouse-labs/Parse-Server-For-Students
* JS https://github.com/meech-ward/Javascript-For-iOS-Developers

## Snippets

```swift
// Initialize Parse
let configuration = ParseClientConfiguration { clientConfiguration in
  clientConfiguration.applicationId = "YOUR_APP_ID"
  clientConfiguration.server = "URL_TO_YOUR_PARSE_SERVER"
}
Parse.initialize(with: configuration)
```