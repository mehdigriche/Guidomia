//
//  MenuViewController.swift
//  Guidomia
//
//  Created by GRICHE, MEHDI on 19/10/2022.
//

import UIKit

class MenuView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var appName: UILabel!
    let MenuView_Xib_Name = "MenuView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(MenuView_Xib_Name, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    func setupView(title: String) {
        appName.text = title
    }

}
