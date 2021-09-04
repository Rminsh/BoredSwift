//
//  FilterView.swift
//  Bored (iOS)
//
//  Created by armin on 9/3/21.
//

import SwiftUI

struct FilterView: View {
    
    var closeView: () -> Void
    
    @EnvironmentObject var dataModel: ActivityStore
    
    @State private var selectedActivity = ActivityType.all
    @State private var participants = 1
    @State private var budget = 0.0
    
    var body: some View {
        VStack(spacing: 25) {
            // Participants
            SectionView(title: "Participants", icon: "person.2.fill") {
                Stepper("\(participants)", value: $participants, in: 1...10)
            }
            
            // Max. Budget
            SectionView(title: "Max. Budget", icon: "banknote.fill") {
                VStack(spacing: 5) {
                    Slider(
                        value: $budget,
                        in: 0...10,
                        step: 1
                    )
                    HStack {
                        Text("Cheap")
                            .font(.caption)
                        
                        Spacer()
                        
                        Text("Expensive")
                            .font(.caption)
                    }
                }
            }
            
            // Type
            SectionView(title: "Type", icon: "rectangle.stack.fill") {
                Picker("Type", selection: $selectedActivity) {
                    ForEach(ActivityType.allCases) { Text($0.description).tag($0) }
                }
                .pickerStyle(WheelPickerStyle())
            }
            
            // Actions
            HStack(alignment: .center) {
                Button(action: {
                    dataModel.setFilters(
                        type: selectedActivity,
                        participants: participants,
                        budget: budget / 10
                    )
                    closeView()
                }) {
                    Spacer()
                    Text("Apply")
                        .padding(.all, 12)
                        .foregroundColor(.white)
                    Spacer()
                }
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                
                Button(action: {
                    dataModel.clearFilters()
                    closeView()
                }) {
                    Text("Clear")
                        .padding()
                }
            }
            .padding(.bottom)
        }
        .padding(.horizontal, 25)
    }
}

struct SectionView<Content: View>: View {
    
    var title: String
    var icon: String
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    .opacity(0.85)
                
                Text(title)
                    .fontWeight(.thin)
            }
            .font(.subheadline)
            .foregroundColor(.accentColor)
            
            Divider()
                .foregroundColor(.accentColor)
            
            content()
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(closeView: {})
    }
}
