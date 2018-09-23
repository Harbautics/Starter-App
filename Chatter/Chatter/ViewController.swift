//
//  ViewController.swift
//  Chatter
//
//  Created by Alexis Opsasnick on 9/21/18.
//  Copyright © 2018 Haurbautics. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class ChattTableViewController: UITableViewController {
    
    var chatts = [Chatt]()
    func refreshChatts() {
        let requestURL = "http://159.203.172.151/getchatts/"
        var request = URLRequest(url: URL(string: requestURL)!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
            print("NETWORKING ERROR")
            return }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("HTTP STATUS: \(httpStatus.statusCode)")
                return }
            do {
                var newChatts = [Chatt]()
                let json = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                let chattsReceived = json["chatts"] as? [[String]] ?? []
                for chattEntry in chattsReceived {
                    let chatt = Chatt(username: chattEntry[0], message: chattEntry[1], timestamp: chattEntry[2])
                    newChatts += [chatt]
                }
                self.chatts = newChatts
                self.tableView.estimatedRowHeight = 140
                self.tableView.rowHeight = UITableViewAutomaticDimension
                self.tableView.reloadData()
            }
            catch let error as NSError {
                print(error) }
        }
        task.resume() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

class ComposeViewController: UIViewController {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func submitClicked(_ sender: Any) {
        
        let json: [String: Any] = ["username": self.usernameLabel.text ?? "NULL", "message": self.messageTextView.text ??
            "I wrote a blank message, oops!"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url:
            URL(string: "http://159.203.172.151/addchatt/")!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            guard let _ = data, error == nil else {
                print("NETWORKING ERROR")
                return
            }
            if let httpStatus = response as? HTTPURLResponse,
                httpStatus.statusCode != 200 {
                print("HTTP STATUS: \(httpStatus.statusCode)")
                return }
        }
        task.resume()
        
        dismiss(animated: true, completion: nil)
    }
}

