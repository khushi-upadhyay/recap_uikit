//
//  PuzzleGameViewController.swift
//  recap
//
//  Created by Diptayan Jash on 14/12/24.
//
import UIKit

class PuzzleGameViewController: UIViewController {
    
    // MARK: - Properties
    private let gridSize = 3 // 3x3 grid
    private var pieces: [UIImageView] = []
    private var emptyPosition: Int = 8 // Last position is initially empty
    private var moves = 0
    private var timer: Timer?
    private var seconds = 0
    private var selectedPiece: UIImageView?
    private var originalPosition: CGPoint?
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let gridView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let statsView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let movesLabel: UILabel = {
        let label = UILabel()
        label.text = "Moves: 0"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "Time: 00:00"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let newGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Game", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGame()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "Memory Puzzle"
        view.backgroundColor = .systemBackground
        
        [containerView, statsView, newGameButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        containerView.addSubview(gridView)
        gridView.translatesAutoresizingMaskIntoConstraints = false
        
        [movesLabel, timerLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            statsView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor),
            
            gridView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            gridView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            gridView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9),
            gridView.heightAnchor.constraint(equalTo: gridView.widthAnchor),
            
            statsView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -20),
            statsView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            statsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            statsView.heightAnchor.constraint(equalToConstant: 50),
            
            movesLabel.leadingAnchor.constraint(equalTo: statsView.leadingAnchor, constant: 16),
            movesLabel.centerYAnchor.constraint(equalTo: statsView.centerYAnchor),
            
            timerLabel.trailingAnchor.constraint(equalTo: statsView.trailingAnchor, constant: -16),
            timerLabel.centerYAnchor.constraint(equalTo: statsView.centerYAnchor),
            
            newGameButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newGameButton.widthAnchor.constraint(equalToConstant: 200),
            newGameButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        newGameButton.addTarget(self, action: #selector(newGameTapped), for: .touchUpInside)
    }
    
    private func setupGame() {
        pieces.forEach { $0.removeFromSuperview() }
        pieces.removeAll()
        
        // Initialize pieces
        let pieceSize = gridView.bounds.width / CGFloat(gridSize)
        let image = UIImage(named: "puzzle_image") ?? UIImage(systemName: "photo")!
        
        for row in 0..<gridSize {
            for col in 0..<gridSize {
                if row * gridSize + col == gridSize * gridSize - 1 {
                    continue
                }
                
                let pieceView = createPuzzlePiece(at: row * gridSize + col, size: pieceSize, image: image)
                pieces.append(pieceView)
                gridView.addSubview(pieceView)
            }
        }
        
        shufflePieces()
        startTimer()
    }
    
    private func createPuzzlePiece(at index: Int, size: CGFloat, image: UIImage) -> UIImageView {
        let pieceView = UIImageView()
        pieceView.contentMode = .scaleAspectFill
        pieceView.clipsToBounds = true
        pieceView.isUserInteractionEnabled = true
        
        let row = CGFloat(index / gridSize)
        let col = CGFloat(index % gridSize)
        pieceView.frame = CGRect(x: col * size, y: row * size, width: size, height: size)
        
        let pieceSize = CGSize(width: image.size.width / CGFloat(gridSize),
                             height: image.size.height / CGFloat(gridSize))
        let pieceRect = CGRect(x: col * pieceSize.width,
                             y: row * pieceSize.height,
                             width: pieceSize.width,
                             height: pieceSize.height)
        
        if let cgImage = image.cgImage?.cropping(to: pieceRect) {
            pieceView.image = UIImage(cgImage: cgImage)
        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(piecePanned(_:)))
        pieceView.addGestureRecognizer(panGesture)
        
        pieceView.tag = index
        return pieceView
    }
    
    private func shufflePieces() {
        var positions = Array(0..<gridSize * gridSize - 1)
        positions.shuffle()
        
        for (index, piece) in pieces.enumerated() {
            let row = CGFloat(positions[index] / gridSize)
            let col = CGFloat(positions[index] % gridSize)
            let size = gridView.bounds.width / CGFloat(gridSize)
            piece.frame = CGRect(x: col * size, y: row * size, width: size, height: size)
        }
    }
    
    // MARK: - Game Logic
    @objc private func piecePanned(_ gesture: UIPanGestureRecognizer) {
        guard let piece = gesture.view as? UIImageView else { return }
        
        switch gesture.state {
        case .began:
            selectedPiece = piece
            originalPosition = piece.center
            piece.superview?.bringSubviewToFront(piece)
            UIView.animate(withDuration: 0.1) {
                piece.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                piece.alpha = 0.8
            }
            
        case .changed:
            let translation = gesture.translation(in: gridView)
            piece.center = CGPoint(
                x: (originalPosition?.x ?? 0) + translation.x,
                y: (originalPosition?.y ?? 0) + translation.y
            )
            
        case .ended, .cancelled:
            UIView.animate(withDuration: 0.1) {
                piece.transform = .identity
                piece.alpha = 1.0
            }
            
            let piecePosition = getPiecePosition(piece)
            if canMovePiece(at: piecePosition) {
                movePiece(piece, to: emptyPosition)
                moves += 1
                movesLabel.text = "Moves: \(moves)"
                
                if checkWin() {
                    gameWon()
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    piece.center = self.originalPosition ?? piece.center
                }
            }
            
            selectedPiece = nil
            originalPosition = nil
            
        default:
            break
        }
    }
    
    private func getPiecePosition(_ piece: UIImageView) -> Int {
        let size = gridView.bounds.width / CGFloat(gridSize)
        let row = Int(piece.frame.minY / size)
        let col = Int(piece.frame.minX / size)
        return row * gridSize + col
    }
    
    private func canMovePiece(at position: Int) -> Bool {
        let emptyRow = emptyPosition / gridSize
        let emptyCol = emptyPosition % gridSize
        let pieceRow = position / gridSize
        let pieceCol = position % gridSize
        
        return (abs(emptyRow - pieceRow) == 1 && emptyCol == pieceCol) ||
               (abs(emptyCol - pieceCol) == 1 && emptyRow == pieceRow)
    }
    
    private func movePiece(_ piece: UIImageView, to position: Int) {
        let size = gridView.bounds.width / CGFloat(gridSize)
        let row = CGFloat(position / gridSize)
        let col = CGFloat(position % gridSize)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            piece.frame = CGRect(x: col * size, y: row * size, width: size, height: size)
        }
        
        emptyPosition = position // Update empty position after move
    }
    
    private func checkWin() -> Bool {
        for piece in pieces {
            if getPiecePosition(piece) != piece.tag {
                return false
            }
        }
        return true
    }
    
    private func gameWon() {
        timer?.invalidate()
        
        let alert = UIAlertController(
            title: "Congratulations!",
            message: "You solved the puzzle in \(moves) moves and \(formatTime(seconds))!",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "New Game", style: .default) { [weak self] _ in
            self?.newGameTapped()
        })
        
        present(alert, animated: true)
    }
    
    // MARK: - Timer
    private func startTimer() {
        seconds = 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.seconds += 1
            self?.updateTimerLabel()
        }
    }
    
    private func updateTimerLabel() {
        timerLabel.text = "Time: \(formatTime(seconds))"
    }
    
    private func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc private func newGameTapped() {
        moves = 0
        movesLabel.text = "Moves: 0"
        setupGame()
    }
    
    deinit {
        timer?.invalidate()
    }
}
