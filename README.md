# Chess

A command-line Chess game built with Ruby. This project focuses on object-oriented programming, game logic, and command-line interaction. UI style and board rendering logic heavily inspired by Lucas Sorribes' [Ruby Chess blog](https://medium.com/@lucas.sorribes/nostromo-my-ruby-chess-journey-part-i-7ef544b547a5) and  [sapphire-chess](https://github.com/devluxor/sapphire-chess).

<p align="center">
  <img src="https://raw.githubusercontent.com/JohnReyGimenez/Chess-CLI/main/media/gameplay.gif" width="500" />
</p>

---

## Features

- Two-player chess game in the terminal
- Move validation and turn-based gameplay
- Check and checkmate detection
- Save and load game functionality

### Prerequisites
- **Ruby**: Ensure Ruby is installed on your system.
   ```bash
  ruby -v
- **Bundler**: Install Bundler to manage dependencies.
  ```bash
   gem install bundler

---

## Installation

1. Fork the Repository:
   - Go to the [Chess-CLI](https://github.com/JohnReyGimenez/Chess-CLI) repository and click the Fork button to create your own copy of the project.
2. Clone the repository.
   ```bash
   git@github.com:JohnReyGimenez/Chess-CLI.git
3. Install dependencies using Bundler.
   ```bash
   bundle install
4. Run the game.
   ```bash
   ruby main.rb

---

## Core Logic Test Suite
This project includes a lightweight RSpec test suite focused on validating movement logic and initial configurations for chess pieces.

### What's Covered
- Initialization of piece instance variables (location and color)  
- Valid movement logic for all pieces valid moves

### File Structure
```
spec/
└── pieces/
    ├── pawn_spec.rb
    ├── rook_spec.rb
    ├── knight_spec.rb
    ├── bishop_spec.rb
    ├── queen_spec.rb
    └── king_spec.rb
```

### How to Run Tests  
```
gem install rspec  # If not installed
```
```
rspec
```
```
rspec spec/pawn_spec.rb  # For specific piece tests
```

**Note:** While this test suite verifies core piece behaviors, you should test other game aspects by actually playing the game. Run the program and verify through gameplay: special rules like castling, en passant, checkmate conditions, and board rendering. For missing test coverage, manually verify key scenarios by playing different game situations.

---

## License
This project is open-source and available under the  [MIT License](LICENSE).
