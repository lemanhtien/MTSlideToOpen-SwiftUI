//
//  MTSlideToOpen-SwiftUI.swift
//  MTSlideToOpen-SwiftUI
//
//  Created by Le Manh Tien on 6/8/19.
//  Copyright © 2019 io.tienle. All rights reserved.
//

import SwiftUI

struct MTSlideToOpen: View {
    
    // Public Property
    var sliderTopBottomPadding: CGFloat = 0
    var thumbnailTopBottomPadding: CGFloat = 0
    var thumbnailLeadingTrailingPadding: CGFloat = 0
    var textLabelLeadingPadding: CGFloat = 0
    var text: String = "MTSlideToOpen"
    var textFont: Font = .system(size: 15)
    var textColor = Color(.sRGB, red: 25.0/255, green: 155.0/255, blue: 215.0/255, opacity: 0.7)
    var thumbnailColor = Color(.sRGB, red: 25.0/255, green: 155.0/255, blue: 215.0/255, opacity: 1)
    var thumbnailBackgroundColor: Color = .clear
    var sliderBackgroundColor = Color(.sRGB, red: 0.1, green: 0.64, blue: 0.84, opacity: 0.1)
    var resetAnimation: Animation = .easeIn(duration: 0.3)
    var iconName = "ic_arrow"
    var didReachEndAction: ((MTSlideToOpen) -> Void)?
    
    // Private Property
    @State private var draggableState: DraggableState = .ready
    
    private enum DraggableState {
        case ready
        case dragging(offsetX: CGFloat, maxX: CGFloat)
        case end(offsetX: CGFloat)
        
        var reachEnd: Bool {
            switch self {
            case .ready, .dragging(_):
                return false
            case .end(_):
                return true
            }
        }
        
        var isReady: Bool {
            switch self {
            case .dragging(_), .end(_):
                return false
            case .ready:
                return true
            }
        }
        
        var offsetX: CGFloat {
              switch self {
              case .ready:
                return 0.0
              case .dragging(let (offsetX,_)):
                  return offsetX
              case .end(let offsetX):
                  return offsetX
              }
          }
        
        var textColorOpacity: Double {
            switch self {
            case .ready:
                return 1.0
            case.dragging(let (offsetX,maxX)):
                return 1.0 - Double(offsetX / maxX)
            case .end(_):
                return 0.0
            }
        }
        
    }
    
    var body: some View {
        return GeometryReader { geometry in
            self.setupView(geometry: geometry)
        }
    }
    
    private func setupView(geometry: GeometryProxy) -> some View {
        let frame = geometry.frame(in: .global)
        let width = frame.size.width
        let height = frame.size.height
        let drag = DragGesture()
            .onChanged({ (drag) in
                let maxX = width - height - self.thumbnailLeadingTrailingPadding * 2 + self.thumbnailTopBottomPadding * 2
                let currentX = drag.translation.width
                if currentX >= maxX {
                    self.draggableState = .end(offsetX: maxX)
                    self.didReachEndAction?(self)
                } else if currentX <= 0 {
                    self.draggableState = .dragging(offsetX: 0, maxX: maxX)
                } else {
                    self.draggableState = .dragging(offsetX: currentX, maxX: maxX)
                }
            })
            .onEnded(onDragEnded)
        let sliderCornerRadius = (height - sliderTopBottomPadding * 2) / 2
        return HStack {
                ZStack(alignment: .leading, content: {
                    HStack {
                        Text(self.text)
                        .frame(maxWidth: .infinity)
                        .padding([.leading], textLabelLeadingPadding)
                        .foregroundColor(self.textColor)
                        .opacity(self.draggableState.textColorOpacity)
                        .animation(self.draggableState.isReady ? self.resetAnimation : nil)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(self.sliderBackgroundColor)
                    .cornerRadius(sliderCornerRadius)
                    .padding([.top, .bottom], self.sliderTopBottomPadding)
                    
                    Image(iconName)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(1.0, contentMode: .fit)
                    .background(self.thumbnailColor)
                    .clipShape(Circle())
                    .padding([.top, .bottom], self.thumbnailTopBottomPadding)
                    .padding([.leading, .trailing], self.thumbnailLeadingTrailingPadding)
                    .background(self.thumbnailBackgroundColor)
                    .cornerRadius(sliderCornerRadius)
                    .offset(x: self.self.draggableState.offsetX)
                    .animation(self.draggableState.isReady ? self.resetAnimation : nil)
                    .gesture(self.draggableState.reachEnd ? nil : drag)
                  })
                }
                .background(Color.white)
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        switch draggableState {
        case .end(_), .dragging(_):
            draggableState = .ready
            break
        case .ready:
            break
        }
    }
    
    // MARK: Public Function
    
    func resetState(_ animated: Bool = true) {
        self.draggableState = .ready
    }
}

