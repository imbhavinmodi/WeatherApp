//
//  WeatherCityListCell.swift
//  WeatherForecast
//
//  Created by Bhavin's on 15/03/23.
//

import UIKit

class WeatherCityListCell: UITableViewCell {
    
//    @IBOutlet weak var lessonImageView: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var highLowTempLabel: UILabel!

    var category: Category? {
        didSet { // Property Observer
            lessonDetailConfiguration()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
//        lessonImageView.layer.cornerRadius = 10

//        self.lessonBackgroundView.backgroundColor = .systemGray6
        
//        containerView.layer.cornerRadius = 8
//        containerView.layer.shadowOffset = CGSize(width: 0, height: 3)
//        containerView.layer.shadowRadius = 3
//        containerView.layer.shadowOpacity = 0.3
//        containerView.layer.shadowColor = UIColor.white.cgColor
//        containerView.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
//      byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 10, height:
//      8)).cgPath
//        containerView.layer.shouldRasterize = true
//        containerView.layer.rasterizationScale = UIScreen.main.scale
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func lessonDetailConfiguration() {
        guard let category else { return }
        cityNameLabel.text = "Ahmedabad"
        descriptionLabel.text = "Cloudy"
        tempLabel.text = "32°"
        highLowTempLabel.text = "H:32°  L:22°"
//        descriptionLabel.text = category.lessons.description
//        lessonImageView.setImage(with: category.lessons.thumbnail)
    }
    
}
