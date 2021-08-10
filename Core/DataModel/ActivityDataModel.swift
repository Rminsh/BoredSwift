//
//  ActivityDataModel.swift
//  Bored
//
//  Created by armin on 8/7/21.
//

import Foundation

class ActivityDataModel: ObservableObject {
    @Published private(set) var activity: Activity? = nil
    @Published private(set) var isLoading: Bool = false
    
    @Published private(set) var hasError: Bool = false
    @Published private(set) var errorTitle: String = ""
    @Published private(set) var errorSubtitle: String = ""
    
    private var request: APIRequest<ActivityResource>?
    
    func fetchData() {
        guard !isLoading else { return }
        isLoading = true
        let resource = ActivityResource()
        let request = APIRequest(resource: resource)
        self.request = request
        request.execute { [weak self] (result) in
            self?.isLoading = false
            switch result {
            case .success:
                self?.activity = try? result.get()
                
            case .failure(.badNetworkingRequest):
                self?.hasError = true
                self?.errorTitle = NetworkingError.badNetworkingRequest.errorDescription ?? ""
                self?.errorSubtitle = "Try again"
                
            case .failure(.errorParse):
                self?.hasError = true
                self?.errorTitle = NetworkingError.errorParse.errorDescription ?? ""
                self?.errorSubtitle = "Try again later"
                
            case .failure(.unexpectedError):
                self?.hasError = true
                self?.errorTitle = NetworkingError.unexpectedError.errorDescription ?? ""
                self?.errorSubtitle = "Try again and report the bug"
            }
        }
    }
    
    func testData() {
        activity = Activity(
            activity: "Resolve a problem you've been putting off",
            type: "busywork",
            participants: 1,
            price: 0,
            link: "",
            key: "9999999",
            accessibility: 0
        )
    }
}
