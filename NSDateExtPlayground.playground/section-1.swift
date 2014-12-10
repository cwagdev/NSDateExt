import Foundation
import UIKit
import NSDateExt


NSDate.today().midnight
NSDate.tomorrow().midnight.shortDateString
NSDate.yesterday().endOfDay

NSDate().dateByAdding(.Years(-4)).shortDateString


NSDate().dateByAdding(units: TimeUnit.Days(1), TimeUnit.Hours(5))

NSDate.today() + .Days(5)
NSDate.today().midnight + 2.hours + 30.minutes + 5.seconds

NSDate.today().dateByAdding(units: 2.hours, 30.minutes)

let yesterday = NSDate.yesterday().mediumDateString


