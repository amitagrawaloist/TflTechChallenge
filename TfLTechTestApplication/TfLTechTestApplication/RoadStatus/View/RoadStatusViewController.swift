//
//  RoadStatusViewController.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 06/01/2023.
//

import Foundation
import UIKit

class RoadStatusViewController: BaseViewController, UISearchBarDelegate {
    
    // MARK: Properties
    @IBOutlet private var searchBar:UISearchBar! { didSet { searchBar.delegate = self } }
    
    @IBOutlet private var tableView: UITableView!
    
    @IBOutlet private var animator: UIActivityIndicatorView! { didSet { animator.hidesWhenStopped = true } }
    
    private lazy var viewModel: RoadStatusViewModelProtocol = {
        RoadStatusViewModel(roadStatusDataService: RoadStatusDataService(withNetworkManager: NetworkManager()))
    }() as RoadStatusViewModelProtocol
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        //configureViewModel()
    }
    
    private func configureView() {
        
        setTableViewProperties()
        setNavigationAppearance(title: Constants.Texts.roadStatusTitle)
    }
    
    private func setTableViewProperties() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .lightGray
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.register(RoadStatusCell.nib, forCellReuseIdentifier: RoadStatusCell.identifier)
        tableView.register(RoadStatusFailureCell.nib, forCellReuseIdentifier: RoadStatusFailureCell.identifier)
    }
    
    private func configureViewModel() {
                        
        // All callbacks from view models
        handleDataLoader()
        handleErrorNotification()
        handleTableviewRefreshActivity()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        if let roadName = searchBar.text {
            getRoadStatusFor(roadName: roadName)
            animator.startAnimating()
            configureViewModel()
            searchBar.text = ""
        }
    }
}

extension RoadStatusViewController {
    
    private func getRoadStatusFor(roadName:String) {
        // Get Road Status data from VM
        Task {[weak self] in
            await self?.viewModel.getRoadStatus(roadName: roadName)
        }
    }
    
    private func handleDataLoader() {
        // Show loader till list appears
        viewModel.shouldShowAnimator = { [weak self] showLoader in
            Task {[weak self] in
                self?.showDataLoader(show: showLoader)
            }
        }
    }
    
    private func handleErrorNotification() {
        // Show network error message
        viewModel.showAPIError = { [weak self] error in
            Task {[weak self] in
                guard let sourceVC = self else {return}
                self?.showApplicationAlert(sourceVC, alertTitle: error.localizedDescription)
            }
        }
    }
    
    private func handleTableviewRefreshActivity() {
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            Task {[weak self] in
                self?.reloadTableView()
            }
        }
    }
    
    // MARK: UI update operations done using Mainactor on main thread
    @MainActor
    private func reloadTableView() {
        self.tableView.reloadData()
    }
    
    @MainActor
    private func showDataLoader(show: Bool) {
        if show {
            self.animator.startAnimating()
        } else {
            self.animator.stopAnimating()
        }
    }
    
    @MainActor
    private func showApplicationAlert(_ sourceVC: RoadStatusViewController, alertTitle: String) {
        Alert.present(title: alertTitle, message: "", actions: .okay(handler: {
        }), from: sourceVC)
    }
}
// MARK: - UITableViewDelegate

extension RoadStatusViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Value.tableRowEstimatedHeight // estimated height
    }
}

// MARK: - UITableViewDataSource

extension RoadStatusViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.roadAPIStatusCode == 200 ? viewModel.roadStatusArray.count : viewModel.roadStatusFailureArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.roadAPIStatusCode {
        case 200:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RoadStatusCell.identifier, for: indexPath) as? RoadStatusCell
            else { fatalError(Constants.ErrorMessages.xibNotFound) }
            // cell  will be created with CellVM data
            let cellVM = viewModel.getSuccessCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
            cell.updateCellProperties(cellViewModel: cellVM)
            return cell
        case 404:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RoadStatusFailureCell.identifier, for: indexPath) as? RoadStatusFailureCell
            else { fatalError(Constants.ErrorMessages.xibNotFound) }
            // cell  will be created with CellVM data
            let cellVM = viewModel.getFailureCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
            cell.updateCellProperties(cellViewModel: cellVM)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
