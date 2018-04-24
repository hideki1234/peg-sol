module Peg
    (
      Peg
    , Move
    , Board
    , solvePeg
    , initialBoard
    , movePeg
    , searchMoves
    ) where

import Control.Monad (join)
import Data.Array

type Peg = Int
type Move = (Peg, Peg, Peg)
type Board = [Bool]

moveTuplesList :: [[Move]]
moveTuplesList = [ [ (0,1,3), (0,2,5) ]
               , [ (1,3,6), (1,4,8) ]
               , [ (2,4,7), (2,5,9) ]
               , [ (3,6,10), (3,7,12), (3,4,5) ]
               , [ (4,7,11), (4,8,13) ]
               , [ (5,8,12), (5,9,14) ]
               , [ (6,7,8) ]
               , [ (7,8,9) ]
               , []
               , []
               , [ (10,11,12) ]
               , [ (11,12,13) ]
               , [ (12,13,14) ]
               , []
               , []
               ]

moveTuples :: Array Peg [Move]
moveTuples = listArray (0,14) moveTuplesList

initialBoard :: Peg -> Board
initialBoard num = map (/=num) [0..14]

possibleMoves :: Board -> [Move]
possibleMoves board = concat $ map (possibleMovesAt board) [0..14]

possibleMovesAt :: Board -> Peg -> [Move]
possibleMovesAt board peg =
    concat $ map (possibleMove board) (moveTuples ! peg)
    where
        possibleMove board (st,mv,ed) =
            if (board !! st) == (board !! ed) || (board !! mv) == False then []
            else if board !! st then [(st,mv,ed)]
                 else [(ed,mv,st)]

movePeg :: Move -> Board -> Board
movePeg (st,rm,ed) = map moveIt . zip [0..]
    where
        moveIt (peg,exist) = if peg == st || peg == ed then not exist
                             else if peg == rm then False else exist

searchMoves :: Int -> Board -> [[Move]]
searchMoves 2 board = map (:[]) $ possibleMoves board
searchMoves numPegs board =
    if null moves then []
    else concat $ map solveOne moves
    where
        moves = possibleMoves board
        solveOne aMove = map (aMove:) $ filter (not.null) $ searchMoves (numPegs-1) $ movePeg aMove board



-- solvePeg 
solvePeg :: Peg -> [[Move]]
solvePeg hole = 
    if hole < 0 || hole > 14 then error "Invalid peg"
    else searchMoves 14 (initialBoard hole)

