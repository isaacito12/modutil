function App = apptest_WindowHeader_2_no_MainFigure

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 300;  % width
main_figure.Position(4) = 80;  % height

layout = uigridlayout(main_figure, [1 1]);
layout.RowHeight = {'fit'};
layout.ColumnWidth = {'1x'};
layout.Padding = [0 0 0 0];
layout.ColumnSpacing = 0;
layout.RowSpacing = 0;

%%

window_header_ui = mus1.AppUtil.Component.WindowHeader(layout);  % !test-target
% window_header_ui.MainFigure = main_figure;

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
  App.WindowHeaderUI = window_header_ui;
end  % if
end  % function
