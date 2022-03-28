//
//  ViewController.swift
//  WeatherTest
//
//  Created by Polina on 26.03.2022.
//

import UIKit
import CoreLocation

final class HomeViewController: UIViewController {
    
    //MARK: - Visual Components
    private let backImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "back_weather")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let tempButton: UIButton = {
        let button = UIButton()
        button.setTitle("°F", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 49/255, green: 114/259, blue: 179/255, alpha: 0.5)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(tapTempButton(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let changeCityButton: UIButton = {
        let button = UIButton()
        button.setTitle("=", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 49/255, green: 114/259, blue: 179/255, alpha: 0.5)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(tapChangeCityButton(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 80)
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minMaxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let homeTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor =  UIColor(red: 49/255, green: 114/259, blue: 179/255, alpha: 0.5)
        tableView.register(TempCell.self, forCellReuseIdentifier: "TempCell")
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Private Properties
    private var presenter: HomePresenter?
    private var weathersFuture = [WeatherCityFuture]()
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter = HomePresenter(view: self)
    }
    
    //MARK: - IBActions
    @objc private func tapTempButton(sender: UIButton) {
        if presenter?.isCelsius == true {
            presenter?.isCelsius = false
            presenter?.changeTempUnit()
            tempButton.setTitle("°C", for: .normal)
        } else {
            presenter?.isCelsius = true
            presenter?.changeTempUnit()
            tempButton.setTitle("°F", for: .normal)
        }
    }
    
    @objc private func tapChangeCityButton(sender: UIButton) {
        let vc = CityTableViewController()
        vc.changeCity = { [weak self] city in
            self?.presenter?.fetchWeatherResponse(city: city)
        }
        present(vc, animated: true)
    }
    
    //MARK: - Private Methods
    private func setup() {
        addBackImage()
        addTempButton()
        addChangeCityButton()
        addCityLabel()
        addTempLabel()
        addDescriptionLabel()
        addMinMaxTempLabel()
        addTableView()
    }
    
    private func addBackImage() {
        view.addSubview(backImage)
        backImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        backImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        backImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    private func addTempButton() {
        view.addSubview(tempButton)
        tempButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        tempButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        tempButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tempButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func addChangeCityButton() {
        view.addSubview(changeCityButton)
        changeCityButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        changeCityButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        changeCityButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        changeCityButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func addCityLabel() {
        view.addSubview(cityLabel)
        cityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func addTempLabel() {
        view.addSubview(tempLabel)
        tempLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10).isActive = true
        tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tempLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func addDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 20).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func addMinMaxTempLabel() {
        view.addSubview(minMaxTempLabel)
        minMaxTempLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        minMaxTempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        minMaxTempLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func addTableView() {
        view.addSubview(homeTableView)
        homeTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        homeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        homeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        homeTableView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }
}

//MARK: - HomeView
extension HomeViewController: HomeView {
    
    func changeTemp(isCelsius: Bool, city: WeatherCityToday, futureWeather: [WeatherCityFuture]) {
        if isCelsius == true {
            tempLabel.text = city.tempC
            minMaxTempLabel.text = "Мин.: \(city.tempCMin) Макс.:  \(city.tempCMax) "
            weathersFuture = futureWeather
            homeTableView.reloadData()
        }
        if isCelsius == false {
            tempLabel.text = city.tempF
            minMaxTempLabel.text = "Мин.: \(city.tempFMin) Макс.:  \(city.tempFMax) "
            weathersFuture = futureWeather
            homeTableView.reloadData()
        }
    }
    
    func reloadView(city: WeatherCityToday, futureWeather: [WeatherCityFuture]) {
        cityLabel.text = city.name
        tempLabel.text = city.tempC
        descriptionLabel.text = city.weatherDescription
        minMaxTempLabel.text = "Мин.: \(city.tempCMin) Макс.:  \(city.tempCMax) "
        weathersFuture = futureWeather
        homeTableView.reloadData()
    }
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Прогноз на 5 дней"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
}

//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TempCell") as? TempCell else {return UITableViewCell()}
        if weathersFuture.isEmpty == false {
            let weather = weathersFuture[indexPath.row]
            guard let presenterCell = presenter else {return UITableViewCell()}
            cell.configureCell(weatherFuture: weather,presenter: presenterCell)
            return cell
        }
        return cell
    }
}
