classdef RowLayout < handle
  % Row Layout
  %
  % Documentation about uigridlayout
  % https://www.mathworks.com/help/matlab/ref/uigridlayout.html

  % Copyright 2025 The MathWorks, Inc.

  properties
    BaseGrid (:,1) matlab.ui.container.GridLayout
    CurrentColumn (1,1) {mustBeInteger, mustBeNonnegative} = 0
  end  % properties

  methods

    function layout = RowLayout(parent)
      %%
      arguments (Input)
        parent {mustBeA(parent, ["matlab.ui.Figure", "matlab.ui.container.GridLayout"])}
      end  % arguments

      layout.BaseGrid = uigridlayout(parent, [1, 1]);
      layout.BaseGrid.ColumnWidth{1} = "1x";
      layout.BaseGrid.RowHeight{1} = "fit";
      layout.BaseGrid.Padding = [0 0 0 0];
      layout.BaseGrid.RowSpacing = 0;
      layout.BaseGrid.ColumnSpacing = 0;
      layout.BaseGrid.Scrollable = "off";
    end  % function

    function NewGrid = NewRowGrid(layout, NameValuePair)
      %%
      arguments (Input)
        layout
        NameValuePair.Width (1,1) {CodeUtil1.mustBeStringOrPositiveInteger} = "1x"
      end  % arguments

      layout.CurrentColumn = layout.CurrentColumn + 1;

      layout.BaseGrid.ColumnWidth{layout.CurrentColumn} = NameValuePair.Width;

      NewGrid = uigridlayout(layout.BaseGrid, [1 1]);
      NewGrid.Layout.Row = 1;
      NewGrid.Layout.Column = layout.CurrentColumn;
      NewGrid.ColumnWidth{1} = NameValuePair.Width;
      NewGrid.RowHeight{1} = "fit";
      NewGrid.Padding = [0 0 0 0];
      NewGrid.RowSpacing = 0;
      NewGrid.ColumnSpacing = 0;
      NewGrid.Scrollable = "off";
    end  % function

  end  % methods
end  % classdef
