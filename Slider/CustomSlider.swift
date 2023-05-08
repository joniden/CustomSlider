//
//  CustomSlider.swift
//  Slider
//
//  Created by Joacim Nidén on 2023-05-06.
//

import SwiftUI

struct CustomSlider: View {

	@Binding var value: Double
	
	@State var lastCoordinateValue: CGFloat = 0.0
	var sliderRange: ClosedRange<Double> = 1...100
	let thumbSize: CGFloat = 30
	
	var body: some View {
		GeometryReader { gr in

			let minValue = gr.size.width * 0.015
			let maxValue = (gr.size.width * 0.98) - thumbSize
			
			let scaleFactor = (maxValue - minValue) / (sliderRange.upperBound - sliderRange.lowerBound)
			let lower = sliderRange.lowerBound
			let sliderVal = (self.value - lower) * scaleFactor + minValue
			
			ZStack {
				Rectangle()
					.foregroundColor(.blue)
					.frame(height: 4)
				
				HStack {
					Circle()
						.foregroundColor(Color.yellow)
						.frame(width: thumbSize, height: thumbSize)
						.offset(x: sliderVal)
						.gesture(
							DragGesture(minimumDistance: 0)
								.onChanged { v in
									if (abs(v.translation.width) < 0.1) {
										self.lastCoordinateValue = sliderVal
									}
									if v.translation.width > 0 {
										let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + v.translation.width)
										self.value = ((nextCoordinateValue - minValue) / scaleFactor)  + lower
									} else {
										let nextCoordinateValue = max(minValue, self.lastCoordinateValue + v.translation.width)
										self.value = ((nextCoordinateValue - minValue) / scaleFactor) + lower
									}
									
								}
						)
					Spacer()
				}
				
				HStack {
					ZStack {
						RoundedRectangle(cornerRadius: 10)
							.foregroundColor(Color.black)
							
						Text("\(value, specifier: "%.0f")").foregroundColor(.white).padding()
					}
					.fixedSize()
					.offset(x: sliderVal, y: -thumbSize)
					
					Spacer()
				}
			}
		}
	}
}

struct CustomSlider_Previews: PreviewProvider {
	
	@State private static var sliderValue: Double = 50
	
	static var previews: some View {
		CustomSlider(value: $sliderValue)
	}
}
