function App = DemoApp_Image_1_simplest
% Use the Image component in a simplest way.

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 300;  % width
main_figure.Position(4) = 200;  % height

v_container = mus1.AppUtil.VerticalContainer(main_figure);
v_layout = addVerticalGridLayout(v_container);

image_ui_1 = mus1.AppUtil.Graphics.Image(v_layout);  % !demo-target

image_ui_1.ImageSource = which("mus-icon-circle-arrow-5-to-15.svg");

image_ui_1.HighlightBackground = "on";

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
end  % if
end  % function
