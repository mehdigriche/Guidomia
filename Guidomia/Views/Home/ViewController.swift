//
//  ViewController.swift
//  Guidomia
//
//  Created by GRICHE, MEHDI on 19/10/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menu: MenuView!
    @IBOutlet weak var banner: BannerView!
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var makeFilter: UITextField!
    @IBOutlet weak var modelFilter: UITextField!
    
    
    var carResponse = CarResponse()
    var carsList : [Car?] = []
    var selectedRowIndex: IndexPath?
    var filteredData = [Car?]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carResponse.delegate = self
        makeFilter.delegate = self
        modelFilter.delegate = self
        carResponse.getCarsList()
        
        menu.setupView(
            title: K.Strings.appName.uppercased()
        )
        banner.setupView(
            image: UIImage(named: "BannerImage")!,
            title: K.Strings.bannerTitle,
            subtitle: K.Strings.bannerSubtitle
        )
        
        self.itemsTableView.register(
            UINib(
                nibName: ItemTableViewCell().identifier,
                bundle: nil
            ),
            forCellReuseIdentifier: ItemTableViewCell().identifier
        )
        self.itemsTableView.dataSource = self
        self.itemsTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        itemsTableView.reloadData()
    }

}

extension ViewController: CarResponseDelegate {
    func didRecieveCarList(result: Bool, data: [Car?]) {
        if result {
            DispatchQueue.main.async {
                self.carsList = data
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching == true {
            return filteredData.count
        }
        return carsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell().identifier, for: indexPath) as? ItemTableViewCell, let expandableItem = self.carsList[indexPath.row] else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            cell.expandItem(isHidden: false)
        }
        
        cell.item = (!isSearching) ? expandableItem : self.filteredData[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedRowIndex?.row {
            return 400
        }
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch selectedRowIndex {
        case nil:
            selectedRowIndex = indexPath
        default:
            if selectedRowIndex == indexPath {
                selectedRowIndex = nil
            } else {
                selectedRowIndex = indexPath
                
                tableView.visibleCells.forEach({
                    if let safeItemTableViewCell = $0 as? ItemTableViewCell {
                        safeItemTableViewCell.expandItem(isHidden: true)
                    }
                })
                guard let cell = tableView.cellForRow(at: indexPath) as? ItemTableViewCell else { return }
                cell.expandItem(isHidden: false)
            }
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if makeFilter.text != "" {
            filteredData = carsList.filter({
                $0!.make
                    .lowercased()
                    .uppercased()
                    .prefix(makeFilter.text!.count) == makeFilter.text!.lowercased().uppercased()
            })
            isSearching = true
        } else if modelFilter.text != "" {
            filteredData = carsList.filter({
                $0!.model
                    .lowercased()
                    .uppercased()
                    .prefix(modelFilter.text!.count) == modelFilter.text!.lowercased().uppercased()
            })
            isSearching = true
        } else {
            isSearching = false
        }
        
        itemsTableView.reloadData()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isSearching = false
        itemsTableView.reloadData()
    }
}

