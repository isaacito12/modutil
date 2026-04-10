classdef ColumnLayout < handle
  % Column Layout
  %
  % This class provides a column-based grid layout to stack UI components vertically.
  % Successive calls of the addVerticalGridLayout function adds a UI component from top to bottom.
  %
  % By default, the width of a component is configured to be "1x".
  % The height of a component is configured to be "fit".
  %
  % Documentation about uigridlayout
  % https://www.mathworks.com/help/matlab/ref/uigridlayout.html

  % Copyright 2025 The MathWorks, Inc.

  properties
    BaseGrid (1,1) matlab.ui.container.GridLayout
    CurrentRow (1,1) {mustBeInteger, mustBeNonnegative} = 0
  end  % properties

  methods

    function layout = ColumnLayout(parent)
      %%
      arguments (Input)
        parent (1,1) {mustBeA(parent, ["matlab.ui.Figure", "matlab.ui.container.GridLayout"])}
      end  % arguments

      layout.BaseGrid = uigridlayout(parent, [1, 1]);
      layout.BaseGrid.ColumnWidth{1} = "1x";
      layout.BaseGrid.RowHeight{1} = "fit";
      layout.BaseGrid.Padding = [0 0 0 0];
      layout.BaseGrid.RowSpacing = 0;
      layout.BaseGrid.ColumnSpacing = 0;
      layout.BaseGrid.Scrollable = "on";
    end  % function

    function NewGrid = addVerticalGridLayout(layout, NameValuePair)
      %%
      arguments (Input)
        layout
        NameValuePair.Height (1,1) {CodeUtil1.mustBeStringOrPositiveInteger} = "fit"
        NameValuePair.Empty (1,1) logical = false
      end  % arguments

      layout.CurrentRow = layout.CurrentRow + 1;

      layout.BaseGrid.RowHeight{layout.CurrentRow} = NameValuePair.Height;

      if NameValuePair.Empty
        clear NewGrid

        return

      end  % if

      NewGrid = uigridlayout(layout.BaseGrid, [1 1]);
      NewGrid.Layout.Row = layout.CurrentRow;
      NewGrid.Layout.Column = 1;
      NewGrid.ColumnWidth{1} = "1x";
      NewGrid.RowHeight{1} = NameValuePair.Height;
      NewGrid.Padding = [0 0 0 0];
      NewGrid.RowSpacing = 0;
      NewGrid.ColumnSpacing = 0;
      NewGrid.Scrollable = "off";
    end  % function

  end  % methods
end  % classdef
