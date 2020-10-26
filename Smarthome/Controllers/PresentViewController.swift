//
//  PresentViewController.swift
//  Smarthome
//
//  Created by Yakoub on 22/10/2020.
//

import UIKit

class PresentViewController: UIViewController {

    let showDevicesButton = UIButton()
    var imageView =  UIImageView()
    var loadDevices = DevicesService()
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpButton()
        setImage()
        setUpActivityIndicator()
    }
    
    func setUpButton() {
        showDevicesButton.backgroundColor = .black
        showDevicesButton.setTitleColor(.white, for: .normal)
        showDevicesButton.setTitle("Show my Devices", for: .normal)
        showDevicesButton.layer.cornerRadius = 20
        
        showDevicesButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(showDevicesButton)
        setButtonConstraints()
        
        
    }
    
    func setUpActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = true
        setUpActivityIndicatorConstraints()
    }
    
    @objc func buttonTapped() {
        let homePage = DevicesViewController()
        loadDevices.getDevicesData { (data, response) in
           if data != nil && response == true {
                homePage.data = data
                self.navigationController?.pushViewController(homePage, animated: true)
           } else {
            self.presentAlert(title: "Error", message: "please check your internet connection")
           }
           
        }
        
    }
    
    func setButtonConstraints() {
        showDevicesButton.translatesAutoresizingMaskIntoConstraints = false
        showDevicesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        showDevicesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        showDevicesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        showDevicesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
    }

    func setUpActivityIndicatorConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true

       activityIndicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
    }
    
    func setImage() {
        imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: self.view.frame.width, height: 350))
        imageView.image = UIImage(named: "Smart-home")
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
    }
    
    private func presentAlert(title: String, message: String) {
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVc, animated: true, completion: nil)
    }
}
