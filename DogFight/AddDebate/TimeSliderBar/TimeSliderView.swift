//
//  TimeSliderView.swift
//  DogFight
//
//  Created by 오영석 on 2023/09/15.
//
import SwiftUI

struct TimeSliderView: View {
    @Binding var sliderValue: Double

    var body: some View {
        VStack {
            Text(" \(formattedTime(Int(sliderValue * 30 * 60)))")
                .bold()
                .font(.custom("SigmarOne-Regular", size: UIScreen.main.bounds.width * 0.055))
                .foregroundColor(.white)
            Slider(value: $sliderValue, in: 0...48, step: 1)
                .padding()
                .accentColor(.white)
        }
    }

    private func formattedTime(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        return String(format: "Debate For %02d:%02d times", hours, minutes)
    }
}


struct TimeSliderView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSliderView(sliderValue: .constant(0.5))
    }
}
