function App = apptest_EditableDropDown_2

% If Editable is "off" in an EditableDropDown component, interactive edit is disabled,
% but, it is still possible to modify the Items property programmaticaly.

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 500;  % width
main_figure.Position(4) = 300;  % height

app_vertical_container = AppUtil1.VerticalContainer(main_figure);

%%

button_ui = AppUtil1.Component.Button(addVerticalGridLayout(app_vertical_container));
button_ui.MainFigure = main_figure;
button_ui.Text = "Add an item";
button_ui.ButtonWidth = 140;
button_ui.ButtonPushedCallback = @() react_ButtonPushed();

editable_drop_down_ui = AppUtil1.Component.EditableDropDown(addVerticalGridLayout(app_vertical_container));  % !test-target
editable_drop_down_ui.MainFigure = main_figure;

% Set Items before turning off MainDropDown's Editable property.
editable_drop_down_ui.Items = ["1", "2"];

editable_drop_down_ui.MainDropDown.Editable = "off";

% Set new Items after turning off MainDropDown's Editable property.
editable_drop_down_ui.Items = ["aa", "bb", "cc"];

  function react_ButtonPushed
    items = editable_drop_down_ui.Items;
    % Modify the items programmatically via button click.
    editable_drop_down_ui.Items = [items; "Added by button"];  % !test-target
  end  % nested function

%%
if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.EditableDropDownUI = editable_drop_down_ui;
  App.ButtonUI = button_ui;
end % if
end  % function
