function App = apptest_AppWindow_1_simplest

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");

app_window = mus1.AppUtil.AppWindow(main_figure);  % !test-target
app_window.Name = mus1.CodeUtil.i18n("Test");
app_window.Width = 800;
app_window.Height = 400;

%%
if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window = app_window;
end % if
end  % function
