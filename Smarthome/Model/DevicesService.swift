//
//  DevicesService.swift
//  Smarthome
//
//  Created by Yakoub on 21/10/2020.
//

import Foundation
import Alamofire


struct ConfigData: Codable {
    let devices: [Device]
    let user: User
}

// MARK: - Device
struct Device: Codable {
    let id: Int
    let deviceName: String
    let intensity: Int?
    let mode: String?
    let productType: ProductType
    let position, temperature: Int?
}

enum ProductType: String, Codable {
    case heater = "Heater"
    case light = "Light"
    case rollerShutter = "RollerShutter"
}

// MARK: - User
struct User: Codable {
    let firstName, lastName: String
    let address: Address
    let birthDate: Int
}

// MARK: - Address
struct Address: Codable {
    let city: String
    let postalCode: Int
    let street, streetCode, country: String
}


class DevicesService {
    
    func getDevicesData(completionHandler: @escaping (ResponseConfigData?, Bool) -> Void) {
        
        AF.request("http://storage42.com/modulotest/data.json").responseJSON { (response) in
            if let responseData = response.data {
            guard let responseJson = try? JSONDecoder().decode(ConfigData.self, from: responseData) else {
                completionHandler(nil, false)
                return
                }
                var i = 0
                let numberOfDevices = responseJson.devices.count
                let responseUser = responseJson.user
                let device = responseJson.devices
                var allDevices = [ResponseDevice]()
                while( i < numberOfDevices) {
                    
                    let device = ResponseDevice(id: device[i].id, deviceName: device[i].deviceName, intensity: device[i].intensity, mode: device[i].mode, productType: device[i].productType, position: device[i].position, temperature: device[i].temperature)
                    allDevices.append(device)
                    i += 1
                }
                let user = ResponseUser(firstName: responseUser.firstName, lastName: responseUser.lastName, address: responseUser.address, birthDate: responseUser.birthDate)
                let response = ResponseConfigData(devices: allDevices, user: user)
                completionHandler(response, true)
            } else {
                completionHandler(nil, true)
            }
        }
    }
}


struct ResponseConfigData {
    var devices: [ResponseDevice]
    let user: ResponseUser
}


struct ResponseDevice {
    let id: Int
    let deviceName: String
    let intensity: Int?
    let mode: String?
    let productType: ProductType
    let position, temperature: Int?
}

struct ResponseUser {
    let firstName, lastName: String
    let address: Address
    let birthDate: Int
}

