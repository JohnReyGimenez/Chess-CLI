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

## GitHub Contribution Ideas

- Commit placeholder methods
- Write README and these notes
- Organize file structure
