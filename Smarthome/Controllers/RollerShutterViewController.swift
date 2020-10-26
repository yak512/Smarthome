//
//  RollerShutterViewController.swift
//  Smarthome
//
//  Created by Yakoub on 23/10/2020.
//

import UIKit
import CoreData

class RollerShutterViewController: UIViewController {

    var saveChange = [DeviceSave]()
    var devicesSaved = [DeviceSave]()
    var myDeviceSaved = DeviceSave()
    var deviceNotSaved = false
    
    var deviceNameLabel = UILabel()
    var positionLabel = UILabel()
    var sliderValueLabel = UILabel()
    var device: ResponseDevice!
    var slider = UISlider()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        loadData()
        
        configDeviceNameLabel()
        configPositionLabel()
        configSlider()
        configSliderValueLabel()
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        save()
    }
    
    func loadData() {
        let fetchRequest: NSFetchRequest<DeviceSave> = DeviceSave.fetchRequest()
        do {
            let deviceData =  try PersistenceService.context.fetch(fetchRequest)
            self.devicesSaved = deviceData
        } catch {
            return
        }
        findGoodDevice(devices: devicesSaved)
    }
    
    // Find the correct device in the array of saved devices
    private func findGoodDevice(devices: [DeviceSave]) {
            for myDevice in devices {
                if self.device.id == myDevice.id {
                    myDeviceSaved = myDevice
                    deviceNotSaved = true
                }
            }
    }
    
    // Check if a device is already saved with CoreData if not we creave and save a new one
    private func save() {
        var deviceAlreadySaved = false
        for myDevice in devicesSaved {
            if self.device.id == myDevice.id {
                myDevice.id = Int16(device.id)
                myDevice.position = Int16(slider.value)
                deviceAlreadySaved = true
            }
        }
        if deviceAlreadySaved == false {
            let saveDevice = DeviceSave(context: PersistenceService.context)
            saveDevice.id = Int16(device.id)
            saveDevice.position = Int16(slider.value)
        }
        PersistenceService.saveContext()
    }
    
    private func configSliderValueLabel() {
        view.addSubview(sliderValueLabel)
        sliderValueLabel.text = "\(Int(slider.value))"
        sliderValueLabel.font = UIFont.systemFont(ofSize: 25)
        sliderValueLabel.textAlignment = .center
        sliderValueLabel.numberOfLines = 0
        sliderValueLabelConstraints()
    }
    
    private func sliderValueLabelConstraints() {
        sliderValueLabel.translatesAutoresizingMaskIntoConstraints = false
        sliderValueLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 200).isActive = true
        sliderValueLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        sliderValueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    
    private func configSlider() {
        let w = view.bounds.width
        slider.bounds.size.width = w
        slider.center = CGPoint(x: w/2, y: w/2)
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        view.addSubview(slider)
        sliderConstraints()
        
        slider.minimumValue = 0
        slider.maximumValue = 100
        if deviceNotSaved == false {
            let valueToFloat = device.position!
            slider.value = Float(valueToFloat)
        } else {
            let valueToFloat = myDeviceSaved.position
            slider.value = Float(valueToFloat)
        }
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(sliderInAction(sender:)), for: UIControl.Event.valueChanged)
    }
    
    @objc func sliderInAction(sender: UISlider) {
        sliderValueLabel.text = "\(Int(sender.value))"
    }
    
    private func sliderConstraints() {
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 220).isActive = true
        slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    func configPositionLabel() {
        view.addSubview(positionLabel)
        positionLabel.text = "Position"
        positionLabel.font = UIFont.systemFont(ofSize: 25)
        positionLabel.textAlignment = .center
        positionLabel.numberOfLines = 0
        positionLabel.adjustsFontSizeToFitWidth = true
        labelPositionConstraints()
    }
    
    func labelPositionConstraints() {
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.topAnchor.constraint(equalTo: deviceNameLabel.safeAreaLayoutGuide.bottomAnchor, constant: 50).isActive = true
        positionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        positionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
    }
    
    func configDeviceNameLabel() {
        view.addSubview(deviceNameLabel)
        deviceNameLabel.text = device.deviceName
        deviceNameLabel.font = UIFont.boldSystemFont(ofSize: 35)
        deviceNameLabel.textAlignment = .center
        deviceNameLabel.numberOfLines = 0
        deviceNameLabel.adjustsFontSizeToFitWidth = true
        labelDeviceNameConstraints()
    }

    private func labelDeviceNameConstraints() {
        deviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        deviceNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        deviceNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        deviceNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
 

}
