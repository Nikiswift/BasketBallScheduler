//
//  MonthSwitcher.swift
//  BasketBallSchedule
//
//  Created by Nikhil1 Desai on 08/05/25.
//

import SwiftUI

struct VerticalMonthSwitcher: View {
    @Binding var selectedMonthIndex: Int
    let months: [String]

    var body: some View {
        HStack(spacing: 8) {
            Button(action: previousMonth) {
                Image(systemName: "chevron.up")
                    .modifier(MonthSwitcherIconModifier(isEnabled: selectedMonthIndex > 0))
            }
            .disabled(selectedMonthIndex == 0)

            ZStack {
                ForEach(months.indices, id: \.self) { index in
                    if index == selectedMonthIndex {
                        Text(months[index])
                            .modifier(MonthLabelModifier())
                            .id(index)
                    }
                }
            }
            .animation(.easeInOut(duration: 0.3), value: selectedMonthIndex)

            Button(action: nextMonth) {
                Image(systemName: "chevron.down")
                    .modifier(MonthSwitcherIconModifier(isEnabled: selectedMonthIndex < months.count - 1))
            }
            .disabled(selectedMonthIndex == months.count - 1)
        }
    }

    private func previousMonth() {
        withAnimation(.easeInOut) {
            if selectedMonthIndex > 0 {
                selectedMonthIndex -= 1
            }
        }
    }

    private func nextMonth() {
        withAnimation(.easeInOut) {
            if selectedMonthIndex < months.count - 1 {
                selectedMonthIndex += 1
            }
        }
    }
}


struct MonthSwitcherIconModifier: ViewModifier {
    let isEnabled: Bool

    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(isEnabled ? .baseWhite : .gray)
    }
}

struct MonthLabelModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .bold))
            .frame(width: 150)
            .multilineTextAlignment(.center)
            .foregroundStyle(.baseWhite)
            .transition(
                .asymmetric(
                    insertion: .move(edge: .top).combined(with: .opacity),
                    removal: .move(edge: .bottom).combined(with: .opacity)
                )
            )
    }
}
