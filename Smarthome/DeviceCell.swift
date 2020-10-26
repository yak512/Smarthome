//
//  DeviceCell.swift
//  Smarthome
//
//  Created by Yakoub on 22/10/2020.
//

import UIKit

// custom cell

class DeviceCell: UITableViewCell {
    
    var deviceImage = UIImageView()
    var deviceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(deviceImage)
        addSubview(deviceLabel)
        
        configureImageView()
        configureLabel()
        setImageConstraints()
        setLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageView() {
        deviceImage.layer.cornerRadius = 10
        deviceImage.clipsToBounds = true

    }
    
    func configureLabel() {
        deviceLabel.numberOfLines = 0
        deviceLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraints() {
        deviceImage.translatesAutoresizingMaskIntoConstraints = false
        deviceImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        deviceImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        deviceImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        deviceImage.widthAnchor.constraint(equalTo: deviceImage.heightAnchor, multiplier: 16/9).isActive = true
    }
    
    func setLabelConstraints() {
        deviceLabel.translatesAutoresizingMaskIntoConstraints = false
        deviceLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        deviceLabel.leadingAnchor.constraint(equalTo: deviceImage.trailingAnchor, constant: 20).isActive = true
        deviceLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        deviceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
}
