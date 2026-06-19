# Using Simscape custom physical units for power

Physical Units
https://www.mathworks.com/help/simscape/physical-units.html

Unit Definitions
https://www.mathworks.com/help/simscape/ug/unit-definitions.html

`pm_getunits`
Get information about all units in unit registry
https://www.mathworks.com/help/simscape/ref/pm_getunits.html

```matlab
type pm_units
```

`pm_addunit`
https://www.mathworks.com/help/simscape/ref/pm_addunit.html

```matlab
pm_addunit("bhp", 745.7, "W");  % Brake horsepower (imperial)
pm_addunit("ps", 735.5, "W");  % Metric horsepower (Pferdestärke)
```

```matlab
u = string(pm_getunits);
tail(u, 5)
```

```matlab
x = simscape.Value(100, "kW");
convert(x, "bhp")  % 134.1022 (bhp)
convert(x, "ps")  % 135.9619 (ps)

value(x, "bhp");
value(x, "ps");
```

_Copyright 2026 The MathWorks, Inc._
