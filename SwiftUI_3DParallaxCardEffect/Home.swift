//
//  Home.swift
//  SwiftUI_3DParallaxCardEffect
//
//  Created by paku on 2024/01/04.
//

import SwiftUI

struct Home: View {
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let imageSize = size.width * 0.7
            VStack {
                Image("Shoe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSize)
                    .rotationEffect(.init(degrees: -30))
                    .offset(x: -20)
                    .zIndex(1)
                    .offset(x: horizontalGestureOffsetToAngle().degrees * 5,
                            y: verticalGestureOffsetToAngle().degrees * 5)
                
                Text("NIKE AIR")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .padding(.top, -69)
                    .padding(.bottom, 50)
                    .zIndex(0)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("NIKE")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .fontWidth(.compressed)
                    
                    HStack {
                        BlendedText("AIR JORDAN 1 MID SE")
                        
                        Spacer()
                        
                        BlendedText("$128")
                    }
                    
                    HStack {
                        BlendedText("YOUR NEXT SHOES")
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            
                        } label: {
                            Text("BUY")
                                .fontWeight(.bold)
                                .foregroundStyle(Color("BG"))
                                .padding(12)
                                .background {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color("Yellow"))
                                        .brightness(-0.1)
                                }
                        }
                    }
                    .padding(.top, 14)
                    
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundColor(.white)
            .padding(.top, 65)
            .frame(width: imageSize)
            .padding(.horizontal)
            .background {
                ZStack {
                    Rectangle()
                        .fill(Color("BG"))

                    Circle()
                        .fill(Color("Yellow"))
                        .frame(width: imageSize, height: imageSize)
                        .scaleEffect(1.2, anchor: .leading)
                        .offset(x: imageSize * 0.3, y: -imageSize * 0.6)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            // x軸を中心に回る 例：degree:90 or -90 は見えない
            .rotation3DEffect(verticalGestureOffsetToAngle(), axis: (x: -1, y: 0, z: 0))
            // y軸を中心に回る
            .rotation3DEffect(horizontalGestureOffsetToAngle(), axis: (x: 0, y: -1, z: 0))
            .scaleEffect(0.9)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        offset = value.translation
                    })
                    .onEnded({ value in
                        withAnimation(.smooth) {
                            offset = .zero

                        }
                    })
            )
        }
    }
    
    func verticalGestureOffsetToAngle() -> Angle {
        // CardのGesture領域が画面サイズのおよそ半分なので gesture Start(0.0)からEnd(0.5)まで
        // progress = 0.0 ~ 0.5
        let progress = offset.height / screenSize.height
        
        // 0.0 * 10 ~ 0.5 * 10
        // 0.0 ~ 5.0
        return .init(degrees: progress * 10)
    }
    
    func horizontalGestureOffsetToAngle() -> Angle {
        let progress = offset.width / screenSize.width
        return .init(degrees: progress * 10)
    }
    
    var screenSize: CGSize {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }
    
    @ViewBuilder
    func BlendedText(_ text: String) -> some View {
        Text(text)
            .font(.title3)
            .fontWeight(.semibold)
            .fontWidth(.condensed)
            .blendMode(.difference)
    }
}

#Preview {
    Home()
}
