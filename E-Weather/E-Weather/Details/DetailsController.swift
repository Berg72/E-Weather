//
//  DetailsController.swift
//  E-Weather
//
//  Created by Mark bergeson on 11/13/21.
//

import UIKit
import SnapKit

class DetailsController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let city: City
    private var cityDetails: CityDetails?
    private let loadingContainer = UIView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    init(city: City) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadDetails()
    }
    
}

extension DetailsController {
    
    func setupView() {
        
        view.backgroundColor = .primaryBackgroundColor
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Details"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.everlance]
        
        navigationController?.navigationBar.barTintColor = .navigationBarBackgroundColor
        navigationController?.navigationBar.tintColor = .everlance
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.everlance, NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 18.0) ?? UIFont.systemFont(ofSize: 18.0, weight: .regular)]
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        tableView.backgroundColor = .primaryBackgroundColor
        tableView.backgroundView?.backgroundColor = .primaryBackgroundColor
        tableView.separatorStyle = .none
        tableView.register(WeatherDetailsCell.self, forCellReuseIdentifier: WeatherDetailsCell.reuseIdentifier())
        tableView.register(CureentWeatherCell.self, forCellReuseIdentifier: CureentWeatherCell.reuseIdentifier())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 52.0
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
        loadingContainer.backgroundColor = .white
        loadingContainer.isHidden = true
        view.addSubview(loadingContainer)
        
        loadingContainer.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
        loadingIndicator.color = .everlance
        loadingContainer.addSubview(loadingIndicator)
        
        loadingIndicator.snp.makeConstraints { make in
            make.centerY.equalTo(loadingContainer.snp.centerY)
            make.centerX.equalTo(loadingContainer.snp.centerX)
        }
    }
    
    func loadDetails() {
        guard let woeid = city.woeid else {
            return
        }
        self.loadingContainer.isHidden = false
        self.loadingIndicator.startAnimating()
        DetailsRequest().get(woeid: woeid) { details, error in
            self.loadingContainer.isHidden = true
            self.loadingIndicator.stopAnimating()
            guard let details = details else {
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error", message: "Something went wrong, try again later", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            self.cityDetails = details
            self.tableView.reloadData()
        }
    }
}

extension DetailsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityDetails?.consolidatedWeather.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CureentWeatherCell.reuseIdentifier(), for: indexPath) as? CureentWeatherCell else {
                return UITableViewCell()
            }
            cell.config(consolidatedWeather: cityDetails?.consolidatedWeather[safe: indexPath.row], city: city)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailsCell.reuseIdentifier(), for: indexPath) as? WeatherDetailsCell else {
                return UITableViewCell()
            }
            cell.configure(consolidatedWeather: cityDetails?.consolidatedWeather[safe: indexPath.row])
            return cell
        }
        
    }
}
