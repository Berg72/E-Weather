//
//  LoadingPageController.swift
//  E-Weather
//
//  Created by Mark bergeson on 11/12/21.
//

import UIKit

class LoadingPageController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let vc = HomePageController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}


private extension LoadingPageController {
    
    func setupView() {
        
        view.backgroundColor = .everlance
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "E-Weather-icon")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 206.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 206.0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let titleLogo = UIImageView()
        titleLogo.translatesAutoresizingMaskIntoConstraints = false
        titleLogo.image = UIImage(named: "E-Weather-logo")?.withRenderingMode(.alwaysOriginal)
        titleLogo.contentMode = .scaleAspectFit
        view.addSubview(titleLogo)
        
        titleLogo.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        titleLogo.heightAnchor.constraint(equalToConstant: 98.0).isActive = true
        titleLogo.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        titleLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
}
