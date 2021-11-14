//
//  WeatherDetailCell.swift
//  E-Weather
//
//  Created by Mark bergeson on 11/13/21.
//

import UIKit
import SnapKit
import AlamofireImage

class WeatherDetailsCell: UITableViewCell {
    
    private let dayLabel = UILabel()
    private let highLabel = UILabel()
    private let lowLabel = UILabel()
    private let iconimageView = UIImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayLabel.text = nil
        highLabel.text = nil
        lowLabel.text = nil
        iconimageView.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(consolidatedWeather: ConsolidatedWeather?) {
        highLabel.text = String(format: "%.0f", consolidatedWeather?.maxTemp ?? 0.0)
        lowLabel.text = String(format: "%.0f", consolidatedWeather?.minTemp ?? 0.0)
        if let abbr = consolidatedWeather?.weatherStateAbbr, let url = URL(string: "https://www.metaweather.com/static/img/weather/png/64/\(abbr).png") {
            iconimageView.af.setImage(withURL: url)
        }
        dayLabel.text = consolidatedWeather?.applicableDateString()
        
    }
}


private extension WeatherDetailsCell {
    
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
            make.bottom.equalTo(contentView.snp.bottom).offset(-10.0)
        
        }
        
        dayLabel.font = UIFont(name: "AvenirNext-Medium", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0, weight: .medium)
        dayLabel.textColor = .mainTextColor
        containerView.addSubview(dayLabel)
        
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(14.0)
            make.leading.equalTo(containerView.snp.leading).offset(14.0)
            make.bottom.equalTo(containerView.snp.bottom).offset(-14.0)
            
        }
        
        iconimageView.contentMode = .scaleAspectFit
        containerView.addSubview(iconimageView)
        
        iconimageView.snp.makeConstraints { make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(containerView.snp.centerY)
            make.height.equalTo(22.0)
            make.width.equalTo(22.0)
            
        }
        
        lowLabel.font = UIFont(name: "AvenirNext-Medium", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0, weight: .regular)
        lowLabel.textColor = .mainTextColor
        containerView.addSubview(lowLabel)
        
        lowLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(14.0)
            make.trailing.equalTo(containerView.snp.trailing).offset(-14.0)
            make.bottom.equalTo(containerView.snp.bottom).offset(-14.0)
            
        }
        
        highLabel.font = UIFont(name: "AvenirNext-Medium", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0, weight: .medium)
        highLabel.textColor = .mainTextColor
        containerView.addSubview(highLabel)
        
        highLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(14.0)
            make.trailing.equalTo(lowLabel.snp.leading).offset(-24.0)
            make.bottom.equalTo(containerView.snp.bottom).offset(-14.0)
            
        }
    }
}
