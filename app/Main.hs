module Main where

import Peg (solvePeg)
import ShowPeg (showSolution)
import System.Environment(getArgs)
import System.Exit
import Control.Monad (when)

showOneSolution :: (Int, [String]) -> [String]
showOneSolution (solNo, solStr) =
    ("solution " ++ show solNo ++ "\n") : solStr

main :: IO ()
main = do
    args <- getArgs
    when (length args /= 1) $ do
        putStrLn "Please specify the initial hole (0-14)"
        putStrLn "         0"
        putStrLn "       1   2"
        putStrLn "     3   4   5"
        putStrLn "   6   7   8   9"
        putStrLn "10  11  12  13  14"
        exitFailure
    let peg = read (args !! 0) :: Int
    let allSol = solvePeg peg
    let allSolShow = map (showSolution peg) allSol
    mapM_ putStrLn $ concat $map (showOneSolution) $ zip [1..] allSolShow

