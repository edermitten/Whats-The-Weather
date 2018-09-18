//
//  ViewController.swift
//  Whats the weather
//
//  Created by Eder Mitten on 9/17/18.
//  Copyright © 2018 Eder Mitten. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityTextfield: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func getWeather(_ sender: Any) {
        
        if let url = URL(string: "https://www.weather-forecast.com/locations/" + (cityTextfield.text!.replacingOccurrences(of: " ", with: "-")) + "/forecasts/latest"){
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            var message = ""
            
            if let error = error {
                print(error)
            } else {
                if let unwrappedData = data {
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    
                    var stringSeparator = "3 days)</span><p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                        
                        if contentArray.count > 1 {
                            
                            stringSeparator = "</span>"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            
                            if newContentArray.count > 1 {
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                print(message)
                            }
                            
                        }
                    }
                }
            }
            
            if message == "" {
                message = "The weather there couldn't be found. Please try again."
            }
            DispatchQueue.main.sync(execute: {
                self.resultLabel.text = message
            })
        }
        
        task.resume()
            
        } else {
            resultLabel.text = "The weather there couldn't be found. Please try again."
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

