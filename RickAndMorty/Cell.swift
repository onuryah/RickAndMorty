//
//  Cell.swift
//  RickAndMorty
//
//  Created by Ceren Çapar on 7.02.2022.
//

import UIKit
import SnapKit

class Cell: UITableViewCell {
    let characterImageView = UIImageView()
    let frameLabel = UILabel()
    var shadows = UIView()
    let location = UILabel()
    let name = UILabel()
    let id = UILabel()

    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        characterImageView.contentMode = UIView.ContentMode.scaleAspectFill
        name.font = UIFont(name: "Roboto-Regular", size: 16)
        location.font = UIFont(name: "Roboto-Regular", size: 16)
        id.font = UIFont(name: "Roboto-Regular", size: 16)
        frameLabel.frame = CGRect(x: 0, y: 0, width: 327, height: 97)
        frameLabel.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        shadows.frame = frameLabel.frame
        shadows.clipsToBounds = false
        addSubview(shadows)
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 8
        layer0.shadowOffset = CGSize(width: 0, height: 6)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
        let shapes = UIView()
        shapes.frame = frameLabel.frame
        shapes.clipsToBounds = true
        frameLabel.addSubview(shapes)
        let layer1 = CALayer()
        layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer1.bounds = shapes.bounds
        layer1.position = shapes.center
        shapes.layer.addSublayer(layer1)
        
        frameLabel.addSubview(name)
        addSubview(frameLabel)
        addSubview(characterImageView)
        frameLabel.addSubview(location)
        frameLabel.addSubview(id)
        addConstraints()
        
        layoutSubviewsLabel(item: frameLabel, CACornerMask: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 10)
        layoutSublayersImage(item: characterImageView, CACornerMask: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 10)
        
    }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    func layoutSublayersImage(item: UIImageView, CACornerMask: CACornerMask, radius: CGFloat) {
        item.clipsToBounds = true
        item.layer.cornerRadius = 10
        item.layer.maskedCorners = [ .layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    func layoutSubviewsLabel(item: UILabel, CACornerMask: CACornerMask, radius: CGFloat) {
        item.clipsToBounds = true
        item.layer.cornerRadius = radius
        item.layer.maskedCorners = [CACornerMask]
    }
    func registerItems(){
        
    }
    
    func addConstraints(){
        characterImageView.snp.makeConstraints { make in
            make.width.equalTo(327)
            make.height.equalTo(168)
            make.top.equalTo(8)
            make.centerX.equalToSuperview()
        }
        frameLabel.snp.makeConstraints { make in
            make.width.equalTo(327)
            make.height.equalTo(97)
            make.top.equalTo(characterImageView.snp_bottom)
            make.bottomMargin.equalTo(8)
            make.centerX.equalToSuperview()
        }
        
        shadows.snp.makeConstraints { make in
            make.width.equalTo(327)
            make.height.equalTo(97)
            make.top.equalTo(characterImageView.snp_bottom)
            make.bottomMargin.equalTo(8)
            make.centerX.equalToSuperview()
        }
        
        location.snp.makeConstraints { make in
            make.width.equalTo(296)
            make.height.equalTo(19)
            make.bottomMargin.equalToSuperview().offset(16)
            make.top.equalTo(frameLabel.snp_top).offset(62)
            make.left.equalTo(frameLabel.snp_left).offset(14)
            make.right.equalTo(frameLabel.snp_right).offset(17)
        }
        name.snp.makeConstraints { make in
            make.width.equalTo(146)
            make.height.equalTo(19)
            make.top.equalTo(35)
            make.bottom.equalTo(frameLabel.snp_top).offset(8)
            make.right.equalTo(frameLabel.snp_right).offset(167)
            make.left.equalTo(frameLabel.snp_left).offset(14)
        }
        id.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(19)
            make.right.equalTo(17)
            make.left.equalTo(270)
            make.top.equalTo(8)
            make.bottomMargin.equalTo(70)
        }
    }

}

