-- | Test utility functions
module Test.Util(utilsTests) where

import Prelude
import Test.Tasty
import Test.Tasty.HUnit

import Language.Haskell.Ghcid.Util
import Language.Haskell.Ghcid.Escape

utilsTests :: TestTree
utilsTests = testGroup "Utility tests"
    [dropPrefixTests
    ,chunksOfWordTests
    ]

dropPrefixTests :: TestTree
dropPrefixTests = testGroup "dropPrefix"
    [testCase "Prefix not found" $ dropPrefixRepeatedly "prefix" "string"  @?= "string"
    ,testCase "Empty prefix" $ dropPrefixRepeatedly "" "string" @?= "string"
    ,testCase "Prefix found once" $ dropPrefixRepeatedly "str" "string" @?= "ing"
    ,testCase "Prefix found twice" $ dropPrefixRepeatedly "str" "strstring" @?= "ing"
    ]

chunksOfWordTests :: TestTree
chunksOfWordTests = testGroup "chunksOfWord"
    [testCase "Max 0" $ chunksOfWordE 4 0 (Esc "ab cd efgh") @?= map Esc ["ab c","d ef","gh"]
    ,testCase "Max 2" $ chunksOfWordE 4 2 (Esc "ab cd efgh") @?= map Esc ["ab ","cd ","efgh"]
    ]
