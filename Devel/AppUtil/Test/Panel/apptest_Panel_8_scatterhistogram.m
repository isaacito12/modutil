function App = apptest_Panel_8_scatterhistogram
% scatterhistogram in Panel

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 420;  % height

main_column_layout = AppUtil1.ColumnLayout(main_figure);

build_gui(main_column_layout);

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
end  % if
end  % function

function build_gui(column_layout)
%%
arguments (Input)
  column_layout (1,1) AppUtil1.ColumnLayout
end  % arguments

panel_ui = AppUtil1.Graphics.Panel(NewColumnGrid(column_layout));  % !test-target
panel_ui.ComponentHeight = 380;
% panel_ui.HighlightBackground = "on";
panel = panel_ui.MainPanel;

Data1 = [93	77	83	75	80	70	88	82	78	86	77	68	74	95	79	92	95 ...
  79	77	76	75	79	88	90	96	77	80	76	83	89	92	83	80	84	92	83	...
  90	85	90	74	92	80	89	96	89	77	81	76	83	78	95	91	91	86	89	...
  79	74	82	76	81	77	73	85	76	80	80	79	82	79	82	75	91	74	78	...
  85	84	75	78	81	79	85	79	82	80	80	92	92	96	87	81	90	77	91	79	73	99	92	74	93	86]';

Data2 = [124	109	125	117	122	121	130	115	115	118	114	115	127	130	114	130	124	...
  123	119	125	121	123	114	128	129	114	113	125	120	127	134	121	115	127	121	127	...
  136	117	124	120	128	116	132	137	117	116	119	123	116	124	129	130	132	117	129	...
  118	120	138	117	113	122	115	120	117	123	123	119	110	121	138	125	122	120	117	...
  125	124	121	118	120	118	118	122	134	131	113	125	135	128	123	122	138	124	130	123	129	128	124	119	136	114]';

Data3 = [true	false	false	false	false	false	true	false	false	false	false	false	...
  false	true	false	true	true	true	false	false	false	false	false	true	true	...
  false	false	false	false	true	true	false	false	false	false	false	true	false	...
  true	false	true	false	true	true	false	false	false	false	false	true	true	...
  true	true	false	true	false	false	true	false	false	false	false	false	false	...
  false	false	false	false	false	true	false	true	false	false	true	true	false	...
  false	false	false	false	false	true	false	false	true	true	true	true	false	...
  true	false	false	false	false	true	true	false	true	false]';

tbl = table(Data1, Data2, Data3);

scatterhistogram(panel, tbl, "Data1", "Data2", ... !test-target
  GroupVariable="Data3", HistogramDisplayStyle="smooth", ...
  LineStyle="-");

end  % function
