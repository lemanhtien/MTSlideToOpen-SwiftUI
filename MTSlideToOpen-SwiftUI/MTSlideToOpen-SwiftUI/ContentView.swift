//
//  ContentView.swift
//  MTSlideToOpen-SwiftUI
//
//  Created by Le Manh Tien on 6/8/19.
//  Copyright © 2019 io.tienle. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MTSlideToOpen(thumbnailColor: Color.red,
                          didReachEndAction: { view in
                print("reach end!!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    view.resetState()
                }
            })
            .frame(width: 320, height: 56)
            .background(Color.yellow)
            .cornerRadius(28)
            
            MTSlideToOpen(thumbnailTopBottomPadding: 4,
                          thumbnailLeadingTrailingPadding: 4,
                          text: "Slide to unlock",
                          textColor: .white,
                          thumbnailColor: Color.white,
                          sliderBackgroundColor: Color.black,
                          didReachEndAction: { view in
                print("reach end!!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    view.resetState()
                }
            })
            .frame(width: 320, height: 56)
            .background(Color.yellow)
            .cornerRadius(28)
            
            MTSlideToOpen(thumbnailLeadingTrailingPadding: 10,
                          thumbnailColor:Color.blue,
                          thumbnailBackgroundColor: Color.blue,
                          didReachEndAction: { view in
                print("reach end!!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    view.resetState()
                }
            })
            .frame(width: 320, height: 56)
            .background(Color.yellow)
            .cornerRadius(28)
            
            MTSlideToOpen(sliderTopBottomPadding: 4, didReachEndAction: { view in
                print("reach end!!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    view.resetState()
                }
            })
            .frame(width: 320, height: 56)
            .background(Color.yellow)
            .cornerRadius(28)
            
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
