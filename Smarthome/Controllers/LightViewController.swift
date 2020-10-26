//
//  LightViewController.swift
//  Smarthome
//
//  Created by Yakoub on 22/10/2020.
//

import UIKit
import CoreData

class LightViewController: UIViewController {

    var saveChange = [DeviceSave]()
    var devicesSaved = [DeviceSave]()
    var myDeviceSaved = DeviceSave()
    var deviceNotSaved = false
    
    var lightSwitch = UISwitch()
    var deviceNameLabel = UILabel()
    var lightLabel = UILabel()
    var intensityLabel = UILabel()
    var stackViewTop = UIStackView()
    var stackViewBot = UIStackView()
    var slider = UISlider()
    var sliderValueLabel = UILabel()
    var device: ResponseDevice!


    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        view.backgroundColor = .white
        configLabel()
        labelDeviceNameConstraints()
        
        configStackView()
        stackViewTopConstraints()
        
        configIntencityLabel()
        
        configIntencityLabel()
        intensityLabelConstraints()
        
        configSlider()
        sliderConstraints()
        
        configSliderValueLabel()
        sliderValueLabelConstraints()
    
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
                myDevice.intensity = slider.value
                if lightSwitch.isOn {
                    myDevice.mode = "ON"
                } else {
                    myDevice.mode = "OFF"
                }
                deviceAlreadySaved = true
            }
        }
        if deviceAlreadySaved == false {
            let saveDevice = DeviceSave(context: PersistenceService.context)
            saveDevice.id = Int16(device.id)
            saveDevice.intensity = slider.value
            if lightSwitch.isOn {
                saveDevice.mode = "ON"
            } else {
            saveDevice.mode = "OFF"
            }
        }
        PersistenceService.saveContext()
    }

    private func configSliderValueLabel() {
        view.addSubview(sliderValueLabel)
        sliderValueLabel.text = "\(Int(slider.value))"
        sliderValueLabel.font = UIFont.systemFont(ofSize: 25)
        sliderValueLabel.textAlignment = .center
        sliderValueLabel.numberOfLines = 0
    }
    
    private func sliderValueLabelConstraints() {
        sliderValueLabel.translatesAutoresizingMaskIntoConstraints = false
        sliderValueLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20).isActive = true
        sliderValueLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        sliderValueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configSlider() {
        view.addSubview(slider)
        
        slider.minimumValue = 0
        slider.maximumValue = 100
        if deviceNotSaved == false {
            let valueToFloat = device.intensity!
            slider.value = Float(valueToFloat)
        } else {
            let valueToFloat = myDeviceSaved.intensity
            slider.value = valueToFloat
        }
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(sliderInAction(sender:)), for: UIControl.Event.valueChanged)
    }
    
    @objc func sliderInAction(sender: UISlider) {
        sliderValueLabel.text = "\(Int(sender.value))"
    }
    
    private func sliderConstraints() {
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.topAnchor.constraint(equalTo: intensityLabel.bottomAnchor, constant: 20).isActive = true
        slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    private func configIntencityLabel() {
        view.addSubview(intensityLabel)
        intensityLabel.text = "Intensity"
        intensityLabel.font = UIFont.systemFont(ofSize: 20)
    }
    
    private func intensityLabelConstraints() {
        intensityLabel.translatesAutoresizingMaskIntoConstraints = false
        intensityLabel.topAnchor.constraint(equalTo: lightLabel.bottomAnchor, constant: 40).isActive = true
        intensityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        intensityLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    private func configLabel() {
        view.addSubview(deviceNameLabel)
        view.addSubview(lightLabel)
        deviceNameLabel.text = device.deviceName
        deviceNameLabel.font = UIFont.boldSystemFont(ofSize: 35)
        deviceNameLabel.textAlignment = .center
        deviceNameLabel.numberOfLines = 0
        deviceNameLabel.adjustsFontSizeToFitWidth = true
        lightLabel.text = "Light"
        lightLabel.font = UIFont.systemFont(ofSize: 20)

    }
    private func configSwitch() {
        if deviceNotSaved == false {
            if device.mode == "ON" {
                lightSwitch.isOn = true
            } else {
                lightSwitch.isOn = false
            }
        } else {
            if myDeviceSaved.mode == "ON" {
                lightSwitch.isOn = true
            } else {
                lightSwitch.isOn = false
            }
        }
    }
    
    
    private func labelDeviceNameConstraints() {
        deviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        deviceNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        deviceNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        deviceNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    
    private func configStackView() {
        view.addSubview(stackViewTop)
        stackViewTop.distribution = .fill
        stackViewTop.axis = .horizontal
        stackViewTop.addArrangedSubview(lightLabel)
        stackViewTop.addArrangedSubview(lightSwitch)
        configSwitch()

    }
    
    private func stackViewTopConstraints() {
        stackViewTop.translatesAutoresizingMaskIntoConstraints = false
        stackViewTop.topAnchor.constraint(equalTo: deviceNameLabel.bottomAnchor, constant: 100).isActive = true
        stackViewTop.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackViewTop.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
}
