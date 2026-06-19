function App = DemoApp_DropDown_3_editable_on

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 500;  % width
main_figure.Position(4) = 300;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "dark";
end  % if

main_v_container = AppUtil1.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------

v_layout = addVerticalGridLayout(main_v_container);
h_container = AppUtil1.HorizontalContainer(v_layout);

h_layout = addHorizontalGridLayout(h_container);
button_ui_1 = AppUtil1.Component.Button(h_layout);
button_ui_1.Text = "Append item";
button_ui_1.ButtonWidth = 140;
button_ui_1.ButtonPushedCallback = @() react_AppendButtonPushed();

h_layout = addHorizontalGridLayout(h_container);
button_ui_2 = AppUtil1.Component.Button(h_layout);
button_ui_2.Text = "Remove last item";
button_ui_2.ButtonWidth = 140;
button_ui_2.ButtonPushedCallback = @() react_RemoveButtonPushed();

% -----------------------------------------------------------------------------
% !test-target

v_layout = addVerticalGridLayout(main_v_container);

% Editable is "off" (by default), but the drop down items can still be
% added or removed programmatically.
dropdown_ui_1 = AppUtil1.Component.DropDown(v_layout);
dropdown_ui_1.Editable = "on";
dropdown_ui_1.Items = ["Item 1", "Item 2"];
dropdown_ui_1.Value = "Item 2";
dropdown_ui_1.ValueChangedCallback = @() react_DropDownValueChanged();

  function react_AppendButtonPushed
    % Programmatically add a new item to the end of the items and select it.
    if numel(dropdown_ui_1.Items) > 0
      button_ui_2.MainButton.Enable = "on";
    end  % if
    current_items = dropdown_ui_1.Items;
    k = numel(current_items) + 1;
    dropdown_ui_1.Items = [current_items; "Item " + k];
    dropdown_ui_1.Value = dropdown_ui_1.Items(end);
  end  % nested function

  function react_RemoveButtonPushed
    % Remove the last item. Select the last item of the updated items.
    if isscalar(dropdown_ui_1.Items)
      button_ui_2.MainButton.Enable = "off";

      return

    end  % if
    button_ui_2.MainButton.Enable = "on";
    current_items = dropdown_ui_1.Items(:);
    dropdown_ui_1.Items = current_items(1 : end-1);
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
  App.DropDownUI_1 = dropdown_ui_1;
  App.ButtonUI_1 = button_ui_1;
  App.ButtonUI_2 = button_ui_2;
end % if
end  % function
