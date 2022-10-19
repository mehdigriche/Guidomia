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
    var carResponse = CarResponse()
    var carsList : [Car?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carResponse.delegate = self
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
        self.itemsTableView.estimatedRowHeight = 150
        self.itemsTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        itemsTableView.reloadData()
    }

}

extension ViewController: CarResponseDelegate {
    func didRecieveCarList(result: Bool, data: [Car?]) {
        if result {
            carsList = data
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell, let expandableItem = self.carsList[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.topViewImage.image = UIImage(
            named: expandableItem.make.replacingOccurrences(of: " ", with: "_").lowercased()
        )
        cell.topViewTitle.text = expandableItem.make + " \(expandableItem.model)"
        cell.topViewSubtitle.text = "Price : \(expandableItem.marketPrice )"
        cell.setupRatings(stars: expandableItem.rating)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

