//
//  ViewController.swift
//  notifications
//
//  Created by Twilio Developer Education on 10/14/17.
//  Copyright © 2017 Twilio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

// Replace this with the NGROK or permanent URL serving your application
  var serverURL = "https://YOUR_SERVER_URL/register"
  var message:String = "tap the button to receive push alerts when there are updates"
  @IBOutlet var registerButton: UIButton!
  @IBOutlet weak var messageLabel: UILabel!
    

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
        // set the message label text to either the default text or, if applicable, push alert text
        setMessageOnPush()
    
        // hide the button if the view is appearing after a push alert has been received
        if message == "tap the button to receive push alerts when there are updates" {
            registerButton.isHidden = false
        }
        else {
            registerButton.isHidden = true
        }
    }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func didTapRegister(_ sender: UIButton) {
    // fetch the device token and send it as the address param in the POST request to /register
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let deviceToken : String! = appDelegate.devToken
      registerDevice(deviceToken: deviceToken)
      resignFirstResponder()
  }

  
  func registerDevice(deviceToken: String) {
    // pass query params to our endpoint, including the deviceToken, which will be used to register push notifications from our app
    var components = URLComponents(string: serverURL)
    components?.queryItems = [
        URLQueryItem(name: "type", value: "apn"),
        URLQueryItem(name: "address", value: deviceToken),
        URLQueryItem(name: "tag", value: "ios-participant"),
    ]
    guard let url = components?.url else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {  // check for fundamental networking error
            print("error=\(String(describing: error))")
            return
        }
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {  // check for http errors
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(String(describing: response))")
        }
        let responseString = String(data: data, encoding: .utf8)
        print("responseString = \(String(describing: responseString))")
    }
    task.resume()
  }
    
    
    func setMessageOnPush(){
        // update the label to reflect notification text, hide button since the user has already registered
        messageLabel.text = message
        registerButton.isHidden = true
    }



}
