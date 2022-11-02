# NY Times Articles
 _App shows popuplar NY Times articles in a list, once tapped a specific article it will show the article details on next screen and one can also read the full article on NY Times website in the app by tapping on the button "Read full article"_
 
 _Supported both light and dark modes_

## Architecture

MVVM with Coordinator pattern

## Coding practices

Used SOLID principles with Swift best practices and style guidelines

## Unit tests

Business logic(View Models) are covered with unit tests. You can run the unit tests manually from **(Product menu > Test)** or with shortcut key **(⌘ - command +  U)**

## Code coverage report

Code coverage is enabled in the scheme and now when you run Tests the coverage report will be generated and can be seen under the Reports navigator.  **(View menu > Navigators > Reports or ⌘ - command + 9)**

After you open it, under the latest Test report, you should find a Coverage report, click on that, and it will contain the coverage information of that test run.

## Fastlane

Integrated with fastlane to speedup and automate some tasks even without opening the Xcode. 
Written 2 scripts in the Fasfile for these below task:

#### 1) Uploading build to testflight
This task actually involves these steps:
1) Increament the build number
2) Build the project and generate an archive
3) Uploading it to testflight

Lane for this task is **'pushToTestflight'** you just have to open the terminal and move to the project directory and then run this command:

```sh
fastlane pushToTestflight
```

#### 2) Run unit tests

This will run your tests and show the report when it gets completed so you can get to know which tests are failing and which are passing.

Lane for this task is **'runTests'** you just have to open the terminal and move to the project directory and then run this command:

```sh
fastlane runTests
```

