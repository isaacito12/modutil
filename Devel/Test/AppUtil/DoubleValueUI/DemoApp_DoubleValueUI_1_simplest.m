function App = DemoApp_DoubleValueUI_1_simplest

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = mus1.CodeUtil.i18n("Test");
main_figure.Position(3) = 640;  % width
main_figure.Position(4) = 160;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "dark";
end  % if

main_v_container = mus1.AppUtil.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------
% !test-target

v_layout = addVerticalGridLayout(main_v_container);

dvalue_ui_1 = mus1.AppUtil.Component.DoubleValueUI(v_layout);

dvalue_ui_1.HighlightBackground = "on";

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
  App.DoubleValueUI_1 = dvalue_ui_1;
end  % if
end  % function
