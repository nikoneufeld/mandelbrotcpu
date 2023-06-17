//
//  ContentView.swift
//  mandelbrotcpu
//
//  Created by Niko Neufeld on 14.06.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Canvas { context, size in
                let (xmin, xmax) = (-1.0, 0.8)
                let (ymin, ymax) = (-0.6 * size.height / size.width, 1.0 * size.height / size.width)
                let stepx = (xmax - xmin) / size.width
                let stepy = (ymax - ymin) / size.height
                let maxIter = 100
                var x = xmin
                var i = 0
                while i < Int(size.width) {
                    var y = ymin
                    var j = 0
                    while j < Int(size.height) {
                        let mandelIter = mandel(x, y, n: maxIter)
                        context.stroke(
                            Path(ellipseIn: CGRect(origin: CGPoint(x: i, y: j), size:  CGSize(width: 1, height: 1))),
                            with: .color(Color(red: 0.0,
                                               green: mandelIter == maxIter ? 1.0 : 0.0,
                                               blue: mandelIter == maxIter ? 0.0 :
                                                Double(mandelIter) / Double(maxIter))),
                            lineWidth: 1)
                        y = y + stepy
                        j = j + 1
                    }
                    x = x + stepx
                    i = i + 1
                }
            }
            .frame(width: 600, height: 400)
            .border(Color.blue)

        }
        .padding()
    }
}

func mandel(_ cx: Double, _ cy: Double, n: Int) -> Int {
    var i = 0
    var x = 0.0
    var y = 0.0
    var x2 = 0.0
    var y2 = 0.0
    while (i < n) && (x2 + y2 < 10000.0) {
        let temp = x2 - y2 + cx
        y = 2 * x * y + cy
        x = temp
        x2 = x * x
        y2 = y * y
        i = i + 1
    }
    return i
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
