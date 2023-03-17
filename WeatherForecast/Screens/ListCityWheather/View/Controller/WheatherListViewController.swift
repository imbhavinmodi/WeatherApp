//
//  WheatherListViewController.swift
//  WeatherForecast
//
//  Created by Bhavin's on 15/03/23.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire

struct Response: Codable {
    let test : String
   
}

class WheatherListViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    
    var dictWheatherData = [String:Any]()
    var arrayWheatherData = [Any]()

    var selectedLocation: AnyObject? = nil
    var currentLocation: AnyObject? = nil

    // MARK: - Outlets
    @IBOutlet weak var wheatherCityListTableView: UITableView!
    let locationManager = CLLocationManager()
    var currentLocationStr = "Current location"
    var isFromSearch = false
    // MARK: - Variables

    override func viewDidLoad() {
        super.viewDidLoad()
        wheatherCityListTableView.register(UINib(nibName: "WeatherCityListCell", bundle: nil), forCellReuseIdentifier: "WeatherCityListCell")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        configuration()
        
    }
    
    @IBAction func addCity(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchVC.delegate = self
        navigationController?.pushViewController(searchVC, animated: true)

    }

}

extension WheatherListViewController {
    
    
    func configuration() {
        
        if isFromSearch {
            currentLocation = selectedLocation
        }
        else {
            currentLocation = locationManager.location
        }
    
        print("Current Location ==> \(String(describing: currentLocation))")

        viewModel.fetchWeatherWithLatLong(for: currentLocation?.coordinate.latitude ?? 0.0, for: currentLocation?.coordinate.longitude ?? 0.0) {
            DispatchQueue.main.sync {
                
                self.dictWheatherData.updateValue(self.viewModel.nameString, forKey: "cityname")
                self.dictWheatherData.updateValue("\(Decimal(string: self.viewModel.humidityString) ?? 0)", forKey: "temp")

                self.dictWheatherData.updateValue(self.viewModel.windSpeedString, forKey: "windspeed")

                self.dictWheatherData.updateValue(self.viewModel.maxTemperatureString, forKey: "hightemp")

                self.dictWheatherData.updateValue(self.viewModel.minTemperatureString, forKey: "lowtemp")

                self.dictWheatherData.updateValue(self.viewModel.latitudeString, forKey: "lat")
                
                self.dictWheatherData.updateValue(self.viewModel.longitudeString, forKey: "lon")
                
                self.arrayWheatherData.append(self.dictWheatherData as NSDictionary)
                print("Weather Dict ==> \(self.dictWheatherData)")
                
                self.wheatherCityListTableView.reloadData()

            }
        }
    }

}

extension WheatherListViewController : CLLocationManagerDelegate {
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            print("Region ==> \(region)")
        }
    }

    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: \(error)")
    }
}

extension WheatherListViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayWheatherData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCityListCell") as? WeatherCityListCell else {
            return UITableViewCell()
        }
        print("Array data ==> \(arrayWheatherData)")
        let section = arrayWheatherData[indexPath.row] as! NSDictionary
//        let key = section
//        section.keys.sorted()[indexPath.row]
//        let value = section[key]!

        cell.cityNameLabel.text = section["cityname"] as? String
        cell.descriptionLabel.text = section["windspeed"] as? String
        cell.tempLabel.text = "\(section["temp"] as? String ?? "")°"
        let strHighLowTemp = "H:\(section["hightemp"] as? String ?? "")    L:\(section["lowtemp"] as? String ?? "")"
        cell.highLowTempLabel.text = strHighLowTemp
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "ViewToDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let detailsVC = segue.destination as! HomeController
        let selectedRow = wheatherCityListTableView.indexPathForSelectedRow?.row
        let section = arrayWheatherData[selectedRow ?? 0] as! NSDictionary
        detailsVC.latitude = section["lat"] as? Double ?? 0.0
        detailsVC.longitude = section["lon"] as? Double ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }

}

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}


extension WheatherListViewController: HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark, isFromsearchBar: Bool) {
        print("Selected Place ==>", placemark)
        print("Selected Place ==>", isFromsearchBar)
        print("Weather Dict ==> \(self.dictWheatherData)")
        selectedLocation = placemark.location
        isFromSearch = isFromsearchBar

        configuration()

    }
    
    
}
