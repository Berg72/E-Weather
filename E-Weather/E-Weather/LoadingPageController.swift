//
//  LoadingPageController.swift
//  E-Weather
//
//  Created by Mark bergeson on 11/12/21.
//

import UIKit
import SnapKit

class LoadingPageController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // perform additional network tasks, loading data...
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let vc = HomePageController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


private extension LoadingPageController {
    
    func setupView() {
        
        view.backgroundColor = .everlance
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "E-Weather-icon")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(200.0)
            make.width.height.equalTo(206.0)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        let titleLogo = UIImageView()
        titleLogo.image = UIImage(named: "E-Weather-logo")?.withRenderingMode(.alwaysOriginal)
        titleLogo.contentMode = .scaleAspectFit
        view.addSubview(titleLogo)
        
        titleLogo.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.width.equalTo(300.0)
            make.height.equalTo(98.0)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
}
