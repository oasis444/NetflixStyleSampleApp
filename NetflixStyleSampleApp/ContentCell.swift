//
//  ContentCell.swift
//  NetflixStyleSampleApp
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import UIKit
import SnapKit

class ContentCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleToFill
        contentView.addSubview(imageView)
        
        // SnapKit
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
