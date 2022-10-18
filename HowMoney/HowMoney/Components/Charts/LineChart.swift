//
//  LineChart.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 17/10/2022.
//

import SwiftUI

typealias ChartsData = [CGFloat]

struct LineChart: View {
    
    private enum Constants {
        enum Animation {
            static let duration: CGFloat = 1.5
            static let delay: CGFloat = 0.2
        }
        enum Line {
            static let defaultWidth: CGFloat = 2.0
            static let lineCap: CGLineCap = .round
            static let lineJoin: CGLineJoin = .round
            static let radius: CGFloat = 10.0
        }
        static let minScaleFactor: CGFloat = 0.8
        static let maxScaleFactor: CGFloat = 1.2
    }
    
    var lineColor: Color = .white
    var lineWidth: CGFloat?
    
    @State private var percentageChartShown: CGFloat = .zero
    private var data: ChartsData
    
    init(data: ChartsData) {
        self.data = data
    }

    var body: some View {
        GeometryReader { geo in
            let min = Constants.minScaleFactor * (data.min() ?? .zero)
            let max = Constants.maxScaleFactor * (data.max() ?? .zero)
            let yRange = max - min
            Path { path in
                for (index, value) in data.enumerated() {
                    let xPosition = geo.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yPosition = (1 - (value - min) / yRange) * geo.size.height
                    
                    if index == .zero {
                        path.move(to: CGPoint(x: .zero, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: .zero, to: percentageChartShown)
            .stroke(lineColor, style: StrokeStyle(lineWidth: lineWidth ?? Constants.Line.defaultWidth, lineCap: Constants.Line.lineCap, lineJoin: Constants.Line.lineJoin))
            .shadow(color: lineColor, radius: Constants.Line.radius, x: .zero, y: .zero)
            .shadow(color: lineColor.opacity(0.5), radius: Constants.Line.radius, x: .zero, y: 10)
            .shadow(color: lineColor.opacity(0.3), radius: Constants.Line.radius, x: .zero, y: 20)
            .shadow(color: lineColor.opacity(0.1), radius: Constants.Line.radius, x: .zero, y: 30)

        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.Animation.delay) {
                withAnimation(.linear(duration: Constants.Animation.duration)) {
                    percentageChartShown = 1.0
                }
            }
        }
    }
}

struct LineChart_Previews: PreviewProvider {
    
    static var data: ChartsData = AssetHistoryRecord.DollarHistoryMock.map { $0.value }
    
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            LineChart(data: data)
        }
    }
}
