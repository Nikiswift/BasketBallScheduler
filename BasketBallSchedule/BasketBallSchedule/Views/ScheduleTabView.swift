//
//  ScheduleTabView.swift
//  BasketBallSchedule
//
//  Created by Nikhil1 Desai on 08/05/25.
//

import SwiftUI

struct ScheduleGamesTabView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    @State private var selectedTab = 0
    @State private var isSearching = false
    @State private var selectedMonthIndex = 0

    let tabTitles = ["Schedule", "Games"]

    var body: some View {
        VStack(spacing: 0) {
            headerView()

            if isSearching {
                searchBar()
            }

            tabBar()

            Divider()

            ScrollView {
                contentView()
            }
        }
        .task { viewModel.loadData() }
        .animation(.smooth, value: isSearching)
        .background(.darkBlack)
    }

    // MARK: - View Builders

    @ViewBuilder
    private func headerView() -> some View {
        ZStack {
            Text("Team")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.baseWhite)

            HStack {
                Spacer()
                Button {
                    withAnimation(.interpolatingSpring(stiffness: 300, damping: 20)) {
                        isSearching.toggle()
                    }
                } label: {
                    Image(systemName: isSearching ? "xmark.circle.fill" : "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 56)
    }

    @ViewBuilder
    private func searchBar() -> some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search arena, team, city", text: $viewModel.searchText)
                .foregroundColor(.white)
                .accentColor(.white)
                .placeholder(when: viewModel.searchText.isEmpty) {
                    Text("Search arena, team, city").foregroundColor(.baseWhite)
                }

            if !viewModel.searchText.isEmpty {
                Button(action: { viewModel.searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.horizontal)
        .frame(height: 40)
        .cornerRadius(10)
        .padding(8)
    }

    @ViewBuilder
    private func tabBar() -> some View {
        HStack {
            ForEach(tabTitles.indices, id: \.self) { index in
                TabBarItemView(
                    title: tabTitles[index],
                    isSelected: selectedTab == index
                ) {
                    selectedTab = index
                }
            }
        }
        .background(.baseBlack)
        .shadow(color: Color.gray.opacity(0.2), radius: 2, y: 2)
    }

    @ViewBuilder
    private func contentView() -> some View {
        if selectedTab == 0 && !viewModel.sections.isEmpty {
            let filteredMatches = viewModel.sections.flatMap { $0.matches }

            VStack(spacing: 0) {
                LiveMatchesPagerView(liveHomeMatches: filteredMatches.filter {
                    $0.gameStatus == 2 && $0.homeTeam?.teamID == AppConstants.AppNameID
                })

                LazyVStack(alignment: .leading, spacing: 16, pinnedViews: [.sectionHeaders]) {
                    Section(
                        header: VerticalMonthSwitcher(
                            selectedMonthIndex: $selectedMonthIndex,
                            months: viewModel.months
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.baseBlack)
                    ) {
                        ForEach(filteredMatches) { game in
                            GameCardView(schedule: game)
                        }
                    }
                }
            }
        } else {
            EmptyScheduleView()
        }
    }

}


struct TabBarItemView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Text(title)
                    .tabTitleStyle(isSelected: isSelected)
                Rectangle()
                    .tabIndicatorStyle(isSelected: isSelected)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct EmptyScheduleView: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer(minLength: 100)
            Image("NBA")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct TabTitleModifier: ViewModifier {
    let isSelected: Bool

    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(isSelected ? .baseWhite : .gray)
            .padding(.vertical, 12)
    }
}

struct TabIndicatorModifier: ViewModifier {
    let isSelected: Bool

    func body(content: Content) -> some View {
        content
            .frame(height: 2)
            .foregroundColor(isSelected ? .yellow : .clear)
            .padding(.horizontal, 4)
    }
}

extension View {
    func tabTitleStyle(isSelected: Bool) -> some View {
        self.modifier(TabTitleModifier(isSelected: isSelected))
    }

    func tabIndicatorStyle(isSelected: Bool) -> some View {
        self.modifier(TabIndicatorModifier(isSelected: isSelected))
    }
}


#Preview {
    ScheduleGamesTabView(viewModel: ScheduleViewModel(matchService: MatchService(), teamService: TeamService()))
}

