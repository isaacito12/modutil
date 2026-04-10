function App = DemoApp_Image_0_raw
% Build an app with the direct use of uiimage, uigridlayout, and uifigure.

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 200;  % width
main_figure.Position(4) = 200;  % height

main_layout = uigridlayout(main_figure, [3, 3]);
main_layout.ColumnWidth = {'1x', 22, '1x'};
main_layout.RowHeight = {'1x', 22, '1x'};
main_layout.Padding = [0 0 0 0];
main_layout.RowSpacing = 0;
main_layout.ColumnSpacing = 0;
main_layout.BackgroundColor = "#2DBEEF";

image_ui_1 = uiimage(main_layout);
image_ui_1.Layout.Row = 2;
image_ui_1.Layout.Column = 2;
image_ui_1.ImageSource = "mus-icon-error.svg";

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
end  % if
end  % function
