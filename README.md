
# Basketball Schedule Screen with JSON Metadata 

## Overview

This repository contains the solution for the **Mobile Dev Assignment** where a **Basketball Schedule Screen** is created using **SwiftUI** to display game schedules. The project uses **Schedule.json** and **teams.json** to fetch and display basketball game schedules with additional features like dynamic sticky month headers, game status, team logos, and user-localized game times.

The project follows the **MVVM (Model-View-ViewModel)** architecture and implements state management using `@State`, `@Binding`, and `@ObservableObject` for clean and maintainable code.

---

## Problem Statement

The goal of this project was to create a basketball schedule screen that dynamically displays the following features:

1. A schedule list with months as sticky headers.
2. Fetching game data from **Schedule.json**.
3. Displaying team names, logos, game time, and arena details.
4. Properly representing home and away teams with respective positions.
5. Converting game times to the user's local time zone.
6. Displaying team logos fetched from **teams.json**.

### Requirements

1. **Schedule List**:
   - Sticky month headers.
   - Future, Live, and Past game status.
   - Home team on the right, visitor team on the left.

2. **Game Data**:
   - Team names and logos.
   - Game date, time, and arena name.

3. **App Team**:
   - Assume `tid="1610612748"` refers to the app team, fetched from **teams.json**.

4. **UI Enhancements**:
   - Use team primary colors as background for each game row.
   - Show "vs" if the app team is the Home Team and "@" if it's the Visitor Team.

### Bonus Features

- **Combine**: Simulate API delays when fetching data.
- **Search Bar**: Allow users to filter games by arena, team, or city.
- **Dynamic Scroll**: Scroll to the next upcoming game on app launch.
- **Sticky Header**: Update sticky month header based on scroll position.

---

## Project Structure

### **Model Layer**

- `Match`: Represents individual games with properties such as `teamName`, `teamLogo`, `gameTime`, `arenaName`, etc.
- `Team`: Represents a basketball team with properties like `teamID`, `teamName`, `teamLogo`, and `teamColor`.

### **ViewModel Layer**

- `ScheduleViewModel`: Handles the data fetching, parsing, and transforming the schedule data from **Schedule.json** and **teams.json**. It also manages the filtering and grouping of matches based on the selected month.

### **View Layer**

- **Main Views**:
  - `ScheduleGamesTabView`: Displays the list of games with a search bar and dynamic sticky month headers.
  - `GameCardView`: Displays each game's details such as team logos, game time, and arena.
  - `VerticalMonthSwitcher`: Sticky header that updates as the user scrolls through the games.

---

## Installation & Setup

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/basketball-schedule-swiftui.git
```

### 2. Open the Project in Xcode

- Open the `.xcodeproj` file in Xcode 15.2.

### 3. Build and Run

- Select the target device or simulator.
- Press `Cmd + R` to build and run the project.

---

## Key Features Implemented

### 1. **Fetching Schedule and Team Data**

- Schedule data is fetched from **Schedule.json** and parsed into the `Match` model.
- Team data is fetched from **teams.json** to display logos and team colors.

### 2. **Dynamic Sticky Month Headers**

- The `VerticalMonthSwitcher` view is implemented to display the month header and update as the user scrolls through the games.

### 3. **Search Functionality**

- Added a **search bar** to filter games based on arena, team, or city.
- The search bar works dynamically by updating the game list as the user types.

### 4. **Time Zone Conversion**

- The game time is converted to the user's local time using `DateFormatter`.

### 5. **UI Enhancements**

- Team logos and primary colors are used to enhance the user interface.
- The game’s row background color is set based on the team's primary color for a more dynamic design.

### 6. **Game Status Indicators**

- Each game’s status (Future, Live, or Past) is displayed.
- If the app team is the home team, the label shows **"vs"**, and if it’s the visitor team, it shows **"@"**.

## Future Enhancements

- **Error Handling**: Improve error handling for API calls and parsing issues.
- **Pagination**: Handle large data sets efficiently with pagination or lazy loading.
- **Refinement of UI**: Add animations and transitions for a smoother user experience.

---

## Technologies Used

- **SwiftUI**: For building the user interface.
- **Combine**: To simulate network calls with delays (mock API call).
- **DateFormatter**: To convert game times to the user’s local time zone.
- **MVVM Architecture**: For clean and modular code.

---
