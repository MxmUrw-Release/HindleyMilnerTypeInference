-- {-# LANGUAGE OverloadedStrings #-}

module MetaBuilder.Project.Type.AgdaPublish where

import MetaBuilder.Imports.Yaml
import MetaBuilder.Imports.Shake
import MetaBuilder.Core

import qualified Data.Yaml as Yaml

import Paths_MetaBuilder
import MetaBuilder.Project.Type.AgdaPublish.Lowlevel
import MetaBuilder.Project.Type.AgdaPublish.Midlevel
import MetaBuilder.Project.Type.AgdaPublish.Highlevel
import MetaBuilder.Project.Type.AgdaPublish.Persistent
import MetaBuilder.Project.Type.AgdaPublish.Common
import MetaBuilder.Project.Type.AgdaPublish.DocumentDescription
import Agda.Interaction.Highlighting.LaTeX.Prettify
import Agda.Interaction.Highlighting.LaTeX.ExternalCall

import Data.Text as T
import Data.Text.IO as TIO

import Control.Monad

import Debug.Trace

import System.Directory

import Development.Shake.Classes
-- The AgdaPublish project


instance ProjectType AgdaPublishProjectConfig ExtraAgdaPublishProjectConfig where
  deriveExtraConfig = deriveExtraProjectConfig_AgdaPublish
  makeRules = makeRules_AgdaPublishProject

data AgdaPublishProjectConfig = AgdaPublishProjectConfig
  { source_RelDir          :: FilePath
  -- , include_RelFiles       :: [FilePath]
  , agdaPublishDocumentDescription :: DocumentDescription
  , autobuild              :: Bool
  , fastbuild              :: Bool
  , latexRepeatBuild       :: Int
  , projectName            :: String
  , libraryDefinitions_Filename :: String
  , bibfile_RelFile :: String
  , abstract_RelFile :: String
  }
  deriving (Generic, Show)

instance FromJSON AgdaPublishProjectConfig
data ExtraAgdaPublishProjectConfig = ExtraAgdaPublishProjectConfig
  {
    source_AbDir                      :: FilePath
  , include_AbFiles                   :: [FilePath]
  , mainPdf_AbFile                    :: FilePath
  , buildPdf_AbFile                   :: FilePath
  , mainTex_AbFile                    :: FilePath
  , originalConfig                    :: AgdaPublishProjectConfig
  , generateLiterate_Source_AbDir     :: FilePath
  , generateLiterate_Target_AbDir     :: FilePath
  , generateTex_Source_AbDir          :: FilePath
  , generateTex_Target_AbDir          :: FilePath
  , generatePdf_Source_AbDir          :: FilePath
  , generateTex_Target_AbFiles        :: [FilePath]
  , generateTex_ImportantSource_AbFiles :: [FilePath]
  , generateTex_NotImportantSource_AbFiles :: [FilePath]
  , readCommands_ImportantSource_AbFiles :: [FilePath]
  , libraryDefinitions_Source_AbFile  :: FilePath
  , libraryDefinitions_Target_AbFile  :: FilePath
  , agdaSty_Target_AbFile             :: FilePath
  , quiverSty_Target_AbFile           :: FilePath
  , commands_AbFile                   :: FilePath
  , bibfile_Source_AbFile             :: String
  , bibfile_Target_AbFile             :: String
  , abstract_Source_AbFile             :: String
  , abstract_Target_AbFile             :: String
  }
  deriving (Show)


deriveExtraProjectConfig_AgdaPublish :: ExtraGlobalConfig -> AgdaPublishProjectConfig -> ExtraAgdaPublishProjectConfig
deriveExtraProjectConfig_AgdaPublish egc appc =
  let include_RelFiles = getDocumentRelFiles (appc.>agdaPublishDocumentDescription)
      buildLiterateRoot = egc.>buildAbDir </> appc.>projectName </> "build-literate"
      buildLiterate = buildLiterateRoot </> appc.>source_RelDir
      buildTex     = egc.>buildAbDir </> appc.>projectName </> "build-tex"
      bin          = egc.>binAbDir

      source_AbDir = egc.>rootAbDir </> appc.>source_RelDir
      include_AbFiles = (source_AbDir </>) <$> include_RelFiles

      generateLiterate_Source_AbDir = egc.>rootAbDir -- source_AbDir --
      generateLiterate_Target_AbDir = buildLiterateRoot
      generateTex_Source_AbDir     = buildLiterate
      generateTex_Target_AbDir     = buildTex
      generatePdf_Source_AbDir     = buildTex

      generateTex_Target_AbFiles = ((\f -> generateTex_Target_AbDir </> appc.>source_RelDir </> f -<.> ".tex") <$> (include_RelFiles))
      generateTex_ImportantSource_AbFiles = ((\f -> normalise (generateTex_Source_AbDir </> f -<.> "lagda")) <$> (include_RelFiles))
      readCommands_ImportantSource_AbFiles = ((\f -> source_AbDir </> f) <$> (include_RelFiles))

      -- not important:
      generateTex_NotImportantSource_AbFiles = ((\f -> normalise (generateTex_Source_AbDir </> f -<.> "lagda")) <$> (notImportantFiles (appc.>agdaPublishDocumentDescription)))

      libraryDefinitions_Source_AbFile = normalise (egc.>rootAbDir </> appc.>libraryDefinitions_Filename)
      libraryDefinitions_Target_AbFile = normalise (buildLiterateRoot </> appc.>libraryDefinitions_Filename)

      bibfile_Source_AbFile = normalise (source_AbDir </> appc.>bibfile_RelFile)
      bibfile_Target_AbFile = normalise (buildTex </> appc.>bibfile_RelFile)

      abstract_Source_AbFile = normalise (source_AbDir </> appc.>abstract_RelFile)
      abstract_Target_AbFile = normalise (buildTex </> appc.>abstract_RelFile)

      agdaSty_Target_AbFile = buildTex </> "agda.sty"
      quiverSty_Target_AbFile = buildTex </> "quiver.sty"

      commands_AbFile                   = egc.>buildAbDir </> appc.>projectName </> "generated" </> "all.metabuild-cmd"

  in ExtraAgdaPublishProjectConfig
  { source_AbDir     = source_AbDir
  , include_AbFiles  = include_AbFiles
  , mainTex_AbFile   = generateTex_Target_AbDir </> appc.>projectName <.> "tex"
  , mainPdf_AbFile   = bin   </> appc.>projectName <.> "pdf"
  , buildPdf_AbFile  = buildTex </> appc.>projectName <.> "pdf"
  , generateLiterate_Source_AbDir = generateLiterate_Source_AbDir
  , generateLiterate_Target_AbDir = generateLiterate_Target_AbDir
  , generateTex_Source_AbDir = generateTex_Source_AbDir
  , generateTex_Target_AbDir = generateTex_Target_AbDir
  , generatePdf_Source_AbDir = generatePdf_Source_AbDir
  , generateTex_Target_AbFiles = generateTex_Target_AbFiles
  , generateTex_ImportantSource_AbFiles = generateTex_ImportantSource_AbFiles
  , generateTex_NotImportantSource_AbFiles = generateTex_NotImportantSource_AbFiles
  , readCommands_ImportantSource_AbFiles = readCommands_ImportantSource_AbFiles
  , libraryDefinitions_Source_AbFile = libraryDefinitions_Source_AbFile
  , libraryDefinitions_Target_AbFile = libraryDefinitions_Target_AbFile
  , bibfile_Source_AbFile = bibfile_Source_AbFile
  , bibfile_Target_AbFile = bibfile_Target_AbFile
  , abstract_Source_AbFile = abstract_Source_AbFile
  , abstract_Target_AbFile = abstract_Target_AbFile
  , agdaSty_Target_AbFile = agdaSty_Target_AbFile
  , quiverSty_Target_AbFile = quiverSty_Target_AbFile
  , originalConfig = appc
  , commands_AbFile = commands_AbFile
  }

-------------------------------------------------------
-- Oracle types
-------------------------------------------------------

-- oracle for getting the list of commands
-- (such that all files need only to be regenerated, when the list actually changed)
newtype SpecialCommandsOracle = SpecialCommandsOracle [String] deriving (Show,Typeable,Eq,Hashable,Binary,NFData)
type instance RuleResult SpecialCommandsOracle = [SpecialCommand]

-- oracle for "Importantness" of files
-- (the generation of the .lagda file
--  depends on whether we want to only include it for agda's sake,
--  or to really include it in the document
--  - when its Importantness changes, it should be regenerated)
newtype FileImportantnessOracle = FileImportantnessOracle ([FilePath], FilePath) deriving (Show,Typeable,Eq,Hashable,Binary,NFData)
type instance RuleResult FileImportantnessOracle = Bool

-------------------------------------------------------
-- AgdaPublish rules
-------------------------------------------------------


makeRules_AgdaPublishProject :: ExtraGlobalConfig -> ExtraAgdaPublishProjectConfig -> Rules ()
makeRules_AgdaPublishProject egc eappc = do
  -- defining oracles
  getSpecialCommands <- addOracle $ \(SpecialCommandsOracle source_AbFiles) -> do
    contents <- liftIO $ mapM (TIO.readFile) source_AbFiles
    commands <- liftIO $ assumeRight $ generateCommands contents
    return commands

  getFileImportantness <- addOracle $ \(FileImportantnessOracle (importantList, file)) -> do
    alwaysRerun
    let isImportant = normalise file `elem` importantList
    -- liftIO $ Prelude.putStrLn $ "---------------------------------------------------------------------"
    -- liftIO $ Prelude.putStrLn $ "Checking if '" <> normalise file <> "' is in " <> show (importantList) 
    -- liftIO $ Prelude.putStrLn $ "---------------------------------------------------------------------"
    return isImportant

  -- accessing the original config
  let appc = eappc.>originalConfig

  -- rule for automatic building
  if (eappc.>originalConfig.>autobuild)
    then want [eappc.>mainPdf_AbFile]
    else return ()

  -- the actual rules
  phony (eappc.>originalConfig.>projectName) $ do
    need [eappc.>mainPdf_AbFile]


  eappc.>mainPdf_AbFile %> \file -> do
    copyFile' (eappc.>buildPdf_AbFile) (eappc.>mainPdf_AbFile)

  eappc.>buildPdf_AbFile %> \_ -> do
    -- Generate list of all agda files
    source_Files <- getDirectoryFiles (eappc.>source_AbDir) ["//*.agda"]
    -- Turn them into a list of lagda files which need to be generated.
    -- We need to include them as dependencies in case of them not being included in the tex output,
    -- but being needed for successfull agda processing
    let generateTex_Source_Files = ((\f -> eappc.>generateTex_Source_AbDir </> f -<.> "lagda")            <$> source_Files)

    let deps = [ eappc.>mainTex_AbFile
               , eappc.>agdaSty_Target_AbFile 
               , eappc.>quiverSty_Target_AbFile
               , eappc.>bibfile_Target_AbFile
               , eappc.>abstract_Target_AbFile
               ]
               ++ (eappc.>generateTex_Target_AbFiles)
               ++ generateTex_Source_Files
    need deps

    let build = do
          cmd_ "xelatex" (Cwd (eappc.>generatePdf_Source_AbDir)) [eappc.>mainTex_AbFile]
          -- also call biber for bibliography
          cmd_ "biber" (Cwd (eappc.>generatePdf_Source_AbDir)) [dropExtension $ eappc.>mainTex_AbFile]

    -- repeat the building as often as required
    let doNTimes n a | n <= 0    = return ()
        doNTimes n a | otherwise = a >> doNTimes (n - 1)  a
    -- execute
    doNTimes (eappc.>originalConfig.>latexRepeatBuild) build


  eappc.>mainTex_AbFile %> \file -> do
    template <- liftIO (templatefileMainTex (eappc.>originalConfig.>agdaPublishDocumentDescription))
    need [template, egc.>metabuilder_AbFile, egc.>root_AbFile]
    content <- liftIO $ generateMainTex (eappc.>generateTex_Target_AbDir </> appc.>source_RelDir) (appc.>agdaPublishDocumentDescription) eappc
    liftIO $ TIO.writeFile file content

  (eappc.>generateLiterate_Target_AbDir ++ "//*.lagda") %> \file -> do
    let relfile = makeRelative (eappc.>generateLiterate_Target_AbDir) file
    let sourcefile = eappc.>generateLiterate_Source_AbDir </> relfile -<.> ".agda"
    let targetfile = eappc.>generateLiterate_Target_AbDir </> relfile -<.> ".lagda"
    putInfo $ "Generating literate file " ++ targetfile ++ " for " ++ sourcefile
    need [sourcefile, egc.>metabuilder_AbFile, eappc.>commands_AbFile] -- , egc.>root_AbFile

    -- isImportant <- askOracle (FileImportantnessOracle (eappc.>generateTex_ImportantSource_AbFiles, file))
    let importantList = eappc.>generateTex_ImportantSource_AbFiles
    let isImportant = normalise file `elem` importantList
    let isSkipped = normalise file `elem` (eappc.>generateTex_NotImportantSource_AbFiles)
    case and [isImportant, not isSkipped] of
      False -> do
        -------
        -- If we only copy this file as a dependency
        content <- liftIO $ TIO.readFile sourcefile
        let content2 = (T.pack "\\begin{code}\n") <> content <> (T.pack "\n\\end{code}")
        liftIO $ TIO.writeFile targetfile content2

      True -> do
        -------
        -- If we really want to parse this file
        -- read input file
        content <- liftIO $ TIO.readFile sourcefile

        -- load command file for code snippet prettification
        commands <- liftIO $ Yaml.decodeFileThrow (eappc.>commands_AbFile)

        content2 <- liftIO $ assumeRight $ (generateLiterate commands content)
        liftIO $ TIO.writeFile targetfile content2

  (eappc.>libraryDefinitions_Target_AbFile) %> \file -> do
    copyFile' (eappc.>libraryDefinitions_Source_AbFile) (eappc.>libraryDefinitions_Target_AbFile)

  -- agda.sty
  (eappc.>agdaSty_Target_AbFile) %> \file -> do
    template <- liftIO templatefileAgdaSty
    need [template, egc.>metabuilder_AbFile]
    content <- liftIO (generateAgdaSty)
    liftIO $ TIO.writeFile file content

  -- quiver.sty
  (eappc.>quiverSty_Target_AbFile) %> \file -> do
    template <- liftIO templatefileQuiverSty
    need [template, egc.>metabuilder_AbFile]
    content <- liftIO (generateQuiverSty)
    liftIO $ TIO.writeFile file content

  -- bibfile
  (eappc.>bibfile_Target_AbFile) %> \file -> do
    need [egc.>metabuilder_AbFile]
    copyFile' (eappc.>bibfile_Source_AbFile) file

  -- abstract
  (eappc.>abstract_Target_AbFile) %> \file -> do
    need [egc.>metabuilder_AbFile]
    copyFile' (eappc.>abstract_Source_AbFile) file


  (eappc.>commands_AbFile) %> \file -> do
    -- source_Files <- getDirectoryFiles (eappc.>source_AbDir) ["//*.agda"]
    -- let source_AbFiles = [eappc.>source_AbDir </> f | f <- source_Files]
    -- need ([egc.>metabuilder_AbFile] <> source_AbFiles)

    let source_AbFiles = (eappc.>readCommands_ImportantSource_AbFiles)
    need ([egc.>metabuilder_AbFile])

    -- we ask the oracle, such that this rule is not executed always,
    -- but only when the commands list changes (or the metabuilder file changed)
    commands <- getSpecialCommands (SpecialCommandsOracle source_AbFiles)
    -- contents <- liftIO $ mapM (TIO.readFile) source_AbFiles
    -- commands <- liftIO $ assumeRight $ generateCommands contents
    putInfo $ "Generating commands file. Found commands: " <> show commands
    liftIO $ encodeFile file commands


  (eappc.>generateTex_Target_AbDir ++ "//*.tex") %> \file -> do
    let relfile = makeRelative (eappc.>generateTex_Target_AbDir) file
    let sourcefile = eappc.>generateLiterate_Target_AbDir </> relfile -<.> ".lagda"
    let targetfile = eappc.>generateTex_Target_AbDir </> relfile -<.> ".tex"
    need [sourcefile , eappc.>libraryDefinitions_Target_AbFile , eappc.>commands_AbFile]
    -- need generateTex_Source_Files -- we want all files, such that not -in tex- included files also get translated into literal ones
    putInfo $ "Generating tex file " ++ targetfile ++ " for " ++ sourcefile
    -- putInfo $ ">>> My source dir is: " ++ (eappc.>generateTex_Source_AbDir)
    let targetDir = eappc.>generateTex_Target_AbDir
    liftIO $ createDirectoryIfMissing True targetDir

    let isImportant = normalise sourcefile `elem` (eappc.>generateTex_ImportantSource_AbFiles)
    let isSkipped = normalise sourcefile `elem` (eappc.>generateTex_NotImportantSource_AbFiles)
    if and [isImportant, not isSkipped] then
      do
    
        let fastbuildarg = if (eappc.>originalConfig.>fastbuild)
              then PrettyCheckingFast
              else PrettyCheckingSlow
        -- load command file for prettifier
        commands <- liftIO $ Yaml.decodeFileThrow (eappc.>commands_AbFile)

        -- instantiate the prettifier
        let prtf = Prettifier (MetaBuilder.Project.Type.AgdaPublish.Highlevel.parseAndGenerate commands) (MetaBuilder.Project.Type.AgdaPublish.Common.prettyChars)

        -- call latex generation in the agda library
        liftIO $ generatePrettyLatexIO fastbuildarg prtf sourcefile targetDir
      else do
        let fastbuildarg = if (eappc.>originalConfig.>fastbuild)
              then ["--only-scope-checking"]
              else []
        -- if the file is not important, we call the real agda
        cmd_ "agda" (Cwd (eappc.>generateTex_Source_AbDir)) (["--latex"] ++ fastbuildarg ++ ["--latex-dir=" ++ targetDir, sourcefile])


  -- source_Files <- liftIO $ getDirectoryFilesIO (eapc.>source_AbDir) ["//*.agda"]
  -- let generateLiterateSource_Files = ((\f -> eapc.>generateLiterateSource_AbDir </> f)            <$> source_Files)
  -- let generateLiterateTarget_Files = ((\f -> eapc.>generateLiterateTarget_AbDir </> f)            <$> source_Files)

  -- let generateTexSource_Files = ((\f -> eapc.>generateTexSource_AbDir </> f -<.> ".lagda.tex") <$> source_Files)
  -- let generateTexSource_Files = ((\f -> eapc.>generateTexTarget_AbDir </> f -<.> ".lagda.tex") <$> source_Files)

  -- generateLiterateTarget_Files &%> \files -> do
  --   need generateLiterateSource_Files

  return ()
    where 
        changeTokens :: forall a. TokenLike a => a -> a
        changeTokens = id --  \a -> let t = getTokenText a in setTokenText a (t <> T.pack "AA")



-------------------------------------------------------------------------
-- Parsing theorems and proofs
-------------------------------------------------------------------------


generateLiterate :: [SpecialCommand] -> Text -> MBRes Text
generateLiterate cmd s =
  let r = do res <- doParseLL s
             res2 <- doParseML cmd res
             return (tshow res2)

      r2 = case r of
              Left err -> Left $ "Low level parsing error: " <> err
              Right val -> Right val
  in r2

generateCommands :: [Text] -> MBRes [SpecialCommand]
generateCommands ts =
  let res = mapM doParseCommands ts
  in join <$> res



  -- "\\begin{code}\n"
  -- ++ s
  -- ++ "\\end{code}\n"

templatefileMainTex :: DocumentDescription -> IO FilePath
templatefileMainTex doc = case (documentType doc) of
  SCReport -> getDataFileName "templates/screport.tex.metabuild-template"
  Book     -> getDataFileName "templates/screport.tex.metabuild-template"


generateMainTex :: FilePath -> DocumentDescription -> ExtraAgdaPublishProjectConfig -> IO Text
generateMainTex texroot doc eappc = do
  file <- templatefileMainTex doc
  template <- TIO.readFile file

  let content = (replace (T.pack "{{CONTENT}}") makeIncludes
                . replace (T.pack "{{AUTHOR}}") (T.pack $ doc.>documentAuthor)
                . replace (T.pack "{{TITLE}}") (T.pack $ doc.>documentTitle)
                . replace (T.pack "{{DATE}}") (T.pack $ doc.>documentDate)
                . replace (T.pack "{{SUBTITLE}}") (case doc.>documentSubtitle of
                                                     Just a -> T.pack a
                                                     Nothing -> T.pack "")
                . replace (T.pack "{{BIBFILE}}") (T.pack $ toStandard $ eappc.>bibfile_Target_AbFile) -- we need to turn the path seps into '/'
                . replace (T.pack "{{ABSTRACT}}") (T.pack $ toStandard $ eappc.>abstract_Target_AbFile) -- we need to turn the path seps into '/'
                ) template

  return content
  where makeIncludes :: Text
        makeIncludes = T.pack (generateDocumentBody doc texroot (documentFilesAndHeadings doc))
          -- T.concat ((\a -> T.pack ("\\input{" ++  (toStandard a) ++ "}\n")) <$> files)

templatefileAgdaSty :: IO FilePath
templatefileAgdaSty = getDataFileName "templates/agda.sty.metabuild-template"

templatefileQuiverSty :: IO FilePath
templatefileQuiverSty = getDataFileName "templates/quiver.sty.metabuild-template"

generateAgdaSty :: IO Text
generateAgdaSty = do
  file <- templatefileAgdaSty
  content <- TIO.readFile file
  return content

generateQuiverSty :: IO Text
generateQuiverSty = do
  file <- templatefileQuiverSty
  content <- TIO.readFile file
  return content


  -- "\\begin{document}"
  -- ++ concat ((\a -> ("include" ++ a ++ "\n")) <$> files)
  -- ++ "\\end{document}"

