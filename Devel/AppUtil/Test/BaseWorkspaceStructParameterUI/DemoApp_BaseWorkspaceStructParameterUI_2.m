function App = DemoApp_BaseWorkspaceStructParameterUI_2

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 800;  % width
main_figure.Position(4) = 300;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "dark";
end  % if

main_layout = uigridlayout(main_figure, [1 1]);
main_layout.RowHeight = {'fit'};
main_layout.ColumnWidth = {'1x'};
main_layout.Padding = [0 0 0 0];
main_layout.ColumnSpacing = 0;
main_layout.RowSpacing = 0;

% -----------------------------------------------------------------------------
% !test-target

parameter_ui_1 = AppUtil1.Component.BaseWorkspaceStructParameterUI(main_layout);
parameter_ui_1.GetParametersFromBaseWorkspaceCallback = @() callback1();

  function callback1()
    struct_text = parameter_ui_1.StructNameDropDownUI.Value;
    disp("struct name: " + struct_text)

    s = evalin("base", struct_text + ";");

    disp(s)

  end  % function

% parameter_ui_1.Reporting = "on";

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
  App.BaseWorkspaceStructParameterUI_1 = parameter_ui_1;
end  % if
end  % function
