import { backend } from 'declarations/backend';

const grid = document.getElementById('grid');
const movesDisplay = document.getElementById('moves');
const newGameButton = document.getElementById('newGame');

let currentGrid = [];

async function updateGrid() {
    currentGrid = await backend.getGrid();
    grid.innerHTML = '';
    for (let i = 0; i < 5; i++) {
        for (let j = 0; j < 5; j++) {
            const tile = document.createElement('div');
            tile.className = 'tile';
            tile.textContent = currentGrid[i][j] || '';
            tile.addEventListener('click', () => makeMove(i, j));
            grid.appendChild(tile);
        }
    }
}

async function updateMoves() {
    const moves = await backend.getMoves();
    movesDisplay.textContent = moves;
}

async function makeMove(row, col) {
    const success = await backend.makeMove(row, col);
    if (success) {
        await updateGrid();
        await updateMoves();
        checkWin();
    }
}

async function checkWin() {
    const solved = await backend.isSolved();
    if (solved) {
        alert('Congratulations! You solved the puzzle!');
    }
}

async function newGame() {
    await backend.newGame();
    await updateGrid();
    await updateMoves();
}

newGameButton.addEventListener('click', newGame);

// Initialize the game
newGame();
