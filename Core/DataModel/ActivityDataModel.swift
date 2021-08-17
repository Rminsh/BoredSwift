//
//  ActivityDataModel.swift
//  Bored
//
//  Created by armin on 8/7/21.
//

import SwiftUI
import WidgetKit

class ActivityDataModel: ObservableObject {
    
    @AppStorage("activityTitle") private var activityTitle: String = ""
    @AppStorage("activityAccessibility") private var activityAccessibility: Double = 0.0
    @AppStorage("activityParticipants") private var activityParticipants: Int = 0
    @AppStorage("activityType") private var activityType: String = ""
    @AppStorage("activityPrice") private var activityPrice: Double = 0
    @AppStorage("activityLink") private var activityLink: String = ""
    @AppStorage("activityKey") private var activityKey: String = ""
    
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
        request.execute { result in
            self.isLoading = false
            switch result {
            case .success:
                self.activity = try? result.get()
                
            case .failure(.badNetworkingRequest):
                self.hasError = true
                self.errorTitle = NetworkingError.badNetworkingRequest.errorDescription ?? ""
                self.errorSubtitle = "Try again"
                print("Network error (Bad request")
                
            case .failure(.errorParse):
                self.hasError = true
                self.errorTitle = NetworkingError.errorParse.errorDescription ?? ""
                self.errorSubtitle = "Try again later"
                print("Network error (Parse error")
                
            case .failure(.unexpectedError):
                self.hasError = true
                self.errorTitle = NetworkingError.unexpectedError.errorDescription ?? ""
                self.errorSubtitle = "Try again and report the bug"
                print("Network error (Unexpected error")
            }
        }
    }
    
    func fetch(completion : @escaping(Activity) ->()) {
        guard !isLoading else { return }
        isLoading = true
        let resource = ActivityResource()
        let request = APIRequest(resource: resource)
        self.request = request
        request.execute { result in
            self.isLoading = false
            switch result {
            case .success:
                self.activity = try? result.get()
                
                /// Saving data to AppStorage
                if let activity = self.activity {
                    self.activityTitle = activity.activity
                    self.activityAccessibility = activity.accessibility
                    self.activityParticipants = activity.participants
                    self.activityType = activity.type
                }
                
                if let activity = self.activity {
                    completion(activity)
                } else {
                    completion(self.loadFromAppStorage())
                }
                
            default:
                completion(self.loadFromAppStorage())
            }
        }
    }
    
    func loadFromAppStorage() -> Activity {
        return Activity(
            activity: self.activityTitle,
            type: self.activityType,
            participants: self.activityParticipants,
            price: self.activityPrice,
            link: self.activityLink,
            key: self.activityKey,
            accessibility: self.activityAccessibility
        )
    }
    
    func testData() -> Activity {
        return Activity(
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
