# NHActivityViewController

<table>
                                                         <tr>
		<th>iOS 6.x</th>
		<th>iOS 5.x</th>
	</tr>
	<tr>
		<td><img src="Screenshot-iOS6.png" alt="Screenshot under iOS 5.x" width="320"></td>
		<td><img src="Screenshot-iOS5.png" alt="Screenshot under iOS 6.x" width="320"></td>
	</tr>
</table>

> [NHActivityViewController](https://github.com/nrcmedia/NHActivityViewController) reimplementation of UIActivityViewController for iOS5. It was originally based on  [OWActivityViewController](https://github.com/brantyoung/OWActivityViewController) and has no external dependencies, but if you have the Facebook SDK included, it shows the share to Facebook button.

> Out of the box activities include:

> * Twitter
* Message
* Mail
* Save to Album
* Print
* Copy
* Facebook (requires Facebook SDK to be added to your project)

> All activites are compatible with iOS 5.0.

## Requirements
* Xcode 4.5 or higher
* Apple LLVM compiler
* iOS 5.0 or higher
* ARC

## Demo

After that, build and run the `OWActivityViewControllerExample` project in Xcode to see `OWActivityViewController` in action.

## Installation

`NHActivityViewController` needs to be linked with the following frameworks:

* AssetsLibrary
* MessageUI

The following framework must be added as optional (weak reference):

* Social
* Twitter

When you add the Facebook SDK to your project the Facebook share will become available on iOS5

## Example Usage

> TODO

## Known Issues

* NHActivityViewController doesn't support landscape orientation on iPhone, so you'll need to lock your presenting view controller in portrait orientation.
* Facebook integration on iOS5 is not supported yet

## Contact

Niels van Hoorn

- https://github.com/nvh

## Acknowledgement

Brant Young

- https://github.com/brantyoung

Roman Efimov

- https://github.com/romaonthego
- https://twitter.com/romaonthego
- romefimov@gmail.com

## License

NHActivityViewController is available under the MIT license.

Copyright (c) 2013 Niels van Hoorn (http://github.com/nvh).
Copyright (c) 2013 Brant Young (http://github.com/brantyoung).
Copyright (c) 2013 Roman Efimov (http://github.com/romaonthego).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
## Used in App

* Oneword ArtBible
  <a href="https://itunes.apple.com/app/yi-ju-hua-sheng-jing/id643595493?mt=8&uo=4" target="itunes_store"><img src="http://r.mzstatic.com/images/web/linkmaker/badge_appstore-lrg.gif" alt="一句画 · 圣经 - Oneword" style="border: 0;"/></a>
