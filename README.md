# Multichannel Notifications with Swift and Twilio

This application extends [Multichannel Notifications with Sinatra and Twilio](https://github.com/TwilioDevEd/notify-flashmob-sinatra/) to allow users to subscribe to native Apple push notifications (APN) from the Flash Mob app featuring Twilio Notify.

### Set up the server app
Before we begin, you will need to set up the Flash Mob server app to communicate with this mobile app.

Follow the directions in the README for the Ruby app, and get the web client up and running. 

You'll need to test this on the device, since the iOS simulator can't receive notifications. To test on a device, your server will need to be on the public Internet. For this, you might consider using a solution like [ngrok](https://ngrok.com/).

### Set up push credentials
You'll need to go through some steps to set up push credentials for iOS. Follow the instructions in [this guide to setting up push credentials for Notify](https://www.twilio.com/docs/api/notify/guides/configuring-ios-push-notifications) before proceeding.   

### Configure the client 
In the ViewController.swift file, on this line,

    var serverURL : String = "https://YOUR_SERVER_URL/register"

Replace `YOUR_SERVER_URL` with the address of your server (ngrok or permanent). 


The app passes your device's device token as the `address` param in its request to the `/register` endpoint in the server app. This unique identifier is then used by Twilio Notify (along with a generated identity and the binding type `apn`) to create a binding.


Once you've entered your URL, you can compile and run the app on a device. Once you tap register, the app will register your device with APNS and return a JSON response object if successful. After that, visit the Notify page on your server web application, and send a notification to the identity you registered as to receive a push notification in your app.

That's it!

## Meta
* [MIT License](http://www.opensource.org/licenses/mit-license.html)
* Lovingly crafted by the Twilio Developer Education team ❤️
