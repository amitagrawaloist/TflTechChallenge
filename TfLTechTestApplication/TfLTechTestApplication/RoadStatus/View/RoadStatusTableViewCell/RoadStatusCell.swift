//
//  RoadStatusCell.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 06/01/2023.
//

import Foundation
import UIKit

protocol RoadStatusCellAppearanceProtocol {
    func updateCellProperties(cellViewModel: RoadStatusCellViewModel)
}

class RoadStatusCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet private var roadName: UILabel!
    @IBOutlet private var status: UILabel!
    @IBOutlet private var statusDescription: UILabel!
    
    class var identifier: String { return String(describing: self) }
    
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: RoadStatusCellViewModel?
    
    
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
        self.roadName.numberOfLines = 0
        self.roadName.lineBreakMode = .byWordWrapping
        
        self.status.numberOfLines = 0
        self.status.lineBreakMode = .byWordWrapping
        
        self.statusDescription.numberOfLines = 0
        self.statusDescription.lineBreakMode = .byWordWrapping
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}


extension RoadStatusCell: RoadStatusCellAppearanceProtocol {
    
    func updateCellProperties(cellViewModel: RoadStatusCellViewModel) {
        self.roadName.text = cellViewModel.displayName
        self.status.text = cellViewModel.statusSeverity
        self.statusDescription.text = cellViewModel.statusSeverityDescription
    }
    
}
