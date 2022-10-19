//
//  ItemTableViewCell.swift
//  Guidomia
//
//  Created by GRICHE, MEHDI on 19/10/2022.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    let identifier = "ItemTableViewCell"
    @IBOutlet weak var containerStackView: UIStackView!
    
    @IBOutlet weak var topViewImage: UIImageView!
    @IBOutlet weak var topViewTitle: UILabel!
    @IBOutlet weak var topViewSubtitle: UILabel!
    @IBOutlet weak var ratingStackView: UIStackView!
    
    @IBOutlet weak var bottomView: UIView! {
        didSet {
            bottomView.isHidden = true
        }
    }
    @IBOutlet weak var bottomViewProsStack: UIStackView!
    @IBOutlet weak var bottomViewConsStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupRatings(stars: Int) {
        let star = UIImageView()
        star.contentMode = .scaleAspectFit
        star.image = UIImage(named: "star")
        
        for _ in 0...stars {
            ratingStackView.addArrangedSubview(star)
        }
    }
    
}
