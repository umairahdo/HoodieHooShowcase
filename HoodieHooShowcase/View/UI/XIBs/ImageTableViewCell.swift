//
//  ImageTableViewCell.swift
//  HoodieHooShowcase
//
//  Created by Umair Ahmad on 20/01/23.
//

import UIKit
import Kingfisher

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageDisplayView: UIImageView!
    @IBOutlet weak var imageUrlLabel: UILabel!
    
    func setupView(model: String) {
        DispatchQueue.main.async {
            self.imageDisplayView.kf.setImage(with: URL(string: model), placeholder: UIImage(systemName: "pencil.and.outline"))
            self.imageUrlLabel.text = model
        }
    }
}
