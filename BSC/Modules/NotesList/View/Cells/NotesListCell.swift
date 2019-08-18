//
//  NotesListCell.swift
//  BSC
//
//  Created by Andrey Mosin on 17/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import UIKit

class NotesListCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareForReuse()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
    }
    
    func configureWith(title: String) {
        titleLabel.text = title
    }
}
