//
//  BannerViewController.swift
//  Guidomia
//
//  Created by GRICHE, MEHDI on 19/10/2022.
//

import UIKit

class BannerView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var bannerTitle: UILabel!
    @IBOutlet weak var bannerSubtitle: UILabel!
    let BannerView_Xib_Name = "BannerView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(BannerView_Xib_Name, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    func setupView(image: UIImage, title: String, subtitle: String) {
        self.image.image = image
        self.image.contentMode = .scaleToFill
        bannerTitle.text = title
        bannerSubtitle.text = subtitle
    }

}
