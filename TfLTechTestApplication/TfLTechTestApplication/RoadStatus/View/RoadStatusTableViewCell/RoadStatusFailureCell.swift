//
//  RoadStatusFailureCell.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 06/01/2023.
//

import Foundation
import UIKit

protocol RoadStatusFailureCellAppearanceProtocol {
    func updateCellProperties(cellViewModel: RoadStatusFailureCellViewModel)
}

class RoadStatusFailureCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet private var message: UILabel!
    
    class var identifier: String { return String(describing: self) }
    
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: RoadStatusFailureCellViewModel?
    
    
    // MARK: Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func configureView() {
        // Cell view customization
        backgroundColor = .clear
        
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        
        // Cell label properties
        self.message.numberOfLines = 0
        self.message.lineBreakMode = .byWordWrapping
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}


extension RoadStatusFailureCell: RoadStatusFailureCellAppearanceProtocol {
    
    func updateCellProperties(cellViewModel: RoadStatusFailureCellViewModel) {
        self.message.text = cellViewModel.message
    }
    
}
