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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        menu.setupView(
            title: K.Strings.appName.uppercased()
        )
        banner.setupView(
            image: UIImage(named: "BannerImage")!,
            title: K.Strings.bannerTitle,
            subtitle: K.Strings.bannerSubtitle
        )
    }


}

