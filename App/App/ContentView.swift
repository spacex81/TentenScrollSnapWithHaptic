import SwiftUI

struct ContentView: View {
    @State private var lastSnappedIndex: Int? = nil
    let strokeSize = 130.0
    let circleSize = 150.0

    var body: some View {
        ZStack {
            ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(0..<10) { i in
                            GeometryReader { geometry in
                                Circle()
                                    .fill(.blue)
                                    .frame(width: circleSize, height: 100)
                                    .onChange(of: geometry.frame(in: .global).midX) { newValue, oldValue in
                                        let screenMidX = UIScreen.main.bounds.width / 2
                                        if abs(newValue - screenMidX) < 70 {
        //                                if abs(newValue - screenMidX) < 100 {
                                            if lastSnappedIndex != i {
                                                lastSnappedIndex = i
                                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                                generator.impactOccurred()
                                            }
                                        }
                                    }
                            }
                            .frame(width: circleSize, height: 100)
                        }
                    }
                    
                .scrollTargetLayout()
                .padding(.horizontal, (UIScreen.main.bounds.width - circleSize) / 2)
            }
            .scrollTargetBehavior(.viewAligned)
            .background(Color.black.ignoresSafeArea())
            
            Circle()
                .stroke(.white, lineWidth: 10)
                .frame(width: 130, height: 130)
        }
    }
}
#Preview {
    ContentView()
}




