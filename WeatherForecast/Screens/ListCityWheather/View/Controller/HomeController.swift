//
//  HomeController.swift
//  WeatherForecast
//
//  Created by Bhavin's on 15/03/23.
//

import UIKit

class HomeController: UIViewController {

    private let viewModel = HomeViewModel()
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var buttonDayOne: UIButton!
    @IBOutlet weak var buttonDaySecond: UIButton!
    @IBOutlet weak var buttonDayThird: UIButton!
    @IBOutlet weak var buttonDayFourth: UIButton!
    @IBOutlet weak var buttonDayFifth: UIButton!
    
    var latitude = Double()
    var longitude = Double()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchWeatherWithLatLong(for: latitude, for: longitude) {
            DispatchQueue.main.sync {
                self.setupUI()
            }
        }
    }

    private func setupUI() {
        setupHeader()
        setupSubheader()
    }
    
    @IBAction func buttonDayOneAction(sender: AnyObject) {
        buttonDayOne.isSelected = true;
        buttonDaySecond.isSelected = false;
        buttonDayThird.isSelected = false;
        buttonDayFourth.isSelected = false;
        buttonDayFifth.isSelected = false;
        
        viewModel.fetchWeatherDayWithLatLong(for: latitude, for: longitude) {
            DispatchQueue.main.sync {
                self.setupUI()
            }
        }
    }
    
    @IBAction func buttonDaySecondAction(sender: AnyObject) {
        buttonDayOne.isSelected = false
        buttonDaySecond.isSelected = true
        buttonDayThird.isSelected = false
        buttonDayFourth.isSelected = false
        buttonDayFifth.isSelected = false
    }
    
    @IBAction func buttonDayThirdAction(sender: AnyObject) {
        buttonDayOne.isSelected = false
        buttonDaySecond.isSelected = false
        buttonDayThird.isSelected = true
        buttonDayFourth.isSelected = false
        buttonDayFifth.isSelected = false
    }
    
    @IBAction func buttonDayFourthAction(sender: AnyObject) {
        buttonDayOne.isSelected = false
        buttonDaySecond.isSelected = false
        buttonDayThird.isSelected = false
        buttonDayFourth.isSelected = true
        buttonDayFifth.isSelected = false
    }
    
    @IBAction func buttonDayFifthAction(sender: AnyObject) {
        buttonDayOne.isSelected = false
        buttonDaySecond.isSelected = false
        buttonDayThird.isSelected = false
        buttonDayFourth.isSelected = false
        buttonDayFifth.isSelected = true
    }
    
    private func setupHeader() {
        temperatureLabel.text = viewModel.temperatureString
        nameLabel.text = viewModel.nameString
    }

    private func setupSubheader() {
        feelsLikeLabel.text = viewModel.feelsLikeTemperatureString
        minTemperatureLabel.text = viewModel.minTemperatureString
        maxTemperatureLabel.text = viewModel.maxTemperatureString
        pressureLabel.text = viewModel.pressureString
        humidityLabel.text = viewModel.humidityString
    }
}

