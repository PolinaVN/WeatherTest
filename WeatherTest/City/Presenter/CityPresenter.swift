//
//  CityPresenter.swift
//  WeatherTest
//
//  Created by Polina on 27.03.2022.
//

import Foundation

protocol CityView: AnyObject {
    func reloadView()
}

final class CityPresenter {
    
    //MARK: - Public Properties
    var cities = CitiesSourse().citiesSource
    
    //MARK: - Private Properties
    private weak var view: CityView?
    
    //MARK: - Lifecycle Methods
    init(view: CityView) {
        self.view = view
    }
    
    //MARK: - Public Methods
    func changeCity(index: Int) {
        cities.forEach { $0.isSelected = false }
        cities[index].isSelected = true
        view?.reloadView()
    }
}
