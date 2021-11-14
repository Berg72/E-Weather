//
//  CurrentWeatherCell.swift
//  E-Weather
//
//  Created by Mark bergeson on 11/13/21.
//

import UIKit
import SnapKit

class CureentWeatherCell: UITableViewCell {
    
    private let cityLabel = UILabel()
    private let conditionLabel = UILabel()
    private let tempLabel = UILabel()
    private let highLowLabel = UILabel()
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityLabel.text = nil
        conditionLabel.text = nil
        tempLabel.text = nil
        highLowLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(consolidatedWeather: ConsolidatedWeather?, city: City) {
        cityLabel.text = city.title
        conditionLabel.text = consolidatedWeather?.weatherStateName
        tempLabel.text = String(format: "%.0f", consolidatedWeather?.theTemp ?? 0.0)
        highLowLabel.text = String(format: "H:%.0f°  L:%.0f°", consolidatedWeather?.maxTemp ?? 0.0, consolidatedWeather?.minTemp ?? 0.0)
    }
}


private extension CureentWeatherCell {
    
    func setupView() {
        
        contentView.backgroundColor = .primaryBackgroundColor
        backgroundColor = .primaryBackgroundColor
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8.0
        containerView.layer.applySketchShadow(color: .black, alpha: 0.15, x: 0.0, y: 2.0, blur: 8.0, spread: 0.0)
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10.0)
            make.leading.equalTo(contentView.snp.leading).offset(20.0)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20.0)
            make.height.equalTo(UIScreen.main.bounds.width)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10.0)
        
        }
        
        tempLabel.font = UIFont(name: "AvenirNext-Regular", size: 100.0) ?? UIFont.systemFont(ofSize: 100.0, weight: .regular)
        tempLabel.textColor = UIColor(named: "main-text-color")
        tempLabel.text = "46°"
        containerView.addSubview(tempLabel)
        
        tempLabel.snp.makeConstraints { make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(containerView.snp.centerY)
            
        }
        
        let degreeLabel = UILabel()
        degreeLabel.font = UIFont(name: "AvenirNext-Regular", size: 100.0) ?? UIFont.systemFont(ofSize: 100.0, weight: .regular)
        degreeLabel.textColor = UIColor(named: "main-text-color")
        degreeLabel.text = "°"
        containerView.addSubview(degreeLabel)
        
        degreeLabel.snp.makeConstraints { make in
            make.leading.equalTo(tempLabel.snp.trailing)
            make.centerY.equalTo(containerView.snp.centerY)
            
        }
        
        conditionLabel.font = UIFont(name: "AvenirNext-Medium", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0, weight: .medium)
        conditionLabel.textColor = UIColor(named: "main-text-color")
        conditionLabel.text = "Clear"
        containerView.addSubview(conditionLabel)
        
        conditionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(tempLabel.snp.top)
            make.centerX.equalTo(containerView.snp.centerX)
            
        }
        
        cityLabel.font = UIFont(name: "AvenirNext-Medium", size: 36.0) ?? UIFont.systemFont(ofSize: 36.0, weight: .medium)
        highLowLabel.textColor = UIColor(named: "main-text-color")
        cityLabel.text = "Rexburg"
        containerView.addSubview(cityLabel)
        
        cityLabel.snp.makeConstraints { make in
            make.bottom.equalTo(conditionLabel.snp.top)
            make.centerX.equalTo(containerView.snp.centerX)
        }
        
        highLowLabel.font = UIFont(name: "AvenirNext-Regular", size: 17.0) ?? UIFont.systemFont(ofSize: 17.0, weight: .regular)
        highLowLabel.textColor = UIColor(named: "main-text-color")
        highLowLabel.text = "H53° L13°"
        containerView.addSubview(highLowLabel)
        
        highLowLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(-10.0)
            make.centerX.equalTo(containerView.snp.centerX)
        }
    }
}

