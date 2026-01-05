# Report test result

```matlabTextOutput
UTC 2026-01-05 10:57:51
```

```matlabTextOutput
  matlabRelease with properties:


    Release: "R2026a"
      Stage: "prerelease"
     Update: 1
       Date: 2025-11-19
```

```matlabTextOutput
Error using indexing (line 73)
Brace indexing is not supported for variables of type struct.


Error in TestUtil1.summarizeTestResult (line 25)
  subresult_table = struct2table(result_table.testcase{ii});
```

*Copyright 2025 The MathWorks, Inc.*