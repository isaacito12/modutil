function App = demoapp_plotLookupTable1DBlocks_24b()

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Output)
  App (1,:) struct
end  % arguments

model_name = "samplemodel_plotLookupTable1DBlocks_refsub_24b";
disp("Target model: " + model_name)
load_system(model_name)

main_figure = uifigure(Visible="off");
main_figure.Name = CodeUtil1.i18n("Demo App");
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 450;  % height

vertical_container = AppUtil1.VerticalContainer(main_figure);

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(vertical_container));
label_ui.MainFigure = main_figure;
label_ui.Text = CodeUtil1.i18n("Model name: ") + model_name;
label_ui.HorizontalAlignment = "center";

panel_ui = AppUtil1.Graphics.Panel(addVerticalGridLayout(vertical_container));
panel_ui.ComponentHeight = 390;
% panel_ui.HighlightBackground = "on";

ModelUtil1.plotLookupTable1DBlocks( ...
  model_name + "/Subsystem", ...
  Blocks = ["PS smooth1" "SL smooth1"], ...
  ParentType = "Panel", ...
  ParentPanel = panel_ui.MainPanel )

button_ui = AppUtil1.Component.Button(addVerticalGridLayout(vertical_container));
button_ui.MainFigure = main_figure;
button_ui.Text = CodeUtil1.i18n("Open model");
button_ui.ButtonWidth = 120;
button_ui.HorizontalAlignment = "center";
button_ui.ButtonPushedCallback = @() open_system(model_name);

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App.Window.MainFigure = main_figure;
end  % if
end  % function
