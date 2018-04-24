module ShowPeg
    where

import Data.List (intersperse)
import Peg (Peg, Move, Board, initialBoard, movePeg)

showPeg :: Bool -> Char
showPeg peg = if peg then 'I' else '.'

formatBoard :: String -> String
formatBoard brd =  "    " ++ (brd !! 0)         : "    \n"
                ++ "   "  ++ makeRow [1,2]     ++ "   \n"
                ++ "  "   ++ makeRow [3..5]    ++ "  \n"
                ++ ' '     : makeRow [6..9]    ++ " \n"
                ++           makeRow [10..14]  ++ "\n"
    where
        makeRow = intersperse ' ' . map ((!!) brd)

addMove :: Move -> String -> String
addMove (s,r,_) = map (\(p,c) -> if p==s then 'S' else if p== r then 'o' else c) . zip [0..]

addMoves :: [Move] -> [String] -> [String]
addMoves [] xs = xs
addMoves (m:ms) (x:xs) = addMove m x : addMoves ms xs

showBoard :: Board -> String
showBoard = map showPeg

solutionBoards :: Board -> [Move] -> [Board]
solutionBoards initial [] = [initial]
solutionBoards initial (move:moves) = initial : solutionBoards (movePeg move initial) moves

showBoards :: [Board] -> [String]
showBoards = map (map showPeg)

showSolution :: Peg -> [Move] -> [String]
showSolution peg moves = map formatBoard solString
    where
        solutions = solutionBoards (initialBoard peg) moves
        solString = addMoves moves $ showBoards solutions

