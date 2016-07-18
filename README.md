# Pre-work - tippy
tippy is a tip calculator application for iOS.

Submitted by: Phil Nachum

Time spent: 6 hours spent in total

## User Stories

The following **required** functionality is complete:
* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:

* [x] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] Allowing the user to change the tip percentage options, and remembering it across app restarts
- [x] Light/dark theme option, and remembering it across app restarts

## Video Walkthrough

Here's a walkthrough of implemented user stories:

### Main screen
<img src='http://g.recordit.co/WjIGhUzGBi.gif' title='Main screen' width='' alt='Main screen' />

### Save default tip
<img src='http://g.recordit.co/uPLsOfBo2b.gif' title='Save default tip' width='' alt='Save default tip' />

### Save bill amount
<img src='http://g.recordit.co/qjY2Uq2gLj.gif' title='Save bill amount' width='' alt='Save bill amount' />

### Different locale
<img src='http://g.recordit.co/HqJulEIbUA.gif' title='Different locale' width='' alt='Different locale' />

### Change tip options
<img src='http://g.recordit.co/T9uVR7jT3k.gif' title='Change tip options' width='' alt='Change tip options' />

### Light/dark theme
<img src='http://g.recordit.co/XSdFGzsf8E.gif' title='Light/dark theme' width='' alt='Light/dark theme' />

GIF created with RecordIt.

## Notes

- For some reason, `view.endEditing(true)` on the settings page would crash the app, so I left it commented out

## License

    Copyright [2016] [Phil Nachum]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
