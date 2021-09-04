//
//  ContentView.swift
//  Bored (iOS)
//
//  Created by armin on 7/30/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var dataModel: ActivityStore
    @State private var filterSheetShown = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                HeaderView()
                
                Spacer()
                    .frame(maxHeight: 50)
                
                ActivityView()
                    .environmentObject(dataModel)
                // TODO: Add empty result for filtering
                
                if dataModel.isLoading && dataModel.activity == nil {
                    ProgressView()
                }
                
                Spacer()
                
                // Get another activity
                if !dataModel.isLoading && dataModel.activity != nil {
                    ActionView(
                        title: "Not satisfied?",
                        subtitle: "Try another one",
                        action: { dataModel.fetchData() }
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                } else if dataModel.isLoading && dataModel.activity != nil {
                    ProgressView()
                        .frame(height: 80)
                }
                
                // Empty state for network error (if activity is nil)
                if !dataModel.isLoading && dataModel.hasError && dataModel.activity == nil {
                    ActionView(
                        title: dataModel.errorTitle,
                        subtitle: "Try again",
                        action: { dataModel.fetchData() }
                    )
                }
                
                Button(action: {filterSheetShown.toggle()}) {
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(
                            Circle()
                                .fill(dataModel.hasFilter ? Color.accentColor : Color.gray)
                        )
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.bottom)
            
            BottomSheetView(
                isOpen: self.$filterSheetShown,
                maxHeight: 620  // TODO: Use dynamic height instead of static number
            ) {
                FilterView(closeView: {filterSheetShown.toggle()})
                    .environmentObject(dataModel)
            }
        }
        .ignoresSafeArea(.all)
        .onAppear { dataModel.fetchData() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
