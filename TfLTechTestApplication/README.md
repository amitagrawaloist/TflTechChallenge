#  TfLTechtestApplication
This is TfL Road Status application. We have used a public TfL API for network calls and fetched Road Status.


## Project Description
The application has one screens (TfL Road Status).

Road Status Screen : It gets the current status of the entered road/location from server and display the status in table cell. We have a SearchBar to freely enter the location & search it's current status.

Entry point of the application : RoadStatusViewController

API URL : https://api.tfl.gov.uk/Road/A2?app_key=<TfL_APP_KEY>

Unit Tests for Jailbreak, Road Status API, Success & Failure responses and RoadSatusViewController.

Application has a Jailbreak check.

Application has 2 targets TflTechTestApplication & TflTechTestApplicationPROD respectevly for - 
        ○ Dev Builds - 
            App Display Name: Road Status DEV
            Build Config: debug
        ○ PROD Builds - 
            App Display Name: TfL Road Status
            Build Config: release

## Note for Jailbreak check
Inside UIDevice+Jailbroken.swift file, return value for the method checkisDeviceJailBrocken() must be true for real device testing.
Currently Application will work for iOS Simulator.

## Note for app_key
Please insert the developer app_key into the Constants.swift under the Struct "APIKey" for property "primaryKey".
Below is the code snippet to make changes -
struct APIKey {
  static let primaryKey = ""
  static let secondaryKey = ""
}        
Please note that application is using primaryKey property to supply app_key in the API call.

## Technical Features
* MVVM architecture

* Network API calls

* Autolayout


## Tech Details
* Language : Swift 5

* iOS Deployment Target : 16.2

* Xcode version : 14.2

* Unit testing Framework : XCTest

* Application Orientation : Portrait


## Final Branch
* main branch (Xcode Managed)

