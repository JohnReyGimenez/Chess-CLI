# 🧪 Dev Notes — Ruby Chess CLI

## Structure Plan

- `Board`: 2D grid with access methods
- `BoardRenderer`: Handles rendering to terminal
- `Piece`: Base class (color, position)
- Subclasses: `Pawn`, `Rook`, `Knight`, etc.

## Next Tasks

- [ ] Define basic `Piece` class with `color`, `symbol`, and placeholder `#moves`
- [ ] Implement `Pawn` and `Knight` with move stubs
- [ ] Integrate pieces into `Board`'s grid

## Rendering Plan

- Use colorized squares based on position (white/black)
- Render piece symbol (e.g., ♞ or P) centered in square
- Possibly use Unicode chess symbols later

## Notes to Self

- Remember to keep render logic clean/separate from game logic
- Make sure to handle coordinates as `[row, col]`
- Start small! Even just printing a piece on the board is a win
- Do most logics during breaks or free time
- Visualize the structure of the project

## CURRENT PROJECT STRUCTURE....

```bash
lib/
└── chess/
    ├── board/
    │   ├── board_general.rb      # General logic for manipulating board state (e.g., #move_piece, #in_bounds?)
    │   └── board_renderer.rb     # Handles visual rendering of the board (e.g., using Unicode pieces)
    │                             # Could be extended later for animations or board themes
    │
    ├── chess_pieces/
    │   ├── bishop.rb             # Bishop-specific logic (diagonal movement)
    │   ├── king.rb               # King logic (1-square, castling, check detection)
    │   ├── knight.rb             # Knight logic (L-shaped moves)
    │   ├── pawn.rb               # Pawn logic (forward, capture, en passant, promotion)
    │   ├── queen.rb              # Queen logic (rook + bishop movement)
    │   └── rook.rb               # Rook logic (straight-line movement and castling)
    │                             # Each file defines a class with #legal_moves(board, from_pos)
    │
    ├── board.rb                 # Core board object with 8x8 grid, move validation, and state updates
    ├── chess.rb                # Top-level Chess module to namespace everything
    ├── chess_pieces.rb         # Requires/loads all the piece classes; possibly includes a PIECE_MAP hash
    ├── game.rb                 # Main game loop: turn flow, win state checks, player switching
    ├── player_input.rb         # Gets and validates input from the player (e.g., "a2 to a3")
    │                           # Could later be split into HumanInput vs AIInput
    │
dev_notes.md                   # Notes, ideas, thoughts during development (good for GitHub history)
Gemfile                        # Gem dependencies like 'tty-prompt' or 'colorize'
Gemfile.lock                   # Auto-generated lockfile
LICENSE                        # License for your open source code
main.rb                        # Entry point — runs Chess::Game.new.play
README.md                      # Project overview, how to run, features, installation

# 🧪 Future Additions

spec/                         # RSpec test folder
└── chess/
    ├── board_spec.rb         # Test board logic (move, in_bounds, piece_at?)
    ├── game_spec.rb          # Test game flow (turns, win condition)
    └── pieces/
        ├── pawn_spec.rb      # Test each piece's legal moves
        └── rook_spec.rb      # etc.

saves/                        # Directory to store serialized game state YAML files
└── game_2025_04_14.yml       # Example save file created by File.write

docs/                         # (Optional) Any design diagrams, rules references, move logic charts

scripts/                      # (Optional) Debug or setup scripts (like seed.rb or load_game.rb)

ai/                           # (Optional) Add AI logic here for extra credit
└── random_bot.rb             # A simple bot that picks a random legal move

```