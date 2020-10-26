//
//  ProfileViewController.swift
//  Smarthome
//
//  Created by Yakoub on 24/10/2020.
//

import UIKit

class ProfileViewController: UIViewController {

    var userData: ResponseUser!
    
    var labelFirstName = UILabel()
    var labelLastName = UILabel()
    var firstNameLabel = UILabel()
    var lastNameLabel = UILabel()
    var stackViewName = UIStackView()
    
    var cityLabel = UILabel()
    var city = UILabel()
    var labelPostalCode = UILabel()
    var postalCode = UILabel()
    var labelAdress = UILabel()
    var address = UILabel()
    var labelCountry = UILabel()
    var country = UILabel()
    
    var labelBirthDate = UILabel()
    var birthDay = UILabel()
    
    var stackViewAdress = UIStackView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configLabelName()
        configStackViewName()
        
        
        configLabelAdress()
        configStackViewAddress()
    }
    
    func configLabelAdress() {
        cityLabel.font = UIFont.systemFont(ofSize: 25)
        cityLabel.numberOfLines = 0
        cityLabel.text = "City:"
        
        city.font = UIFont.systemFont(ofSize: 25)
        city.textAlignment = .center
        city.numberOfLines = 0
        city.text = userData.address.city
        
        labelPostalCode.font = UIFont.systemFont(ofSize: 25)
        labelPostalCode.numberOfLines = 0
        labelPostalCode.text = "Postal Code:"

        
        postalCode.font = UIFont.systemFont(ofSize: 25)
        postalCode.textAlignment = .center
        postalCode.numberOfLines = 0
        postalCode.text = "\(userData.address.postalCode)"
        
        labelAdress.font = UIFont.systemFont(ofSize: 25)
        labelAdress.numberOfLines = 0
        labelAdress.text = "Adress:"
        
        address.font = UIFont.systemFont(ofSize: 25)
        address.textAlignment = .center
        address.numberOfLines = 0
        address.text = userData.address.streetCode + " " + userData.address.street
        
        labelCountry.font = UIFont.systemFont(ofSize: 25)
        labelCountry.numberOfLines = 0
        labelCountry.text = "Country:"
        
        country.font = UIFont.systemFont(ofSize: 25)
        country.textAlignment = .center
        country.numberOfLines = 0
        country.text = userData.address.country
        
    }
    
    func configStackViewAddress() {
        view.addSubview(stackViewAdress)
        stackViewAdress.distribution = .fill
        stackViewAdress.axis = .vertical
        stackViewAdress.distribution = .fillProportionally
        stackViewAdress.addArrangedSubview(cityLabel)
        stackViewAdress.addArrangedSubview(city)
        stackViewAdress.addArrangedSubview(labelPostalCode)
        stackViewAdress.addArrangedSubview(postalCode)
        
        stackViewAdress.addArrangedSubview(labelAdress)
        stackViewAdress.addArrangedSubview(address)
        stackViewAdress.addArrangedSubview(labelCountry)
        stackViewAdress.addArrangedSubview(country)
        
        stackViewAdress.addArrangedSubview(labelBirthDate)
        stackViewAdress.addArrangedSubview(birthDay)
        
        stackViewAdressConstraints()
    }
    
    func stackViewAdressConstraints() {
        stackViewAdress.translatesAutoresizingMaskIntoConstraints = false
        stackViewAdress.topAnchor.constraint(equalTo: stackViewName.bottomAnchor, constant: 20).isActive = true
        stackViewAdress.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackViewAdress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    func configStackViewName() {
        view.addSubview(stackViewName)
        stackViewName.distribution = .fill
        stackViewName.axis = .vertical
        stackViewName.distribution = .fillProportionally
        stackViewName.addArrangedSubview(labelFirstName)
        stackViewName.addArrangedSubview(firstNameLabel)
        stackViewName.addArrangedSubview(labelLastName)
        stackViewName.addArrangedSubview(lastNameLabel)
        stackViewTopConstraints()

    }
    
    private func stackViewTopConstraints() {
        stackViewName.translatesAutoresizingMaskIntoConstraints = false
        stackViewName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        stackViewName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackViewName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configLabelName() {
        labelFirstName.font = UIFont.systemFont(ofSize: 25)
        labelFirstName.numberOfLines = 0
        
        firstNameLabel.font = UIFont.systemFont(ofSize: 25)
        firstNameLabel.textAlignment = .center
        firstNameLabel.numberOfLines = 0
        
        labelLastName.font = UIFont.systemFont(ofSize: 25)
        labelLastName.numberOfLines = 0
        
        lastNameLabel.font = UIFont.systemFont(ofSize: 25)
        lastNameLabel.textAlignment = .center
        lastNameLabel.numberOfLines = 0
        
        
        
        labelFirstName.text = "Name:"
        firstNameLabel.text = userData.firstName
        labelLastName.text = "Last Name:"
        lastNameLabel.text = userData.lastName
    }
}
