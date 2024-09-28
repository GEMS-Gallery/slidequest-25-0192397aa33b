import Bool "mo:base/Bool";

import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Random "mo:base/Random";

actor SliderPuzzle {
    private var grid : [[var Nat]] = Array.tabulate(5, func(i : Nat) : [var Nat] {
        Array.tabulateVar(5, func(j : Nat) : Nat {
            i * 5 + j + 1
        })
    });
    grid[4][4] := 0; // Set the last tile as empty (0)

    private var moves : Nat = 0;

    public func newGame() : async [[Nat]] {
        moves := 0;
        await shuffleGrid();
        Array.map(grid, func(row : [var Nat]) : [Nat] { Array.freeze(row) })
    };

    public query func getGrid() : async [[Nat]] {
        Array.map(grid, func(row : [var Nat]) : [Nat] { Array.freeze(row) })
    };

    public query func getMoves() : async Nat {
        moves
    };

    public func makeMove(row : Nat, col : Nat) : async Bool {
        let (emptyRow, emptyCol) = findEmptyTile();
        if (isValidMove(row, col, emptyRow, emptyCol)) {
            let temp = grid[row][col];
            grid[row][col] := 0;
            grid[emptyRow][emptyCol] := temp;
            moves += 1;
            true
        } else {
            false
        }
    };

    public query func isSolved() : async Bool {
        var expected = 1;
        for (row in grid.vals()) {
            for (tile in row.vals()) {
                if (tile != expected and expected != 25) {
                    return false;
                };
                expected += 1;
            };
        };
        true
    };

    private func shuffleGrid() : async () {
        let seed = await Random.blob();
        var rng = Random.Finite(seed);
        
        for (_ in Iter.range(0, 999)) {
            let row1 = Nat.abs(randomNat(rng) % 5);
            let col1 = Nat.abs(randomNat(rng) % 5);
            let row2 = Nat.abs(randomNat(rng) % 5);
            let col2 = Nat.abs(randomNat(rng) % 5);
            
            let temp = grid[row1][col1];
            grid[row1][col1] := grid[row2][col2];
            grid[row2][col2] := temp;
        };
    };

    private func randomNat(rng : Random.Finite) : Nat {
        switch (rng.byte()) {
            case null 0;
            case (?b) Nat8.toNat(b);
        }
    };

    private func findEmptyTile() : (Nat, Nat) {
        for (i in Iter.range(0, 4)) {
            for (j in Iter.range(0, 4)) {
                if (grid[i][j] == 0) {
                    return (i, j);
                };
            };
        };
        (4, 4) // Default to last position if not found
    };

    private func isValidMove(row : Nat, col : Nat, emptyRow : Nat, emptyCol : Nat) : Bool {
        (row == emptyRow and Nat.abs(col - emptyCol) == 1) or
        (col == emptyCol and Nat.abs(row - emptyRow) == 1)
    };
}
