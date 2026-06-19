<a id="T_1FFD3858"></a>

# <span style="color:rgb(213,80,0)">Abstract Motor Efficiency</span>

The abstract motor model represents a system\-level motor drive unit (MDU) consisting of an electric motor and a controller. The model simulates the high\-level behavior of power conversion between electric and mechanical powers by considering power conversion efficiency. The following blocks use this model. See the respective documentation for more details about each block.

- [Motor & Drive block](https://www.mathworks.com/help/sdl/ref/motordrive.html) (Simscape Driveline)
- [Motor & Drive (System\-Level) block](https://www.mathworks.com/help/sps/ref/motordrivesystemlevel.html) (Simscape Electrical)

<a id="H_4e26"></a>

# Abstract motor efficiency app

Use the abstract motor efficiency app to understand how the model parameters affect the motor efficiency and set up the Motor & Drive blocks.

<a id="H_9924"></a>

# The abstract motor efficiency model

The core system equations of the abstract motor model are generally as follows.

The motor dynamics is computed as

 $$ J\;\frac{d\omega \;}{\mathrm{dt}}=\tau {\;}_{\mathrm{rot}} +\tau_{\mathrm{cmd}} -k_f \;\omega \; $$

where $J$ is motor inertia. $t$ is time. $\omega \;$ is rotor angular speed. $\tau_{\mathrm{rot}}$ is torque at motor rotor. $\tau_{\mathrm{cmd}}$ is torque command input to MDU. $k_f$ is rotor frictional damping coefficient. The Motor & Drive block from Simscape Driveline does not include the rotor damping, thus an external damper block is required for non\-zero $k_f$ if necessary.

The mechanical power of the motor, $P_{\mathrm{mech}}$, is computed as

 $$ P_{\mathrm{mech}} =\tau {\;}_{\mathrm{cmd}} \cdot \omega \; $$

The electrical power, $P_{\mathrm{elec}}$, is computed as

 $$ P_{\mathrm{elec}} =i\cdot V $$

where the sign of $P_{\mathrm{elec}}$ indicates if the system is generating or consuming electric power. $i$ and $V$ are electric current and voltage drop, respectively, connected to DC power supply. $P_{\mathrm{elec}}$ is converted to and from $P_{\mathrm{mech}}$ and losses as

 $$ P_{\mathrm{elec}} =P_{\mathrm{mech}} +P_{\mathrm{elecloss}} $$ 

where the electrical losses, $P_{\mathrm{elecloss}}$, can be modeled as a scalar constant, a formula as a function of motor speed etc., or a tabulated map. Here, model it as a function of $\tau_{\mathrm{rot}}$ and $\omega \;$ as follows.

 $$ P_{\mathrm{elecloss}} \left(\tau_{\mathrm{rot}} ,\;\omega \;\right)=P_{\mathrm{copper}} \left(\tau_{\mathrm{rot}} \right)+P_{\mathrm{iron}} \left(\omega \;\right)+P_{\mathrm{fixed}} $$ 

where $P_{\mathrm{copper}}$ is copper loss. $P_{\mathrm{iron}}$ is iron (core) loss. $P_{\mathrm{fixed}}$ is fixed loss which is constant across the whole operating region. $P_{\mathrm{copper}}$ and $P_{\mathrm{iron}}$ are modeled as follows. (The Motor & Drive block from Simscape Driveline assumes that $P_{\mathrm{iron}}$ and $P_{\mathrm{fixed}}$ are zero.)

 $$ P_{\mathrm{copper}} \left(\tau_{\mathrm{rot}} \right)=k_{\mathrm{copper}} \cdot {\left(\tau {\;}_{\mathrm{rot}} \right)}^2 $$ 

 $$ P_{\mathrm{iron}} \left(\omega \;\right)=k_{\mathrm{iron}} \cdot \omega {\;}^2 $$ 

where $k_{\mathrm{copper}}$ and $k_{\mathrm{iron}}$ are copper loss coefficient and iron loss coefficient, respectively. They are determined later.

The nominal (rated) loss, $P_{\mathrm{nom}}$, is computed as

 $$ P_{\mathrm{nom}} =\left(\frac{1}{\eta \;}-1\right)P_{\mathrm{mech}} $$ 

where $\eta \;$ is overall efficiency.

The motor temperature can be optionally computed as

 $$ M_{\mathrm{therm}} \;\frac{d\;T_m }{\mathrm{dt}}=P_{\mathrm{elecloss}} +Q $$ 

where $M_{\mathrm{therm}}$ is thermal mass of MDU. $T_m$ is MDU temperature. $Q$ is heat flow rate input to MDU.

## Determine the iron loss coefficient and the copper loss coefficient

The iron loss coefficient $k_{\mathrm{iron}}$ and the copper loss coefficient $k_{\mathrm{copper}}$ are determined using the **single efficiency measurement model** as follows.

First, find the mechanical power at the efficiency measurement point ( $\omega_m$, $\tau_m$ ).

 $$ P_{\mathrm{mech},m} =\tau_m \cdot \omega_m $$ 

Then the nominal (rated) loss at the measurement point is obtained.

 $$ P_{\mathrm{nom},m} =\left(\frac{1}{\eta \;}-1\right)P_{\mathrm{mech},m} $$ 

The iron (core) loss at the measurement point, $P_{\mathrm{iron},m}$, is typically around 10% to 20% of $P_{\mathrm{nom},m}$. Specify a value for $P_{\mathrm{iron},m}$. (Use the efficiency app to visually inspect the efficiency contour map.) With $P_{\mathrm{iron},m}$ having been specified, the iron loss coefficient, $k_{\mathrm{iron}}$, is determined from the iron loss model.

 $$ k_{\mathrm{iron}} =\frac{P_{\mathrm{iron},m} }{{\left(\omega_m \right)}^2 } $$ 

The copper loss at the measurement point, $P_{\mathrm{copper},m}$, is obtained as follows.

 $$ P_{\mathrm{copper},m} =P_{\mathrm{nom},m} -P_{\mathrm{iron},m} -P_{\mathrm{fixed}} $$ 

 $k_{\mathrm{copper}}$ can be determined from the copper loss model.

 $$ k_{\mathrm{copper}} =\frac{P_{\mathrm{copper},m} }{{\left(\tau_m \right)}^2 } $$ 

## Notes on the maximum motor speed

Maximum motor speed is not a parameter of the abstract motor model, and the Motor & Drive blocks do not have the maximum speed as a parameter, but it is typically defined by higher\-level system requirements.

For example, in the road vehicle applications, the vehicle top speed and a few other vehicle specs determine the maximum motor speed. Let $V$, $R$, $G$ be the vehicle top speed, tire rolling radius, and the reduction gear ratio, respectively. Then the maximum motor speed $\omega_{\max }$ is derived as

 $$ \omega_{\max } =\frac{V}{2\pi \;R\;G} $$ 

Example: When $V$ = 180 kph (112 mph), $R$ = 30 cm (12 in), $G$ = 1/10, then $\omega_{\max }$ = 15,915 rpm.

# Motor & Drive (System Level) block (Simscape Electrical)

Configure the Motor & Drive (System Level) block as follows.

- Electrical Torque > Parameterized by: Maximum torque and power
- Electrical Losses > Parameterize losses by: Single efficiency measurement

Then, use the abstract motor efficiency app or the following function to visualize the power conversion efficiency map.

# Motor & Drive block (Simscape Driveline)

Abstract motor model with the following settings corresponds to the Motor & Drive block.

- Iron loss at measurement point, $P_{\mathrm{iron},m}$ = 0
- Fixed loss, $P_{\mathrm{fixed}}$ = 0
- Rotor damping coefficient, $k_f$ = 0

# Ideal motor

By setting the overall efficiency $\eta \;$ to 100 % and losses to 0, the abstract motor model becomes an ideal motor where the power conversion has no losses in all operating region.

*Copyright 2020\-2026 The Mathworks, Inc.*