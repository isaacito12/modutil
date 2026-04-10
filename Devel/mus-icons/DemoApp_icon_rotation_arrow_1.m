function App = DemoApp_icon_rotation_arrow_1

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 300;  % width
main_figure.Position(4) = 200;  % height

v_container = AppUtil1.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------
v_layout = addVerticalGridLayout(v_container);
h_container = AppUtil1.HorizontalContainer(v_layout);

L_1 = 40;
L_2 = 22;

h_layout = addHorizontalGridLayout(h_container, Width=100);  % fixed width
image_ui_1 = AppUtil1.Graphics.Image(h_layout);
image_ui_1.MainFigure = main_figure;
image_ui_1.ComponentHeight = L_1;
image_ui_1.ImageSource = which("mus-icon-rotation-arrow.svg");
image_ui_1.ImageWidth = L_2;
image_ui_1.ImageHeight = L_2;
image_ui_1.VerticalAlignment = "top";
image_ui_1.HorizontalAlignment = "left";
image_ui_1.HighlightBackground = "off";

h_layout = addHorizontalGridLayout(h_container, Width=100);  % fixed width
image_ui_1 = AppUtil1.Graphics.Image(h_layout);
image_ui_1.MainFigure = main_figure;
image_ui_1.ComponentHeight = L_1;
image_ui_1.ImageSource = which("mus-icon-rotation-arrow.svg");
image_ui_1.ImageWidth = L_2;
image_ui_1.ImageHeight = L_2;
image_ui_1.VerticalAlignment = "top";
image_ui_1.HorizontalAlignment = "center";
image_ui_1.HighlightBackground = "on";

h_layout = addHorizontalGridLayout(h_container, Width=100);  % fixed width
image_ui_1 = AppUtil1.Graphics.Image(h_layout);
image_ui_1.MainFigure = main_figure;
image_ui_1.ComponentHeight = L_1;
image_ui_1.ImageSource = which("mus-icon-rotation-arrow.svg");
image_ui_1.ImageWidth = L_2;
image_ui_1.ImageHeight = L_2;
image_ui_1.VerticalAlignment = "top";
image_ui_1.HorizontalAlignment = "right";
image_ui_1.HighlightBackground = "off";

% -----------------------------------------------------------------------------
v_layout = addVerticalGridLayout(v_container);
h_container = AppUtil1.HorizontalContainer(v_layout);

L_1 = 60;
L_2 = 32;

h_layout = addHorizontalGridLayout(h_container, Width=100);  % fixed width
image_ui_1 = AppUtil1.Graphics.Image(h_layout);
image_ui_1.MainFigure = main_figure;
image_ui_1.ComponentHeight = L_1;
image_ui_1.ImageSource = which("mus-icon-rotation-arrow.svg");
image_ui_1.ImageWidth = L_2;
image_ui_1.ImageHeight = L_2;
image_ui_1.VerticalAlignment = "center";
image_ui_1.HorizontalAlignment = "left";
image_ui_1.HighlightBackground = "on";

h_layout = addHorizontalGridLayout(h_container, Width=100);  % fixed width
image_ui_1 = AppUtil1.Graphics.Image(h_layout);
image_ui_1.MainFigure = main_figure;
image_ui_1.ComponentHeight = L_1;
image_ui_1.ImageSource = which("mus-icon-rotation-arrow.svg");
image_ui_1.ImageWidth = L_2;
image_ui_1.ImageHeight = L_2;
image_ui_1.VerticalAlignment = "center";
image_ui_1.HorizontalAlignment = "center";
image_ui_1.HighlightBackground = "off";

h_layout = addHorizontalGridLayout(h_container, Width=100);  % fixed width
image_ui_1 = AppUtil1.Graphics.Image(h_layout);
image_ui_1.MainFigure = main_figure;
image_ui_1.ComponentHeight = L_1;
image_ui_1.ImageSource = which("mus-icon-rotation-arrow.svg");
image_ui_1.ImageWidth = L_2;
image_ui_1.ImageHeight = L_2;
image_ui_1.VerticalAlignment = "center";
image_ui_1.HorizontalAlignment = "right";
image_ui_1.HighlightBackground = "on";

% -----------------------------------------------------------------------------
v_layout = addVerticalGridLayout(v_container);
h_container = AppUtil1.HorizontalContainer(v_layout);

L_1 = 80;
L_2 = 42;

h_layout = addHorizontalGridLayout(h_container, Width=100);  % fixed width
image_ui_1 = AppUtil1.Graphics.Image(h_layout);
image_ui_1.MainFigure = main_figure;
image_ui_1.ComponentHeight = L_1;
image_ui_1.ImageSource = which("mus-icon-rotation-arrow.svg");
image_ui_1.ImageWidth = L_2;
image_ui_1.ImageHeight = L_2;
image_ui_1.VerticalAlignment = "bottom";
image_ui_1.HorizontalAlignment = "left";
image_ui_1.HighlightBackground = "off";

h_layout = addHorizontalGridLayout(h_container, Width=100);  % fixed width
image_ui_1 = AppUtil1.Graphics.Image(h_layout);
image_ui_1.MainFigure = main_figure;
image_ui_1.ComponentHeight = L_1;
image_ui_1.ImageSource = which("mus-icon-rotation-arrow.svg");
image_ui_1.ImageWidth = L_2;
image_ui_1.ImageHeight = L_2;
image_ui_1.VerticalAlignment = "bottom";
image_ui_1.HorizontalAlignment = "center";
image_ui_1.HighlightBackground = "on";

h_layout = addHorizontalGridLayout(h_container, Width=100);  % fixed width
image_ui_1 = AppUtil1.Graphics.Image(h_layout);
image_ui_1.MainFigure = main_figure;
image_ui_1.ComponentHeight = L_1;
image_ui_1.ImageSource = which("mus-icon-rotation-arrow.svg");
image_ui_1.ImageWidth = L_2;
image_ui_1.ImageHeight = L_2;
image_ui_1.VerticalAlignment = "bottom";
image_ui_1.HorizontalAlignment = "right";
image_ui_1.HighlightBackground = "off";

%%
if not(isMATLABReleaseOlderThan("R2025a"))
  % main_figure.Theme = "dark";
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.ImageUI = image_ui_1;
end  % if
end  % function
