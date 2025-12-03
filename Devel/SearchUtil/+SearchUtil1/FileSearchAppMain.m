classdef FileSearchAppMain < handle
  % App to search for files in the specified folder
  %
  % This is the main implementation of the app.

  % Copyright 2025 The MathWorks, Inc.

  properties (Access=private, Constant)
    errorID (1,1) string = "FileSearchAppMain:"
  end  % properties

  properties

    SearchResult (:,1) string
    CommandText (1,1) string

    % -------------------------------------------------------------------------
    % GUI parts

    GUIReady (1,1) logical = false

    Window AppUtil1.AppWindow

    TopFolderUI AppUtil1.Component.DropDown
    SelectFolderUI AppUtil1.Component.Button

    SearchFilenameUI AppUtil1.Component.EditableDropDown

    CopyCommandButtonUI AppUtil1.Component.Button
    SearchButtonUI AppUtil1.Component.Button

  end  % properties

  properties (Constant, Access=private)
    width_button = AppUtil1.Constant.Width{"unitwidth"} * 12
  end  % properties

  methods

    function App = FileSearchAppMain(NameValuePair)
      %%
      arguments (Input)
        NameValuePair.TopFolder (1,1) string {mustBeFolder} = pwd
        NameValuePair.SearchFilename (1,1) string = "test-result.xml"
      end  % arguments

      % -----------------------------------------------------------------------
      % Before building app GUI

      meta_data = metaclass(App);

      main_figure = uifigure(Visible="off");

      % -----------------------------------------------------------------------
      % Build app GUI

      App.Window = AppUtil1.AppWindow(main_figure, SourceFile=which(meta_data.Name));
      App.Window.Name = CodeUtil1.i18n("File search");
      App.Window.Height = 160;
      App.Window.Width = 600;

      build_app_gui(App)

      % -----------------------------------------------------------------------
      % After building app GUI

      target_folder = replace(NameValuePair.TopFolder, ("/"|"\"), " > ");
      App.TopFolderUI.Items = target_folder;
      App.TopFolderUI.Value = target_folder;

      App.SearchFilenameUI.Value = NameValuePair.SearchFilename;

      App.GUIReady = true;

      update_SearcherStatesFromUIComponents(App)

      % -----------------------------------------------------------------------
      movegui(main_figure, "center")
      main_figure.Visible = "on";
      drawnow
      if nargout == 0
        clear App
      end  % if
    end  % function

    function build_app_gui(App)
      %%
      main_column_layout = App.Window.MainLayout;

      % =======================================================================
      % Top folder
      column_grid = NewColumnGrid(main_column_layout);
      row_layout = AppUtil1.RowLayout(column_grid);

      row_grid = NewRowGrid(row_layout, Width="fit");
      label_ui = AppUtil1.Component.Label(row_grid);
      label_ui.Text = "\textbf{" + CodeUtil1.i18n("Top folder") + "}";

      row_grid = NewRowGrid(row_layout, Width="fit");
      App.SelectFolderUI = AppUtil1.Component.Button(row_grid);
      App.SelectFolderUI.ButtonWidth = App.width_button;
      App.SelectFolderUI.Text = CodeUtil1.i18n("Select...");
      App.SelectFolderUI.MainButton.Tooltip = CodeUtil1.i18n("Select a target folder and add to the drop down.");
      App.SelectFolderUI.ButtonPushedCallback = @() react_SelectFolderButtonPushed(App);

      % -----------------------------------------------------------------------
      column_grid = NewColumnGrid(main_column_layout);

      App.TopFolderUI = AppUtil1.Component.DropDown(column_grid);
      App.TopFolderUI.MainDropDown.Items = "";
      App.TopFolderUI.ValueChangedCallback = @() update_SearcherStatesFromUIComponents(App);

      % =======================================================================
      % Filename to search
      column_grid = NewColumnGrid(main_column_layout);

      label_ui = AppUtil1.Component.Label(column_grid);
      label_ui.Text = "\textbf{" + CodeUtil1.i18n("Filename to find") + "}";

      % -----------------------------------------------------------------------
      column_grid = NewColumnGrid(main_column_layout);

      App.SearchFilenameUI = AppUtil1.Component.EditableDropDown(column_grid);
      App.SearchFilenameUI.Items = [];
      App.SearchFilenameUI.ValueChangedCallback = @() react_SearchFilenameChanged(App);

      % =======================================================================
      column_grid = NewColumnGrid(main_column_layout);
      AppUtil1.Component.HorizontalLine(column_grid);

      % =======================================================================
      column_grid = NewColumnGrid(main_column_layout);
      row_layout = AppUtil1.RowLayout(column_grid);

      App.CopyCommandButtonUI = AppUtil1.Component.Button(NewRowGrid(row_layout));
      App.CopyCommandButtonUI.Text = CodeUtil1.i18n("Copy command");
      App.CopyCommandButtonUI.MainButton.Tooltip = CodeUtil1.i18n("Copy the search command to clipboard.");
      App.CopyCommandButtonUI.ButtonWidth = App.width_button;
      App.CopyCommandButtonUI.HorizontalAlignment = "center";
      App.CopyCommandButtonUI.ButtonPushedCallback = @() react_CopyCommandButtonPushed(App);

      App.SearchButtonUI = AppUtil1.Component.Button(NewRowGrid(row_layout));
      App.SearchButtonUI.Text = CodeUtil1.i18n("Search");
      App.SearchButtonUI.ButtonWidth = App.width_button;
      App.SearchButtonUI.HorizontalAlignment = "center";
      App.SearchButtonUI.ButtonPushedCallback = @() react_SearchButtonPushed(App);
    end  % function

    function react_SelectFolderButtonPushed(App)
      %%
      selected_folder = uigetdir(pwd);
      if selected_folder == 0
        % The user clicked Cancel or the close button.

        return

      end  % if
      if not(ismember(selected_folder, App.TopFolderUI.Items))
        selected_folder = replace(selected_folder, ("/"|"\"), " > ");
        App.TopFolderUI.Items = [App.TopFolderUI.Items; selected_folder];
      end  % if
      App.TopFolderUI.Value = selected_folder;
    end  % function

    function react_SearchFilenameChanged(App)
      %%
      st = App.SearchFilenameUI.Value;
      if st ~= "" && not(ismember(st, App.SearchFilenameUI.Items))
        App.SearchFilenameUI.Items = [App.SearchFilenameUI.Items; st];
      end  % if
      update_SearcherStatesFromUIComponents(App)
    end  % function

    function update_SearcherStatesFromUIComponents(App)
      %%
      if not(App.GUIReady)

        return

      end  % if

      if App.SearchFilenameUI.Value == ""
        % Search is not ready.
        App.CopyCommandButtonUI.MainButton.Enable = "off";
        App.SearchButtonUI.MainButton.Enable = "off";
        App.CommandText = "";
      else
        % Search is ready.
        App.CopyCommandButtonUI.MainButton.Enable = "on";
        App.SearchButtonUI.MainButton.Enable = "on";
        top_folder = replace(App.TopFolderUI.Value, " > ", filesep);
        App.CommandText = "SearchUtil1.searchFiles(""" + App.SearchFilenameUI.Value + """, TopFolder=""" + top_folder + """)";
      end  % if
    end  % function

    function react_CopyCommandButtonPushed(App)
      %%
      clipboard("copy", App.CommandText)
    end  % function

    function react_SearchButtonPushed(App)
      %%
      if App.SearchFilenameUI.Value == ""
        % Search is not ready.

        return

      end  % if

      top_folder = replace(App.TopFolderUI.Value, " > ", filesep);
      App.SearchResult = SearchUtil1.searchFiles(App.SearchFilenameUI.Value, TopFolder=top_folder);

      if isempty(App.SearchResult)
        uialert(App.Window.MainFigure, CodeUtil1.i18n("File was not found."), CodeUtil1.i18n("Not found"))

        return

      end  % if

      SearchUtil1.FileSearchResultViewerAppMain( ...
        SearchResult = App.SearchResult, ...
        SearchFilename = App.SearchFilenameUI.Value, ...
        TopFolder = top_folder)

    end  % function

  end  % methods
end  % classdef
