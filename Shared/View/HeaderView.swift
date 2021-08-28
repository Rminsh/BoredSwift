//
//  HeaderView.swift
//  Bored
//
//  Created by armin on 8/28/21.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            #if os(watchOS)
            Text("Are you bored?")
                .font(.title2)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
            
            Text("Let's find you something to do")
                .font(.body)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
            
            ProgressView()
            #else
            Text("Are you bored?")
                .font(.largeTitle)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
            
            Text("Let's find you something to do")
                .font(.body)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
            #endif
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
