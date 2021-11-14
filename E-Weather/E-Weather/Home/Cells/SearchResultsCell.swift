//
//  SearchResultsCell.swift
//  E-Weather
//
//  Created by Mark bergeson on 11/13/21.
//

import UIKit
import SnapKit

class SearchResultsCell: UITableViewCell {
    
    private let cityLabel = UILabel()
    private let starButton = UIButton(type: .roundedRect)
    private var city: City?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityLabel.text = nil
        city = nil
        let starConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 22.0, weight: .regular))
        let starImage = UIImage(systemName: "star", withConfiguration: starConfig)
        starButton.setImage(starImage, for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(city: City?) {
        self.city = city
        cityLabel.text = city?.title
        if let city = city, FavoriteStorage.shared.isAFavorite(city: city) {
            let starConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 22.0, weight: .regular))
            let starImage = UIImage(systemName: "star.fill", withConfiguration: starConfig)
            starButton.setImage(starImage, for: .normal)
        } else {
            let starConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 22.0, weight: .regular))
            let starImage = UIImage(systemName: "star", withConfiguration: starConfig)
            starButton.setImage(starImage, for: .normal)
        }
    }
}

private extension SearchResultsCell {
        
    func setupView() {
        
        contentView.backgroundColor = .primaryBackgroundColor
        backgroundColor = .primaryBackgroundColor
        
        selectionStyle = .none
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8.0
        containerView.layer.applySketchShadow(color: .black, alpha: 0.15, x: 0.0, y: 2.0, blur: 8.0, spread: 0.0)
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(20.0)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20.0)
            make.top.equalTo(contentView.snp.top).offset(10.0)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10.0)
        }
        
        let starConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 22.0, weight: .regular))
        let starImage = UIImage(systemName: "star", withConfiguration: starConfig)
        starButton.setImage(starImage, for: .normal)
        starButton.addTarget(self, action: #selector(starButtonAction), for: .touchUpInside)
        containerView.addSubview(starButton)
        
        starButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top)
            make.bottom.equalTo(containerView.snp.bottom)
            make.width.equalTo(44.0)
            make.height.equalTo(44.0)
            make.trailing.equalTo(containerView.snp.trailingMargin)
        }
        
        cityLabel.font = UIFont(name: "AvenirNext-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0, weight: .regular)
        containerView.addSubview(cityLabel)
        
        cityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starButton.snp.centerY)
            make.leading.equalTo(containerView.snp.leading).offset(10.0)
            make.trailing.equalTo(containerView.snp.trailing).offset(-10.0)
        }
    }
    
    @objc
    func starButtonAction() {
        guard let city = city else {
            return
        }
        if FavoriteStorage.shared.isAFavorite(city: city) {
            FavoriteStorage.shared.removeFavorite(city: city)
            let starConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 22.0, weight: .regular))
            let starImage = UIImage(systemName: "star", withConfiguration: starConfig)
            starButton.setImage(starImage, for: .normal)
        } else {
            FavoriteStorage.shared.addFavorite(city: city)
            let starConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 22.0, weight: .regular))
            let starImage = UIImage(systemName: "star.fill", withConfiguration: starConfig)
            starButton.setImage(starImage, for: .normal)
        }
    }
}
