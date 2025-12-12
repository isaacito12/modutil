# Modeling Utility for Simscape™

This is a collection of MATLAB® apps and APIs to streamline
modeling workflows with Simscape.

## Set up

To use this utility, put the `ModelingUtilityForSimscape` folder
in a desired location in your computer and add the folder to the MATLAB path.

## Highlights

### Building apps programmatically with **AppUtil**

- Use the `AppUtil` API to easily build simple apps programmatically.
- The API uses the `uifigure` and `uigridlayout` functions.
- The API is fully compatible with all UI components that work
  with `uifigure` and `uigridlayout`.
- All of the apps included in this utility are built with the `AppUtil` API.

### Input signal handling with **SignalUtil**

- Use the `SignalDesignApp` and the `TraceGeneratorApp` to create
  input signals for simulations.

<img src="ModelingUtilityForSimscape/media/screenshot-SignalDesignApp-dark.png"
 alt="Signal Design App" width="600"/>

### Lookup table visualization with **ModelUtil**

- Use the `LookupTable1DBlockPlotApp` to find and visualize
  Simscape PS Lookup Table (1D) blocks and Simulink 1-D Lookup Table blocks
  in models.

<img src="ModelingUtilityForSimscape/media/screenshot-LookupTable1DBlockPlotApp-dark.png"
 alt="Lookup Table 1D Block Plot App" width="600"/>

### Text search and replace with **SearchUtil**

- Use the `TextSearchApp` and the `TextSearchResultViewerApp` to search
  and replace text in files and models.
- Use the `SearchUtil` API for complex search and replace operations.

<img src="ModelingUtilityForSimscape/media/screenshot-TextSearchApp-dark.png"
 alt="Lookup Table 1D Block Plot App" width="500"/>

<img src="ModelingUtilityForSimscape/media/screenshot-TextSearchResultViewerApp-dark.png"
 alt="Lookup Table 1D Block Plot App" width="600"/>

## Apps for physical systems

### Rotational friction app

- Use the `RotationalFrictionApp` to understand the friction model
  and its parameters used in the Rotational Friction block in Simscape.

<img src="ModelingUtilityForSimscape/media/screenshot-RotationalFrictionApp-dark-1.png"
 alt="Lookup Table 1D Block Plot App" width="800"/>

## Development of the utility

The development repository is hosted in GitHub:

https://github.com/isaacito12/modutil

## License

See `license.txt` for details.

_Copyright 2025 The MathWorks, Inc._
