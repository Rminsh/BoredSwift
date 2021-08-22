//
//  ItemView.swift
//  ItemView
//
//  Created by armin on 8/1/21.
//

import SwiftUI

enum ItemSize {
    case small
    case normal
}

struct ItemView: View {
    @State var size: ItemSize = .normal
    
    var icon: String
    var header: String
    var title: String
    
    var body: some View {
        HStack {
            switch size {
            case .small:
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 14, height: 14)
                
                Text(title)
                    .font(.footnote)
                    .fontWeight(.regular)
                
            case .normal:
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(header)
                        .font(.body)
                        .fontWeight(.light)
                    
                    Text(title)
                        .font(.title3)
                        .fontWeight(.regular)
                }
            }
        }
    }
}


struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(
            icon: "circle.hexagongrid.fill",
            header: "Type",
            title: "Busy work"
        )
    }
}
