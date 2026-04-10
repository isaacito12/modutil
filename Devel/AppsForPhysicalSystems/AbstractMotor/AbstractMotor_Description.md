
<a id="T_1FFD3858"></a>

# <span style="color:rgb(213,80,0)">Abstract Motor</span>

The abstract motor model represents a system\-level motor drive unit (MDU) consisting of an electric motor and a controller. The model simulates the high\-level behavior of power conversion between electric and mechanical powers by considering power conversion efficiency. The following blocks use this model. See the respective documentation for more details.

-  [Motor & Drive block](https://www.mathworks.com/help/sdl/ref/motordrive.html) (Simscape Driveline) 
-  [Motor & Drive (System\-Level) block](https://www.mathworks.com/help/sps/ref/motordrivesystemlevel.html) (Simscape Electrical) 
<a id="H_4e26"></a>

# Abstract Motor Efficiency App

Use the Abstract Motor Efficiency App to understand how the parameters affect the motor efficiency.

<a id="H_9924"></a>

# The abstract motor model

The core system equations of the abstract motor model are generally as follows.

 $$ J\;\frac{d\omega \;}{\textrm{dt}}=\tau {\;}_{\textrm{rot}} +\tau_{\textrm{cmd}} -k_f \;\omega \; $$ 

 $$ P_{\textrm{mech}} =\tau {\;}_{\textrm{cmd}} \cdot \omega \; $$ 

 $$ P_{\textrm{elec}} =i\cdot V $$ 

 $$ P_{\textrm{elec}} =P_{\textrm{mech}} +P_{\textrm{elecloss}} $$ 

 $$ P_{\textrm{elecloss}} =P_{\textrm{copper}} +P_{\textrm{iron}} +P_{\textrm{fixed}} $$ 

 $$ P_{\textrm{copper}} =k_{\textrm{copper}} \cdot {\left(\tau {\;}_{\textrm{rot}} \right)}^2 $$ 

 $$ P_{\textrm{iron}} =k_{\textrm{iron}} \cdot \omega {\;}^2 $$ 

 $$ M_{\textrm{therm}} \;\frac{d\;T_m }{\textrm{dt}}=P_{\textrm{elecloss}} +Q $$ 

 $$ \eta_{\textrm{nom}} =\left(\frac{1}{\eta_{\textrm{meas}} }-1\right)P_{\textrm{mech}} $$ 

where $J$ is motor inertia. $t$ time. $\omega \;$ rotor angular speed. $\tau_{\textrm{rot}}$ torque at motor rotor. $\tau_{\textrm{cmd}}$ torque command input to MDU. $k_f$ rotor frictional damping coefficient. $P_{\textrm{mech}}$ mechanical power. $P_{\textrm{elec}}$ electrical power whose sign indicates if the system is generating or consuming electric power. $P_{\textrm{elecloss}}$ electrical losses which can be modelled as a scalar constant, a formula as a function of motor speed etc., or a tabulated map. $i$ and $V$ electric current and voltage drop, respectively, connected to DC power supply. $P_{\textrm{copper}}$ copper loss. $P_{\textrm{iron}}$ iron loss. $P_{\textrm{fixed}}$ fixed loss which is constant across the whole operating region. $\eta_{\textrm{nom}}$ nominal loss (total loss). Front factors $k_{\textrm{copper}}$ and $k_{\textrm{iron}}$ are explained for each model below. $M_{\textrm{therm}}$ thermall mass of MDU. $T_m$ MDU temperature. $Q$ heat flow rate input to MDU.


The copper loss coefficient $k_{\textrm{copper}}$ is deteremined using the **single efficiency measurement model**

 $$ k_{\textrm{copper}} =\frac{\omega {\;}_{\textrm{meas}} \;\left(1-\eta {\;}_{\textrm{meas}} \right)}{\tau_{\textrm{meas}} \;\eta {\;}_{\textrm{meas}} } $$ 

where

-  ${\eta \;}_{\textrm{meas}}$ ... measured efficiency (normalized between 0 and 1, or in percent which needs to be normalized before used in the formula) 
-  $\omega {\;}_{\textrm{meas}}$ ... motor speed at which efficiency is measured 
-  $\tau_{\textrm{meas}}$ ... torque at which efficiecy is measured 

Iron loss coefficient $k_{\textrm{iron}}$ depends on the characteristics of motor drive unit, but it could be typically about 10% of $k_{\textrm{copper}}$.


*Copyright 2020\-2026 The Mathworks, Inc.*

