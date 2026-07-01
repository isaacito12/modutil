# Guide

Running the `demo_checkRefSubInCallbackButton_24b_live` script in
`Test > ModelUtil > checkRefSubInCallbackButton` produces an error
with the following error messages.

```matlab
Error using mus1.ModelUtil.checkRefSubInSetParam (line 39)
Code must be nonempty.

Error in mus1.ModelUtil.checkRefSubInCallbackButton (line 54)
  data = mus1.ModelUtil.checkRefSubInSetParam(lines, DisplayInfo=NameValuePair.DisplayInfo);
```

Identify the bug and suggest a plan to fix. Do not modify any file and folder.
