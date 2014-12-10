# Installation
1. Drag [`NSDateExt.swift`](https://github.com/cwagdev/NSDateExt/blob/master/NSDateExt/NSDateExt.swift) to your project

# Usage

## Creating and manipulating dates

```swift
let yesterday = NSDate.yesterday()
let twoWeeksFromYesterday = yesterday + 2.weeks
```

## Comparing dates

```swift
yesterday.isToday // false
yesterday.isYesterday // true
```

## Displaying dates
```swift
yesterday.mediumDateString // "Dec 9, 2014"
```
