module RIO.Process.FollowSpec
    ( spec
    )
where

import RIO

import RIO.Process
import RIO.Process.Follow
import Test.Hspec

spec :: Spec
spec = do
    describe "withExtraEnvVars" $ do
        it "appends extra ENV vars to the Process Context" $ do
            output <-
                withProcessContextNoLogging
                $ withExtraEnvVars [("FOO", "1")]
                $ proc "sh" ["-c", "echo $FOO"] readProcessStdout_

            output `shouldBe` "1\n"

        it "overrides ENV vars that already exist" $ do
            output <-
                withProcessContextNoLogging
                $ withExtraEnvVars [("FOO", "1")]
                $ withExtraEnvVars [("FOO", "2")]
                $ proc "sh" ["-c", "echo $FOO"] readProcessStdout_

            output `shouldBe` "2\n"
