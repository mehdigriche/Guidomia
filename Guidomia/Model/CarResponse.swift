//
//  CarResponse.swift
//  Guidomia
//
//  Created by GRICHE, MEHDI on 19/10/2022.
//

import Foundation

protocol CarResponseDelegate {
    func didRecieveCarList(result: Bool, data: [Car?])
}

extension CarResponseDelegate {
    func didRecieveCarList(result: Bool, data: [Car?]) {}
}

class CarResponse {
    
    var delegate : CarResponseDelegate?
    var carJsonFile = "car_list"
        
    func getCarsList() {
        let jsonData = readLocalJSONFile(forName: carJsonFile)
        
        if let data = jsonData, let carsList = parse(jsonData: data) {
            delegate?.didRecieveCarList(result: true, data: carsList)
        } else {
            delegate?.didRecieveCarList(result: false, data: [nil])
        }
    }
        
    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    func parse(jsonData: Data) -> [Car]? {
        do {
            let decodedData = try JSONDecoder().decode([Car].self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}
