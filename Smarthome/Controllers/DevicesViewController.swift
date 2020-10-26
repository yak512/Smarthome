//
//  ViewController.swift
//  Smarthome
//
//  Created by Yakoub on 21/10/2020.
//

import UIKit
import Alamofire
import CoreData

class DevicesViewController: UIViewController {

    var saveChange = [DeviceSave]()
    var devicesSaved = [DeviceSave]()
    var stackView = UIStackView()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["All", "Lights", "Roller Shutter", "Heaters" ])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        return sc
    }()
    
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    var data: ResponseConfigData!
    
    let service = DevicesService()

    lazy var myRowToDisplay = data.devices

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Style
        view.backgroundColor = .white
        navigationItem.title = "Home Devices"
        
        configStackView()
        
        stackViewContraints()
       
        
        let logoutBarButtonItem = UIBarButtonItem(title: "Profil", style: .done, target: self, action: #selector(profilUser))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem

    }
    
    @objc func profilUser() {
        let vc = ProfileViewController()
        vc.userData = data.user
        present(vc, animated: true, completion: nil)
    }
    
    
    
    @objc fileprivate func handleSegmentChange() {
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                myRowToDisplay = data.devices
            case 1:
                myRowToDisplay = devicePerType(devices: data.devices, productType: ProductType.light)
            case 2:
                myRowToDisplay = devicePerType(devices: data.devices, productType: ProductType.rollerShutter)
        default:
                myRowToDisplay = devicePerType(devices: data.devices, productType: ProductType.heater)
    }
    tableView.reloadData()
}

    func configStackView() {
        let paddedStackView = UIStackView(arrangedSubviews: [segmentedControl])
        paddedStackView.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
        paddedStackView.isLayoutMarginsRelativeArrangement = true

        
        stackView = UIStackView(arrangedSubviews: [paddedStackView, tableView])
        stackView.axis = .vertical
        view.addSubview(stackView)
        tableView.rowHeight = 100
        tableView.register(DeviceCell.self, forCellReuseIdentifier: "DeviceCell")
    }
    
    func stackViewContraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func devicePerType(devices: [ResponseDevice], productType: ProductType) -> [ResponseDevice] {
        var goodDevices = [ResponseDevice]()
        for device in devices {
            if device.productType == productType {
                goodDevices.append(device)
                }
            }
        return goodDevices
    }
    
    func loadData() {
        let fetchRequest: NSFetchRequest<DeviceSave> = DeviceSave.fetchRequest()
        do {
            let deviceData =  try PersistenceService.context.fetch(fetchRequest)
            self.devicesSaved = deviceData
        } catch {
            return
        }
    }
    
}

// Extension for TableView
extension DevicesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRowToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell") as? DeviceCell else {
            return UITableViewCell()
        }
        let device = myRowToDisplay[indexPath.row]
        cell.deviceLabel.text = device.deviceName
        if device.productType == ProductType.light {
            cell.deviceImage.image = UIImage(named: "light")
        } else if (device.productType == ProductType.heater) {
            cell.deviceImage.image = UIImage(named: "heater")
        } else {
            cell.deviceImage.image = UIImage(named: "roller-shutter")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = myRowToDisplay[indexPath.row]
        
        switch device.productType {
        case ProductType.light:
            let devicePage = LightViewController()
            devicePage.device = device
            self.navigationController?.pushViewController(devicePage, animated: true)
        case ProductType.heater:
            let devicePage = HeatersViewController()
            devicePage.device = device
            self.navigationController?.pushViewController(devicePage, animated: true)
        default:
            let devicePage = RollerShutterViewController()
            devicePage.device = device
            self.navigationController?.pushViewController(devicePage, animated: true)
        }
    }
    
    // Delete cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            loadData()
            for myDevice in self.devicesSaved {
                if self.myRowToDisplay[indexPath.row].id == myDevice.id {
                    PersistenceService.context.delete(devicesSaved[indexPath.row])
                    PersistenceService.saveContext()
                }
            }
            myRowToDisplay.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
