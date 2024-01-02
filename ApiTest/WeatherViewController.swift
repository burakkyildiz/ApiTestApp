//
//  WeatherViewController.swift
//  ApiTest
//
//  Created by Burak on 2.01.2024.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    let apiKey = "11f9e6ff104c3dea350cf01561d7059a"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func showButtonClicked(_ sender: Any) {
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=37.871845&lon=32.492513&appid=\(apiKey)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, url, error in
            
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OKAY", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                if data != nil{
                    do{
                        let jsonResponse =  try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any]
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse!["main"] as? [String : Any]{
                                if let temp = rates["temp"] as? Double{
                                    self.tempLabel.text = "TEMP: \(Int(temp - 272.15))"
                                }
                                if let feelsLike = rates["feels_like"] as? Double{
                                    self.feelsLikeLabel.text = "FEELS LIKE: \(Int(feelsLike - 272.15))"
                                }
                                if let min = rates["temp_min"] as? Double{
                                    self.minLabel.text = "MIN: \(Int(min - 272.15))"
                                }
                                if let max = rates["temp_max"] as? Double{
                                    self.maxLabel.text = "MAX: \(Int(max - 272.15))"
                                }
                                if let pressure = rates["pressure"] as? Double{
                                    self.pressureLabel.text = "PRESSURE: \(Int(pressure))"
                                }
                                if let humidity = rates["humidity"] as? Double{
                                    self.humidityLabel.text = "HUMIDITY: \(Int(humidity))"
                                }
                            }
                            if let city = jsonResponse!["name"] as? String{
                                self.cityLabel.text = "CITY:\(city)"
                            }
                        }
                    }catch{
                        print("error")
                    }
                }
            }
        }
        task.resume()
      
        
    }
    
}
