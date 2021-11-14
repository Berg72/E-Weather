//
//  HomePageController.swift
//  E-Weather
//
//  Created by Mark bergeson on 11/12/21.
//

import UIKit
import SnapKit

class HomePageController : UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let searchfield = UITextField()
    private let textContainer = UIView()
    private var datasource = [City]()
    private let loadingContainer = UIView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let emptyLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadEmptyState()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

private extension HomePageController {
    
    func setupView() {
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.setHidesBackButton(true, animated: false)
        
        view.backgroundColor = .primaryBackgroundColor
        navigationController?.navigationBar.barTintColor = .navigationBarBackgroundColor
        navigationController?.navigationBar.tintColor = .everlance
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.everlance, NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 18.0) ?? UIFont.systemFont(ofSize: 18.0, weight: .regular)]
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        navigationItem.title = "City Search"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.everlance]
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppeared(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        textContainer.backgroundColor = .white
        view.addSubview(textContainer)
        
        textContainer.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(64.0)
            
            
        }
        
        searchfield.backgroundColor = .primaryBackgroundColor
        searchfield.returnKeyType = .search
        let searchImageConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 18.0, weight: .regular))
        let searchImage = UIImage(systemName: "magnifyingglass", withConfiguration: searchImageConfig)
        let searchImageView = UIImageView(frame: CGRect(x: 12.0, y: 12.0, width: 20.0, height: 20.0))
        searchImageView.tintColor = .lightGray
        let searchView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0))
        searchView.addSubview(searchImageView)
        searchImageView.image = searchImage
        searchfield.leftViewMode = .always
        searchfield.layer.cornerRadius = 8.0
        searchfield.leftView = searchView
        searchfield.placeholder = "Search by city"
        searchfield.delegate = self
        searchfield.clearButtonMode = .always
        textContainer.addSubview(searchfield)
        
        searchfield.snp.makeConstraints { make in
            make.top.equalTo(textContainer.snp.top).offset(10.0)
            make.leading.equalTo(textContainer.snp.leading).offset(20.0)
            make.trailing.equalTo(textContainer.snp.trailing).offset(-20.0)
            make.height.equalTo(44.0)
        }
        
        
        tableView.backgroundColor = .primaryBackgroundColor
        tableView.backgroundView?.backgroundColor = .primaryBackgroundColor
        tableView.separatorStyle = .none
        tableView.register(SearchResultsCell.self, forCellReuseIdentifier: SearchResultsCell.reuseIdentifier())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 52.0
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textContainer.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
        loadingContainer.backgroundColor = .white
        loadingContainer.isHidden = true
        view.addSubview(loadingContainer)
        
        loadingContainer.snp.makeConstraints { make in
            make.top.equalTo(textContainer.snp.bottom)
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
        
        emptyLabel.font = UIFont(name: "AvenirNext-Regular", size: 18.0) ?? UIFont.systemFont(ofSize: 18.0, weight: .regular)
        emptyLabel.textColor = .lightGray
        emptyLabel.text = "Search for a city above"
        emptyLabel.textAlignment = .center
        emptyLabel.isHidden = true
        view.addSubview(emptyLabel)
        
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(textContainer.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
    }
    
    func loadEmptyState() {
        let favorites = FavoriteStorage.shared.getAllFovorites()
        datasource.removeAll()
        datasource = favorites
        tableView.reloadData()
        if datasource.isEmpty {
            emptyLabel.text = "Search for a city above"
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
    }
}

extension HomePageController: UITableViewDelegate, UITableViewDataSource {

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsCell.reuseIdentifier(), for: indexPath)
        if let cell = cell as? SearchResultsCell {
            cell.configure(city: datasource[safe: indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let city = datasource[safe: indexPath.row] else {
            return
        }
        let vc = DetailsController(city: city)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchfield.resignFirstResponder()
    }
}

extension HomePageController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            loadEmptyState()
            return true
        }
        textField.resignFirstResponder()
        loadingContainer.isHidden = false
        emptyLabel.isHidden = true
        loadingIndicator.startAnimating()
        SearchRequest().search(cityName: text) { cities, error in
            self.loadingContainer.isHidden = true
            self.loadingIndicator.stopAnimating()
            guard let cities = cities else {
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error", message: "Something went wrong, try again later", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            self.datasource = cities
            self.tableView.reloadData()
            if self.datasource.isEmpty {
                self.emptyLabel.text = "No results found"
                self.emptyLabel.isHidden = false
            } else {
                self.emptyLabel.isHidden = true
            }
        }
       return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        loadEmptyState()
        return true
    }
    
}

private extension HomePageController {
    
    @objc func keyboardAppeared(notification: Notification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let anitmationCurveRaw = animationCurveRawNSN?.uintValue ??
                UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: anitmationCurveRaw)
            
            if endFrameY >= UIScreen.main.bounds.size.height {
                tableView.snp.remakeConstraints { make in
                    make.top.equalTo(textContainer.snp.bottom)
                    make.leading.equalTo(view.snp.leading)
                    make.trailing.equalTo(view.snp.trailing)
                    make.bottom.equalTo(view.snp.bottomMargin).offset(0.0)
                }
            } else {
                let offset = UIScreen.main.bounds.size.height - endFrameY
                self.tableView.snp.remakeConstraints { make in
                    make.top.equalTo(textContainer.snp.bottom)
                    make.leading.equalTo(view.snp.leading)
                    make.trailing.equalTo(view.snp.trailing)
                    make.bottom.equalTo(view.snp.bottom).offset(-offset)
                }
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations:  { self.view.layoutIfNeeded() },
                           completion:  nil)
                           
        }
    }
}
