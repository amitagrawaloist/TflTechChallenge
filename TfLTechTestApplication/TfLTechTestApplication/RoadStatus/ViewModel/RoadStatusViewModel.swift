//
//  RoadStatusViewModel.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 06/01/2023.
//

import Foundation

protocol RoadStatusViewModelProtocol: AnyObject {
    var reloadTableView: (() -> Void)? { get  set}
    var shouldShowAnimator: ((Bool) -> Void)? { get  set}
    var showAPIError: ((Error) -> Void)? { get  set}
    
    var roadAPIStatusCode: Int { get set }
    var roadStatusArray: [RoadStatusSuccess] { get }
    var roadStatusFailureArray: [RoadStatusFailure] { get }
    
    func getRoadStatus(roadName: String) async
    
    func getSuccessCellViewModel(at indexPath: IndexPath) -> RoadStatusCellViewModel
    func getFailureCellViewModel(at indexPath: IndexPath) -> RoadStatusFailureCellViewModel
    
}

final class RoadStatusViewModel: RoadStatusViewModelProtocol {
    // MARK: Properties
    var shouldShowAnimator: ((Bool) -> Void)?
    
    var reloadTableView: (() -> Void)?
    
    var showAPIError: ((Error) -> Void)?
    
    private var roadStatusDataService: RoadStatusServiceProtocol
    
    var roadAPIStatusCode = -1
    var roadStatusArray = [RoadStatusSuccess]()
    var roadStatusFailureArray = [RoadStatusFailure]()
        
    // Obeserved Properties
    var isDataLoading = true {
        didSet {
            shouldShowAnimator?(isDataLoading)
        }
    }
    
    var roadStatusCellViewModels = [RoadStatusCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var roadStatusFailureCellViewModels = [RoadStatusFailureCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var serverError: Error? {
        didSet {
            guard let serverError = serverError else {
                return
            }
            showAPIError?(serverError)
        }
    }
    
    // MARK: Methods
    
    init(roadStatusDataService: RoadStatusServiceProtocol) {
        self.roadStatusDataService = roadStatusDataService
    }
    
    func getRoadStatus(roadName: String) async {
        self.isDataLoading = true
        do {
            let result:RoadStatusResponse = try await roadStatusDataService.getRoadStatusData(api: .list, roadName: roadName)
                    
            roadAPIStatusCode = result.statusCode
            switch result.statusCode {
            case 200:
                self.roadStatusArray = result.successResponse!
                self.createRoadStatusSuccessCellModels()
            case 404:
                self.roadStatusFailureArray = [result.failureResponse!]
                self.createRoadStatusFailureCellModels()
            default:
                throw APIError.responseError
            }
            
            self.isDataLoading = false
 
        } catch {
            self.isDataLoading = false
            self.serverError = error
        }
    }
    
    private func createRoadStatusSuccessCellModels() {
        var cellModels = [RoadStatusCellViewModel]()
        for roadStatusObject in self.roadStatusArray {
            cellModels.append(createSuccessCellModel(roadStatus: roadStatusObject))
        }
        self.roadStatusCellViewModels = cellModels
    }
    
    private func createSuccessCellModel(roadStatus: RoadStatusSuccess) -> RoadStatusCellViewModel {
        let displayName = roadStatus.displayName
        let statusSeverity = roadStatus.statusSeverity
        let statusSeverityDescription = roadStatus.statusSeverityDescription
              
        return RoadStatusCellViewModel(displayName: displayName, statusSeverity:statusSeverity, statusSeverityDescription:statusSeverityDescription)
    }
    
    private func createRoadStatusFailureCellModels() {
        var cellModels = [RoadStatusFailureCellViewModel]()
        for roadStatusObject in self.roadStatusFailureArray {
            cellModels.append(createFailureCellModel(roadStatus: roadStatusObject))
        }
        self.roadStatusFailureCellViewModels = cellModels
    }
    
    private func createFailureCellModel(roadStatus: RoadStatusFailure) -> RoadStatusFailureCellViewModel {
        let message = roadStatus.message
        return RoadStatusFailureCellViewModel(message: message)
    }
    
    func getSuccessCellViewModel(at indexPath: IndexPath) -> RoadStatusCellViewModel {
        return roadStatusCellViewModels[indexPath.row]
    }
    
    func getFailureCellViewModel(at indexPath: IndexPath) -> RoadStatusFailureCellViewModel {
        return roadStatusFailureCellViewModels[indexPath.row]
    }
}
