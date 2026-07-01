function App = DemoApp_Image_3

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 400;  % width
main_figure.Position(4) = 100;  % height

v_container = mus1.AppUtil.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------
v_layout = addVerticalGridLayout(v_container);
h_container = mus1.AppUtil.HorizontalContainer(v_layout);

h_layout = addHorizontalGridLayout(h_container, Width="fit");
label_ui = mus1.AppUtil.Component.Label(h_layout);
label_ui.MainFigure = main_figure;
label_ui.Text = "Demo app for the Image component";

h_layout = addHorizontalGridLayout(h_container, width=34);
image_ui_1 = mus1.AppUtil.Graphics.Image(h_layout);  % !demo-target
image_ui_1.MainFigure = main_figure;
image_ui_1.MainImage.Tooltip = "Click the icon to copy a sample text to clipboard";
image_ui_1.ImageClickedCallback = @() clipboard("copy", "Copied: " + label_ui.Text);

%%
if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
  App.ImageUI = image_ui_1;
end  % if
end  % function
