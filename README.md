# KeyPathMacroTestApp
Kind of Objective-C version of Swift 3's #keyPath

## TL;DR
````
#define keyPath(base, path) ({ __typeof__(base.path) _ __attribute__((unused)); @#path; })
````
## What is Swift 3's #keyPath?
\#keyPath expression makes key paths for KVO be strongly-typed over stringly-typed.
(Reference: [Swift API Design Guidelines](https://developer.apple.com/videos/play/wwdc2016/403/), [SE-0062](https://github.com/apple/swift-evolution/blob/master/proposals/0062-objc-keypaths.md), [Favorite Swift 3.0 Features](http://swift.ayaka.me/posts/2016/6/18/favorite-swift-30-features))

## What is this repo about?
I [tweeted](https://twitter.com/keitaitok/status/744401634734678016) that I wish #keyPath existed in Objective-C. [Joe Groff](https://twitter.com/jckarter) told me [an awesome macro](https://twitter.com/jckarter/status/744405112756416512) equivalent to this expression.
The macro he told me is `#define keyPath(base, path) ({ __typeof__(base.path) _; @#path; })`.

This repo is a Xcode project that I implemented and tested out the macro. 
I changed the macro a little bit to get rid of a Xcode's warning saying unused variable by adding `__attribute__((unused))`. 

## Environment
The Xcode project is created with Xcode Version 8.0 beta (8S128d). Watch out storyboard settings and Objective-C's Generics type. These new changes would cause this project not to be able to work on Xcode 7.

