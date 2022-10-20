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
        for _ in 0..<stars {
            let star = UIImageView()
            star.contentMode = .scaleAspectFit
            star.image = UIImage(named: "star")
            
            ratingStackView.addArrangedSubview(star)
            
            star.widthAnchor.constraint(
                equalTo: ratingStackView.widthAnchor, multiplier: 0.2
            ).isActive = true
        }
        
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: ratingStackView.frame.width / 5, height: 0))
        for _ in 0..<5 - stars {
            ratingStackView.addArrangedSubview(emptyView)
        }
    }
    
}
