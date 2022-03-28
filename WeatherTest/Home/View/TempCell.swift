//
//  TempCell.swift
//  WeatherTest
//
//  Created by Polina on 26.03.2022.
//

import UIKit

final class TempCell: UITableViewCell {
    
    //MARK: - Visual Components
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle Methods
    override func layoutSubviews() {
        setup()
    }
    
    // MARK: - Public Methods
    func configureCell(weatherFuture: WeatherCityFuture, presenter: HomePresenter) {
        dateLabel.text = weatherFuture.dateString
        iconImage.image = UIImage(named: weatherFuture.icon)
        if presenter.isCelsius == true {
            tempLabel.text = "\(weatherFuture.tempCMin) --- \(weatherFuture.tempCMax)"
        } else {
            tempLabel.text = "\(weatherFuture.tempFMin) --- \(weatherFuture.tempFMax)"
        }
    }
    
    // MARK: - Private Methods
    private func setup() {
        backgroundColor = UIColor(red: 49/255, green: 114/259, blue: 179/255, alpha: 0.5)
        addDateLabel()
        addIconImage()
        addTempLabel()
    }
    
    private func addDateLabel() {
        addSubview(dateLabel)
        dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    private func addIconImage() {
        addSubview(iconImage)
        iconImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iconImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 150).isActive = true
    }
    
    private func addTempLabel() {
        addSubview(tempLabel)
        tempLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 220).isActive = true
        tempLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        tempLabel.widthAnchor.constraint(equalToConstant: 110).isActive = true
    }
}
