classdef uiTest_BaseWorkspaceStructParameterUI < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2026 The MathWorks, Inc.

  properties
    % Some of the tests in this class run only if test is running locally under the LocalTopFolder.
    LocalTopFolder (1,1) pattern = "C:\local"
  end  % properties

  methods (TestMethodSetup)
    % Functions in this "TestMethodSetup" section always run before
    % each test defined in the "Test" section runs.

    function test_method_setup_1(testcase)
      %%
      % Close all before test
      close all
      bdclose all

      % addTeardown adds a function which always runs after each test.
      % Even if the execution of a test ends with an error, the teardown function runs.
      addTeardown(testcase, @closeAllAfterTest)
      function closeAllAfterTest
        % Close all figure windows. This closes not only the test targets but also other figure windows.
        figs = findall(0, Type="Figure");
        if not(any(isempty(figs)))
          disp("Deleting figures (" + numel(figs) + ")")
          delete(figs)
        end  % if
        bdclose all
      end  % nested function
    end  % function

  end  % methods

  methods (Test)
    % Functions in the Test section are the tests.
    % Before a function in this section runs, the functions defined in the TestMethodSetup section run.

    %% Minimum quality check
    % Check that models, scripts, functions, and classes run right out of the box.

    % Warnings can be displayed even when the app opens and starts working seemingly normally.
    % Make sure there is no warning when opening an app.

    function clean_launch_1(testcase)
      verifyWarningFree(testcase, @DemoApp_BaseWorkspaceStructParameterUI_1_simplest)
    end  % function

    function clean_launch_2(testcase)
      verifyWarningFree(testcase, @DemoApp_BaseWorkspaceStructParameterUI_2)
    end  % function

    %% Gesture test

    function Gesture_1_1_1(testcase)
      evalin("base", "clear dummy_variable_1")
      app = DemoApp_BaseWorkspaceStructParameterUI_1_simplest;
      verifyError(testcase, @test_target, "BaseWorkspaceStructParameterUI:InvalidStructName")
      function test_target
        type(testcase, app.BaseWorkspaceStructParameterUI_1.StructNameDropDownUI.MainDropDown, "dummy_variable_1")
      end  % nested function
    end  % function

    function Gesture_1_1_2(testcase)
      evalin("base", "dummy_variable_1 = struct; dummy_variable_1.A = 2;")
      app = DemoApp_BaseWorkspaceStructParameterUI_1_simplest;
      type(testcase, app.BaseWorkspaceStructParameterUI_1.StructNameDropDownUI.MainDropDown, "dummy_variable_1")
    end  % function

    % -------------------------------------------------------------------------

    function Gesture_1_2(~)
      app = DemoApp_BaseWorkspaceStructParameterUI_1_simplest;

      % Instead of clicking the "Select file..." button
      app.BaseWorkspaceStructParameterUI_1.ParameterFileFullPath = "";

    end  % function

    function Gesture_2_1(testcase)
      if TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping (the test is not running within the specified local path.)")

        return

      end  %if

      app = DemoApp_BaseWorkspaceStructParameterUI_2;

      paramfile1 = FileUtil1.getFileFullPath("BaseWorkspaceStructParameterUI_SampleParams1.m");
      paramfile2 = FileUtil1.getFileFullPath("BaseWorkspaceStructParameterUI_SampleParams2.m");

      % Instead of clicking the "Select file..." button
      app.BaseWorkspaceStructParameterUI_1.ParameterFileFullPath = paramfile1;
      app.BaseWorkspaceStructParameterUI_1.ParameterFileFullPath = paramfile2;

      choose(testcase, app.BaseWorkspaceStructParameterUI_1.ParameterFileDropDownUI.MainDropDown, "")

      choose(testcase, app.BaseWorkspaceStructParameterUI_1.ParameterFileDropDownUI.MainDropDown, replace(paramfile1, ("/"|"\"), " > "))
      type(testcase, app.BaseWorkspaceStructParameterUI_1.StructNameDropDownUI.MainDropDown, "sample_struct1")
      press(testcase, app.BaseWorkspaceStructParameterUI_1.GetParametersFromBaseWorkspaceUI.MainButton)
      % This opens the Variables window (a.k.a. Variables Editor).
      press(testcase, app.BaseWorkspaceStructParameterUI_1.OpenVariablesEditorButtonUI.MainButton)  % !attention: locally works, but can fail in CI.
      % !todo: Close the Variables window here.

      choose(testcase, app.BaseWorkspaceStructParameterUI_1.ParameterFileDropDownUI.MainDropDown, "")

      choose(testcase, app.BaseWorkspaceStructParameterUI_1.ParameterFileDropDownUI.MainDropDown, replace(paramfile2, ("/"|"\"), " > "))
      type(testcase, app.BaseWorkspaceStructParameterUI_1.StructNameDropDownUI.MainDropDown, "sample_struct2.component5")
      % This opens the Variables window (a.k.a. Variables Editor).
      press(testcase, app.BaseWorkspaceStructParameterUI_1.OpenVariablesEditorButtonUI.MainButton)
      % !todo: Close the Variables window here.

    end  % function

    function Gesture_2_2(testcase)
      if TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping (the test is not running within the specified local path.)")

        return

      end  %if
      app = DemoApp_BaseWorkspaceStructParameterUI_2;

      paramfile1 = FileUtil1.getFileFullPath("BaseWorkspaceStructParameterUI_SampleParams1.m");
      paramfile2 = FileUtil1.getFileFullPath("BaseWorkspaceStructParameterUI_SampleParams2.m");

      % Instead of clicking the "Select file..." button
      app.BaseWorkspaceStructParameterUI_1.ParameterFileFullPath = paramfile1;
      app.BaseWorkspaceStructParameterUI_1.ParameterFileFullPath = paramfile2;

      choose(testcase, app.BaseWorkspaceStructParameterUI_1.ParameterFileDropDownUI.MainDropDown, replace(paramfile1, ("/"|"\"), " > "))
      % This opens the file in the editor.
      press(testcase, app.BaseWorkspaceStructParameterUI_1.EditFileButtonUI.MainButton)  % !test-target. !attention: locally works, but can fail in CI.
      % Close the currently active file in the editor.
      close(matlab.desktop.editor.getActive)

      choose(testcase, app.BaseWorkspaceStructParameterUI_1.ParameterFileDropDownUI.MainDropDown, replace(paramfile2, ("/"|"\"), " > "))
      % This opens the file in the editor.
      press(testcase, app.BaseWorkspaceStructParameterUI_1.EditFileButtonUI.MainButton)  % !test-target
      % Close the currently active file in the editor.
      close(matlab.desktop.editor.getActive)

    end  % function

  end  % methods
end  % classdef
