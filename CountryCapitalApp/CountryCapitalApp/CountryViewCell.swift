//
//  CountryViewCell.swift
//  CountryCapitalApp
//
//  Created by Nitesh Srivastva on 23/02/18.
//  Copyright © 2018 Nitesh Srivastva. All rights reserved.
//

import UIKit

class CountryViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var namelbl: UILabel!
    
    @IBOutlet weak var capitallbl: UILabel!
    
    @IBOutlet weak var regionlbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        imgView.layer.cornerRadius = imgView.frame.size.width/2
//        imgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
