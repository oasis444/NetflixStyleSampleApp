//
//  ContentRankCell.swift
//  NetflixStyleSampleApp
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import UIKit

class ContentRankCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let rankLabel = UILabel()
    
    override func layoutSubviews() {
        
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleToFill
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        rankLabel.font = .systemFont(ofSize: 80, weight: .black)
        rankLabel.textColor = .white
        contentView.addSubview(rankLabel)
        
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(25)
        }
    }
}
