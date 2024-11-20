# Limitless
An iOS framework that crashes the app it is injected into after 5 minutes.

## Compatibility
Any iOS/iPadOS device running iOS 9 or later

## Usage
You can inject Limitless into any iOS app (Some apps may have sideloading protection tho). After the app is launched, Limitless will crash after 5 minutes.

To inject Limitless, you can use tools like [Sideloadly](https://sideloadly.io/) if you have a PC, or [Feather](https://github.com/khcrysalis/Feather), ESing or any other iPA installer that supports frameworks injection:

### Sideloadly Process:

1. Download the IPA of the application.
2. Download the latest release of Limitless: [here](https://github.com/cranci1/Limitless/releases).
3. Extract the downloaded .zip file.
4. Open Sideloadly and select the IPA to install.
5. Click on "Advanced Options".
6. Check the "Inject dylibs/frameworks" option.
7. Click on "+framework" and drag Limitless.framework.
8. Now you can sideload your app with Limitless integrated.

![Sideloadly](images/sideloadly.png)

## Why?
Honestly, I don't know either. I created this to see if it would cure my Instagram Reels addiction. And also, I wanted to create an iOS framework for the first time, and this was pretty simple to make.