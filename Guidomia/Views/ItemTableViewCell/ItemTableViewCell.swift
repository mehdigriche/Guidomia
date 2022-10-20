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
    var item: Car? {
        didSet {
            setupCell()
            self.contentView.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        item = nil
        resetStacks(stackView: ratingStackView)
        resetStacks(stackView: bottomViewProsStack)
        resetStacks(stackView: bottomViewConsStack)
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
    
    func expandItem(isHidden: Bool) {
        bottomView.isHidden = isHidden
    }
    
    func setupCell() {
        if let item = item {
            topViewImage.image = UIImage(
                named: item.make.replacingOccurrences(of: " ", with: "_").lowercased()
            )
            topViewTitle.text = item.make + " \(item.model)"
            topViewSubtitle.text = "Price : \(item.marketPrice )"
            setupRatings(stars: item.rating)
            
            configurePros(pros: item.prosList)
            configureCons(cons: item.consList)
        }
    }
    
    private func configurePros(pros: [String]) {
        pros.forEach({
            if $0 != "" {
                let proLabel = UILabel()
                proLabel.text = "\u{2022}  " + $0
                proLabel.textColor = .black
                proLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
                
                let customBulletColor: NSMutableAttributedString =  NSMutableAttributedString(string: proLabel.text!)
                
                customBulletColor.addAttribute(
                    NSAttributedString.Key.foregroundColor,
                    value: UIColor(named: "GuidomiaOrange") ?? .black,
                    range:
                        NSRange(
                            location:0,
                            length: 1
                        )
                )
                proLabel.attributedText = customBulletColor
                
                bottomViewProsStack.addArrangedSubview(proLabel)
            }
        })
    }
    
    private func configureCons(cons: [String]) {
        cons.forEach({
            if $0 != "" {
                let conLabel = UILabel()
                conLabel.text = "\u{2022}  " + $0
                conLabel.textColor = .black
                conLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
                
                let customBulletColor: NSMutableAttributedString =  NSMutableAttributedString(string: conLabel.text!)
                
                customBulletColor.addAttribute(
                    NSAttributedString.Key.foregroundColor,
                    value: UIColor(named: "GuidomiaOrange") ?? .black,
                    range:
                        NSRange(
                            location:0,
                            length: 1
                        )
                )
                conLabel.attributedText = customBulletColor
                
                bottomViewConsStack.addArrangedSubview(conLabel)
            }
        })
    }
    
    private func resetStacks(stackView: UIStackView) {
        stackView.arrangedSubviews.forEach({
            $0.removeFromSuperview()
        })
    }
    
}
