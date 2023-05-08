//
//  ContentView.swift
//  Slider
//
//  Created by Joacim Nidén on 2023-05-06.
//

import SwiftUI

struct ContentView: View {
	@State private var sliderValue: Double = 50
	
	var body: some View {
		VStack {
			Text("Slider Value: \(sliderValue)")
				.padding(30)
			
			CustomSlider(value: $sliderValue)
		}
	}
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
