
# Test and coverage summary report

This script generates tables containing test summary and code coverage information. This script requires the `test-result.xml` and `code-coverage.xml` files that were genearted by the Build Tool.


```matlabTextOutput
UTC 2025-12-16 11:09:45
```


```matlabTextOutput
  matlabRelease with properties:

    Release: "R2025b"
      Stage: "release"
     Update: 2
       Date: 16-Oct-2025
```


```matlabTextOutput
Test top folder: C:\local\modutil\modeling-utility\Devel\
```


```matlabTextOutput
CustomProperties with properties:

              NumberOfTests: 616
     TotalTestTimeInSeconds: 2.3139e+03
      MeanTestTimeInSeconds: 3.7563
    MedianTestTimeInSeconds: 0.2171
```


```matlabTextOutput
Slow tests:
```


```matlabTextOutput
                     TestClass                               TestFunction               TestTimeInSeconds
    ___________________________________________    _________________________________    _________________

    "uiuptodatetest_RotationalFriction"            "DarkTheme_1"                             142.91      
    "uitest_RotationalFriction"                    "Gesture_1"                                128.9      
    "uiuptodatetest_RotationalFriction"            "LightTheme_1"                            75.853      
    "uitest_RotationalFriction"                    "VisualTest_3"                            73.998      
    "uitest_TraceGeneratorAppMain"                 "uitest_1"                                71.083      
    "uitest_SignalUtil"                            "app_launches_without_warnings_2"         70.255      
    "uitest_TraceGeneratorAppMain"                 "Test_1"                                  70.194      
    "uitest_RotationalFriction"                    "VisualTest_2_2"                          70.077      
    "uitest_RotationalFriction"                    "Test_1"                                  69.475      
    "uitest_RotationalFriction"                    "Test_samplemodel_1"                      69.393      
    "uitest_TraceGeneratorAppMain"                 "app_launches_without_warnings_1"         69.223      
    "uitest_RotationalFriction"                    "VisualTest_2_1"                          69.214      
    "uitest_RotationalFriction"                    "Test_with_samplemodel_2"                 69.191      
    "uitest_RotationalFriction"                    "app_launches_without_warnings_3"         69.015      
    "uitest_RotationalFriction"                    "Test_with_samplemodel_1"                 68.899      
    "uitest_RotationalFriction"                    "VisualTest_1_2"                          68.898      
    "uitest_SignalDesignAppMain"                   "uitest_1"                                68.377      
    "uitest_SignalUtil"                            "app_launches_without_warnings_1"         68.278      
    "uitest_SignalDesignAppMain"                   "PassingTest_1"                           67.378      
    "uitest_SignalDesignAppMain"                   "app_launches_without_warnings_1"         66.794      
    "uitest_BlockSelectorUI"                       "Gesture_Highlight_button"                24.151      
    "unittest_exportToMarkdown"                    "PassingTest_1"                           22.203      
    "unittest_generateMarkdownsFromLiveScripts"    "PassingTest_1"                           22.082      
    "uitest_SearchUtilApps"                        "Gesture_1"                               10.288      
    "unittest_exportToMarkdown"                    "PassingTest_2"                           9.9382      
    "uitest_BlockSelectorUI"                       "Gesture_Get_button"                      9.7024      
    "uitest_Panel"                                 "DarkTheme_8"                             9.5425      
    "unittest_exportToMarkdown"                    "PassingTest_3"                           9.4613      
    "uitest_RotationalFriction"                    "app_launches_without_warnings_1"          9.379      
    "uitest_RotationalFriction"                    "app_launches_without_warnings_2"         9.2247      
    "uitest_Panel"                                 "LightTheme_8"                            9.1558      
    "uitest_BlockSelectorUI"                       "Gesture_Model_Dropdown"                  9.0889      
    "uitest_AlignComponents"                       "LightTheme_3"                            8.6652      
    "uitest_BlockSelectorUI"                       "Gesture_Set_button"                      8.6651      
    "uitest_AlignComponents"                       "LightTheme_4"                            8.4801      
    "uitest_AlignComponents"                       "DarkTheme_4"                             8.4695      
    "uitest_RotationalFriction"                    "VisualTest_1_1"                          8.4314      
    "uitest_CheckBox"                              "DarkTheme_3"                             8.3709      
    "uitest_CheckBox"                              "LightTheme_3"                            8.1993      
    "uitest_AlignComponents"                       "DarkTheme_3"                             8.1372      
    "uitest_SearchUtilApps"                        "Gesture_2"                               7.9893      
    "uitest_RotationalFriction"                    "Test_2"                                  7.7889      
    "uitest_PhysicalValueUI"                       "Gesture_UnitItems_1"                     7.2781      
    "uitest_SearchUtilApps"                        "LightTheme_2"                            7.2697      
    "uitest_BlockSelectorUI"                       "Gesture_Highlight_Block"                 6.7405      
    "uitest_SearchUtilApps"                        "LightTheme_1"                             6.655      
    "uitest_Panel"                                 "app_launches_without_warnings_8"         5.3782      
    "uitest_AppUtil"                               "test_ColormapApp_LightTheme"             5.0205      
    "uitest_AppUtil"                               "test_ColormapApp_DarkTheme"              4.9642      
    "uitest_Table"                                 "Gesture_1"                               4.8693      
```


```matlabTextOutput
    StatementCoveragePercent    LinesCovered    LinesValid            TimeStamp        
    ________________________    ____________    __________    _________________________

             85.806                11039          12865       "UTC 2025-12-16 10:49:24"
```


```matlabTextOutput
        ComponentName        ComponentCoveragePercent
    _____________________    ________________________

    "AppUtil1"                        78.824         
    "AppUtil1.Component"              79.521         
    "AppUtil1.Graphics"               89.091         
    "CodeUtil1"                        86.94         
    "FileUtil1"                       85.399         
    "ModelUtil1"                      82.168         
    "RotationalFriction1"              85.54         
    "SearchUtil1"                     81.478         
    "SignalUtil1"                     75.138         
    "TestUtil1"                          100         
```


```matlabTextOutput
Low-coverage code files:
```


```matlabTextOutput
    StatementCoveragePercent                      TestClassName                                                                           FilePath                                                     
    ________________________    _________________________________________________    __________________________________________________________________________________________________________________

                  0             "buildfile"                                          "AppUtil\buildfile.m"                                                                                             
                  0             "apptest_RotationalFrictionAppMain_1_simplest"       "AppsForPhysicalSystems\Test\RotationalFriction\apptest_RotationalFrictionAppMain_1_simplest.m"                   
                  0             "apptest_RotationalFrictionApp_1_simplest"           "AppsForPhysicalSystems\Test\RotationalFriction\apptest_RotationalFrictionApp_1_simplest.m"                       
                  0             "buildfile"                                          "AppsForPhysicalSystems\buildfile.m"                                                                              
                  0             "buildfile"                                          "CodeUtil\buildfile.m"                                                                                            
                  0             "sampleScript_batchGenerateMarkdowns_1"              "FileUtil\Test\batchGenerateMarkdowns\sample folder\sampleScript_batchGenerateMarkdowns_1.m"                      
                  0             "sampleScript_batchGenerateMarkdowns_2"              "FileUtil\Test\batchGenerateMarkdowns\sample folder\sampleScript_batchGenerateMarkdowns_2.mlx"                    
                  0             "sampleScript_batchGenerateMarkdowns_11"             "FileUtil\Test\batchGenerateMarkdowns\sample folder\subfolder 1\sampleScript_batchGenerateMarkdowns_11.mlx"       
                  0             "sampleScript_batchGenerateMarkdowns_12"             "FileUtil\Test\batchGenerateMarkdowns\sample folder\subfolder 1\sampleScript_batchGenerateMarkdowns_12.m"         
                  0             "sampleScript_batchGenerateMarkdowns_21"             "FileUtil\Test\batchGenerateMarkdowns\sample folder\subfolder 2\sampleScript_batchGenerateMarkdowns_21.mlx"       
                  0             "sampleScript_batchGenerateMarkdowns_22"             "FileUtil\Test\batchGenerateMarkdowns\sample folder\subfolder 2\sampleScript_batchGenerateMarkdowns_22.m"         
                  0             "sampleScript_exportToMarkdown_1"                    "FileUtil\Test\exportToMarkdown\sample folder\sampleScript_exportToMarkdown_1.mlx"                                
                  0             "sampleScript_exportToMarkdown_2"                    "FileUtil\Test\exportToMarkdown\sample folder\sampleScript_exportToMarkdown_2.m"                                  
                  0             "sampleScript_generateMarkdownsFromLiveScripts_1"    "FileUtil\Test\generateMarkdownsFromLiveScripts\sample folder\sampleScript_generateMarkdownsFromLiveScripts_1.mlx"
                  0             "sampleScript_generateMarkdownsFromLiveScripts_2"    "FileUtil\Test\generateMarkdownsFromLiveScripts\sample folder\sampleScript_generateMarkdownsFromLiveScripts_2.m"  
                  0             "buildfile"                                          "FileUtil\buildfile.m"                                                                                            
                  0             "buildfile"                                          "ModelUtil\buildfile.m"                                                                                           
                  0             "demo_searchText"                                    "SearchUtil\Test\searchText\demo_searchText.m"                                                                    
                  0             "samplefunction_11"                                  "SearchUtil\Test\searchText\sample folder\subfolder 1\samplefunction_11.m"                                        
                  0             "samplefunction_111"                                 "SearchUtil\Test\searchText\sample folder\subfolder 1\subfolder 11\samplefunction_111.m"                          
                  0             "samplescript_21"                                    "SearchUtil\Test\searchText\sample folder\subfolder 2\samplescript_21.m"                                          
                  0             "samplescript_31"                                    "SearchUtil\Test\searchText\sample folder\subfolder 3\samplescript_31.m"                                          
                  0             "samplescript_32"                                    "SearchUtil\Test\searchText\sample folder\subfolder 3\samplescript_32.m"                                          
                  0             "buildfile"                                          "SearchUtil\buildfile.m"                                                                                          
                  0             "buildfile"                                          "SignalUtil\buildfile.m"                                                                                          
                  0             "TestAndCoverageReport"                              "TestAndCoverageReport.m"                                                                                         
                  0             "TestResultApp"                                      "TestUtil\TestResultApp.m"                                                                                        
                  0             "TestTimeReport"                                     "TestUtil\TestTimeReport.m"                                                                                       
                  0             "buildfile"                                          "TestUtil\buildfile.m"                                                                                            
                  0             "buildfile"                                          "buildfile.m"                                                                                                     
                  0             "setup_paths"                                        "setup_paths.m"                                                                                                   
             30.769             "uptodatetest_plotDifference"                        "SignalUtil\Test\plotDifference\uptodatetest_plotDifference.m"                                                    
                 55             "unittest_saveModels"                                "ModelUtil\Test\saveModels\unittest_saveModels.m"                                                                 
              59.74             "uiuptodatetest_SearchUtil"                          "SearchUtil\uiuptodatetest_SearchUtil.m"                                                                          
              59.74             "uiuptodatetest_SignalUtil"                          "SignalUtil\uiuptodatetest_SignalUtil.m"                                                                          
              63.83             "uiuptodatetest_ModelUtil"                           "ModelUtil\uiuptodatetest_ModelUtil.m"                                                                            
             66.667             "uptodatetest_RotationalFriction"                    "AppsForPhysicalSystems\Test\RotationalFriction\uptodatetest_RotationalFriction.m"                                
             71.795             "uitest_FileSearchAppMain"                           "SearchUtil\Test\FileSearchAppMain\uitest_FileSearchAppMain.m"                                                    
             72.727             "uptodatetest_SignalUtil"                            "SignalUtil\uptodatetest_SignalUtil.m"                                                                            
             76.596             "uitest_SearchUtilApps"                              "SearchUtil\Test\uitest_SearchUtilApps.m"                                                                         
             80.645             "unittest_checkRefSubInCallbackButton"               "ModelUtil\Test\checkRefSubInCallbackButton\unittest_checkRefSubInCallbackButton.m"                               
             80.769             "unittest_checkEditInCallbackButton"                 "ModelUtil\Test\checkEditInCallbackButton\unittest_checkEditInCallbackButton.m"                                   
             80.822             "FileListApp"                                        "FileUtil\FileListApp.m"                                                                                          
             81.818             "demo_setSystemMaskIcon"                             "ModelUtil\Test\setSystemMaskIcon\demo_setSystemMaskIcon.m"                                                       
             84.615             "unittest_SignalUtil_settings"                       "SignalUtil\unittest_SignalUtil_settings.m"                                                                       
             85.106             "LookupTable1DBlockPlotApp"                          "ModelUtil\LookupTable1DBlockPlotApp.m"                                                                           
             86.957             "uiuptodatetest_RotationalFriction"                  "AppsForPhysicalSystems\Test\RotationalFriction\uiuptodatetest_RotationalFriction.m"                              
               87.5             "apptest_SignalDesignAppMain"                        "SignalUtil\Test\SignalDesignAppMain\apptest_SignalDesignAppMain.m"                                               
             88.095             "uitest_AppUtil"                                     "AppUtil\uitest_AppUtil.m"                                                                                        
             88.889             "apptest_BlockSelectorUI_3_preload_2models"          "AppUtil\Test\BlockSelectorUI\apptest_BlockSelectorUI_3_preload_2models.m"                                        
```


*Copyright 2025 The MathWorks, Inc.*

