function App = DemoApp_DropDown_2_editable_off

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 500;  % width
main_figure.Position(4) = 300;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

main_v_container = mus1.AppUtil.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------

v_layout = addVerticalGridLayout(main_v_container);
h_container = mus1.AppUtil.HorizontalContainer(v_layout);

h_layout = addHorizontalGridLayout(h_container);
button_ui_1 = mus1.AppUtil.Component.Button(h_layout);
button_ui_1.Text = "Add item";
button_ui_1.ButtonWidth = 140;
button_ui_1.ButtonPushedCallback = @() react_AddButtonPushed();

% -----------------------------------------------------------------------------
% !test-target

v_layout = addVerticalGridLayout(main_v_container);

% Editable is "off" (by default), but the drop down items can still be
% added or removed programmatically.
dropdown_ui_1 = mus1.AppUtil.Component.DropDown(v_layout);
dropdown_ui_1.Items = ["Item 1", "Item 2", "Item 3"];
dropdown_ui_1.ValueChangedCallback = @() react_DropDownValueChanged();

item_count = numel(dropdown_ui_1.Items);

  function react_AddButtonPushed
    item_count = item_count + 1;
    items = dropdown_ui_1.Items(:);
    dropdown_ui_1.Items = [items; "Item " + item_count];
    dropdown_ui_1.Value = dropdown_ui_1.Items(end);
  end  % nested function

  function react_DropDownValueChanged()
    disp("Drop down value: " + dropdown_ui_1.Value)
  end  % nested function

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
  App.ButtonUI_1 = button_ui_1;
  App.DropDownUI_1 = dropdown_ui_1;
end % if
end  % function
