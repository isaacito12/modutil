function App = DemoApp_DropDown_4_align

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 500;  % width
main_figure.Position(4) = 300;  % height

app_window_width = main_figure.Position(3);

main_v_container = mus1.AppUtil.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------
% !test-target

v_layout = addVerticalGridLayout(main_v_container);

dropdown_ui_1 = mus1.AppUtil.Component.DropDown(v_layout);
dropdown_ui_1.ComponentHeight = mus1.AppUtil.Constant.Height{"oneline++"} * 3;
dropdown_ui_1.DropDownWidth = floor(app_window_width / 2);
dropdown_ui_1.HorizontalAlignment = "left";
dropdown_ui_1.VerticalAlignment = "top";
dropdown_ui_1.Items = "left, top";
dropdown_ui_1.HighlightBackground = "on";

v_layout = addVerticalGridLayout(main_v_container);

dropdown_ui_2 = mus1.AppUtil.Component.DropDown(v_layout);
dropdown_ui_2.ComponentHeight = mus1.AppUtil.Constant.Height{"oneline++"} * 3;
dropdown_ui_2.DropDownWidth = floor(app_window_width / 2);
dropdown_ui_2.HorizontalAlignment = "center";
dropdown_ui_2.VerticalAlignment = "center";
dropdown_ui_2.Items = "center, center";
dropdown_ui_2.HighlightBackground = "off";

v_layout = addVerticalGridLayout(main_v_container);

dropdown_ui_3 = mus1.AppUtil.Component.DropDown(v_layout);
dropdown_ui_3.ComponentHeight = mus1.AppUtil.Constant.Height{"oneline++"} * 3;
dropdown_ui_3.DropDownWidth = floor(app_window_width / 2);
dropdown_ui_3.HorizontalAlignment = "right";
dropdown_ui_3.VerticalAlignment = "bottom";
dropdown_ui_3.Items = "right, bottom";
dropdown_ui_3.HighlightBackground = "on";

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
  App.DropDownUI_1 = dropdown_ui_1;
  App.DropDownUI_2 = dropdown_ui_2;
  App.DropDownUI_3 = dropdown_ui_3;
end % if
end  % function
