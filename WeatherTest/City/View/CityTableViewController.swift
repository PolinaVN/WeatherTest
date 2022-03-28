//
//  CityTableViewController.swift
//  WeatherTest
//
//  Created by Polina on 27.03.2022.
//

import UIKit

final class CityTableViewController: UITableViewController {
    
    //MARK: - Public Properties
    var changeCity: ((CitySourse)->())?
    
    //MARK: - Private Properties
    private var presenter: CityPresenter?
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CityPresenter(view: self)
    }
    
    // MARK: - Tableview data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.cities.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        guard let cities = presenter?.cities else {return UITableViewCell()}
        cell.backgroundColor = UIColor(red: 49/255, green: 114/259, blue: 179/255, alpha: 0.5)
        cell.textLabel?.text = cities[indexPath.row].name
        cell.accessoryType = cities[indexPath.row].isSelected ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.changeCity(index: indexPath.row)
        guard let cities = presenter?.cities else {return}
        dismiss(animated: true) { [weak self] in
            self?.changeCity?(cities[indexPath.row])
        }
    }
}

//MARK: - CityView
extension CityTableViewController: CityView {
    
    func reloadView() {
        tableView.reloadData()
    }
}
