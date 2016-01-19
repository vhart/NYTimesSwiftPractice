# NYTimesSwiftPractice

This app uses Alamofire to query the New York Times' best sellers list for fiction

Clicking a book title will send you to a detail page where the book cover image is loaded async 
using GCD and then sent back on the main thread

Once the completion closure is hit with the image, the image is sent forward to the detail page using
Notification Center and the image is sent backwards to the first page using delegation. 

Tap on image to launch SFSafariViewController from Safari framework. Browser take you to the book's amazon link.

Tests are included for async methods
