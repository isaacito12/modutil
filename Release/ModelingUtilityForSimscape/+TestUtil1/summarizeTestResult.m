function TestSummary = summarizeTestResult(TestResultsFile)

% Copyright 2025 The MathWorks, Inc.

arguments (Input)
  TestResultsFile (1,1) string {mustBeFile}
end  % arguments

arguments (Output)
  TestSummary table
end  % arguments

result = readstruct(TestResultsFile);
result_table = struct2table(result.testsuite);

num_tests = sum(result_table.testsAttribute);

% Table columns
TestClass = strings(num_tests, 1);
TestFunction = strings(num_tests, 1);
TestTime = zeros(num_tests, 1);

test_count = 1;
for ii = 1 : height(result_table)
  if class(result_table.testcase) == "struct"
    % There is only one testcase as a struct. Accessing testcase{ii} is illegal.
    assert(ii == 1)
    subresult_table = struct2table(result_table.testcase);
  else
    subresult_table = struct2table(result_table.testcase{ii});
  end  % if
  num_subresult = result_table.testsAttribute(ii);

  TestClass(test_count : test_count + num_subresult - 1) = result_table.nameAttribute(ii);

  for jj = 1 : num_subresult

    TestFunction(test_count) = subresult_table.nameAttribute(jj);
    TestTime(test_count) = double(subresult_table.timeAttribute(jj));

    test_count = test_count + 1;
  end  % for
end  % for

TestSummary = sortrows(table(TestClass, TestFunction, TestTime), 'TestTime', 'descend');

TestSummary = addprop(TestSummary, ...
  ["NumTests", "TotalTestTime", "MeanTestTime", "MedianTestTime"], ...
  ["table",    "table",         "table",        "table"]);

TestSummary.Properties.CustomProperties.NumTests = num_tests;
TestSummary.Properties.CustomProperties.TotalTestTime = sum(TestTime);
TestSummary.Properties.CustomProperties.MeanTestTime = mean(TestTime);
TestSummary.Properties.CustomProperties.MedianTestTime = median(TestTime);

end  % function
