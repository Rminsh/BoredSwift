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
            Text("Are you bored?")
                .font(.largeTitle)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
            
            Text("Let's find you something to do")
                .font(.body)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
