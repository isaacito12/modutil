classdef unittest_RotationalFrictionTorque_settings < matlab.unittest.TestCase
  % Class-based unit test

  % Author Class-Based Unit Tests in MATLAB
  % https://www.mathworks.com/help/matlab/matlab_prog/author-class-based-unit-tests-in-matlab.html
  %
  % matlab.unittest.TestCase Class
  % https://www.mathworks.com/help/matlab/ref/matlab.unittest.testcase-class.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2026 The MathWorks, Inc.

  methods (TestMethodSetup)
    % Functions in this section always run before each test defined in the Test section runs.

    function test_method_setup_1(testcase)
      function closeAll
        close all
        bdclose all
      end  % nested function
      closeAll
      % addTeardown adds a function which always runs after each test.
      % Even if the execution of a test ends with an error, the teardown function runs.
      addTeardown(testcase, @closeAll)
    end  % function

  end  % methods

  methods (Test)
    % Functions in this "Test" section are the tests.
    % Before each function in this section runs, functions defined in the TestMethodSetup section run.

    function saved_release_2(testcase)
      % Check that the model was saved in the expected MATLAB Release.
      info = Simulink.MDLInfo("RotationalFrictionTorque_SampleModel_refsub_24b");
      verifyEqual(testcase, info.ReleaseName, 'R2024b')
    end  % function

    function linked_app_in_live_script_1(testcase)
      %%
      script_fullpath = string( which("RotationalFrictionTorqueApp_Description_mus1"));

      if endsWith(script_fullpath, ".mlx")
        disp("The target file is not plain-text Live Script.")
        disp("!Skipping")

        return

      end  % if

      result = mus1.FileUtil.getLinkedCommandFromPlainTextLiveScript(script_fullpath);
      if isempty(result)
        disp("No linked apps were found.")

        return

      end  % for
      for ii = 1 : height(result)
        target_command = result.Command(ii);
        if endsWith(target_command, "App")
          disp("Hyperlinked app: " + target_command)
          fullpath = string( which(target_command));

          verifyTrue(testcase, fullpath ~= "")

        end  % if
      end  % for
    end  % function

  end  % methods
end  % classdef
