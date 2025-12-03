# Memory Match - Floating Memory Game

## Description
**Memory Match** is a device-agnostic memory game built with **Flutter** and the **Flame Engine**. 
Unlike traditional static grid-based memory games, Memory Match features a dynamic "floating" mechanic: cards move freely across the screen, bouncing off the edges, adding a layer of physics-based difficulty to the classic memory challenge.

The project demonstrates advanced Flutter concepts including:
- **Reactive State Management** (GetX)
- **Persistent Local Storage** (Hive)
- **Responsive & Adaptive Layouts**
- **Game Loop & Physics** (Flame)

## Deployed Application
Play the game online here:
**https://matteocivitillo.github.io/flutter-flame-memory/**

*(Note: The game works best on mobile browsers or resized desktop windows due to its vertical-first design, but adapts to any resolution).*

## How to Play
1.  **Start:** Tap "PLAY" on the home screen.
2.  **Select Level:** Choose an unlocked level. You start with Level 1.
    * *Level 1:* 4 cards (Easy)
    * *Level 2:* 6 cards (Medium)
    * *Level 3:* 8 cards (Hard)
    * *Level 4:* 10 cards (Expert)
3.  **The Game:**
    * Cards float around the screen.
    * **Tap a card** to stop it and reveal its image.
    * **Tap a second card** to try and find a match.
    * **Match:** If images match, cards vanish and you gain points.
    * **Mismatch:** If images differ, cards flip back after a second and change their direction randomly!
4.  **Win:** Find all pairs before the timer runs out.
5.  **Progress:** Completing a level permanently unlocks the next one and saves your best time.

## Technical Details & Requirements Met
This project fulfills the course requirements as follows:

* **Engine:** Built using **Flame 1.16.0**.
* **Screens:** Includes Start, Level Selection, Game, Result, and Summary screens.
* **Navigation:** Intuitive navigation using GetX named routes.
* **Responsiveness:** * Uses a `ResponsiveScaffold` with a max-width constraint (960px).
    * Implements a breakpoint (600px) to adjust padding and layout.
    * Flame game world scales dynamically to fit the screen size (`onGameResize`).
* **Persistence:** Uses **Hive** to save unlocked levels and completion times across app restarts.
* **Input:** Fully playable via touchscreen (TapCallbacks) or mouse.

## Architecture
The project follows a clean **MVVM-like** architecture (implemented via GetX):
* **Models:** Data definitions (`LevelModel`).
* **Services:** Data persistence layer (`StorageService`).
* **ViewModels (Controllers):** Logic and State Management (`GameController`).
* **Views (Screens/Widgets):** UI Layer.
* **Game:** Flame components and physics logic.
