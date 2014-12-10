# Installation
1. Drag `NSDateExt.swift` to your project

# Usage

## Creating and manipulating dates

`let yesterday = NSDate.yesterday()
let twoWeeksFromYesterday = yesterday + 2.weeks`

## Comparing dates

`yesterday.isToday // false
yesterday.isYesterday // true`

## Displaying dates
`yesterday.mediumDateString // "Dec 9, 2014"`