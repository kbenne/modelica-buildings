within Buildings.Applications.DataCenters.HVAC.AHUs.Examples;
model CoolingCoilHumidifyingHeating_ClosedLoop
  "Model of a air handling unit that tests temperature and humidity control"
  extends Modelica.Icons.Example;
  extends Buildings.Applications.DataCenters.HVAC.AHUs.Examples.BaseClasses.PartialAirHandlerControl(
    relHum(k=0.5),
    sou_1(p=500000),
    sou_2(nPorts=1),
    masFra(redeclare package Medium = Medium2),
    TSet(table=[0,288.15 + 1; 600,288.15 + 1; 600,288.15 + 1; 1200,288.15 + 1;
          1800,288.15 + 1; 2400,288.15 + 1; 2400,288.15 + 1]),
    TWat(startTime = 600, height=-2));

  parameter Modelica.SIunits.ThermalConductance UA_nominal=m2_flow_nominal*1006*(T_b2_nominal-T_a2_nominal)/
     Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(
        T_a1_nominal,
        T_b1_nominal,
        T_a2_nominal,
        T_b2_nominal)
    "Thermal conductance at nominal flow for sensible heat, used to compute time constant";

  Buildings.Applications.DataCenters.HVAC.AHUs.CoolingCoilHumidifyingHeating ahu(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    allowFlowReversal1=true,
    allowFlowReversal2=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    tauEleHea=1,
    tauHum=1,
    m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    UA_nominal=UA_nominal,
    dpValve_nominal=6000,
    QHeaMax_flow=10000,
    mWatMax_flow=0.01,
    perFan(pressure(V_flow=m2_flow_nominal*{0,0.5,1}, dp=300*{1.2,1.12,1})),
    yValve_start=1,
    dp1_nominal=3000,
    dp2_nominal=200,
    yValLow=0.4,
    yValHig=0.45,
    dTLow=-0.1,
    dTHig=0.1)
    "Air handling unit"
      annotation (Placement(transformation(extent={{46,20},{66,40}})));
  Modelica.Blocks.Sources.Constant uFan(k=1) "Control input for fan"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Blocks.Sources.TimeTable masFraSet(table=[0,0.009; 600,0.009; 600,0.009;
        1200,0.009; 1800,0.009; 2400,0.009; 2400,0.009])
    "Setpoint mass fraction"
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Buildings.Controls.Continuous.LimPID PID(
    yMax=1,
    reverseAction=true,
    Td=120,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=40,
    yMin=0.4)
    "PID controller for the water-side valve in air handling units"
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
equation
  connect(ahu.port_a2, sou_2.ports[1]) annotation (Line(points={{66,24},{80,24},
          {80,10},{154,10}}, color={0,127,255}));
  connect(uFan.y, ahu.uFan) annotation (Line(points={{21,-30},{30,-30},{30,26},
          {45,26}},color={0,0,127}));
  connect(ahu.port_b2, temSenAir2.port_a) annotation (Line(points={{46,24},{-12,
          24},{-12,10},{-26,10}}, color={0,127,255}));
  connect(temSenWat1.port_b, ahu.port_a1) annotation (Line(points={{-20,50},{
          -12,50},{-12,36},{46,36}}, color={0,127,255}));
  connect(TSet.y, PID.u_s)
    annotation (Line(points={{-49,90},{-25.5,90},{-2,90}}, color={0,0,127}));
  connect(temSenAir2.T, PID.u_m) annotation (Line(points={{-36,21},{-36,28},{10,
          28},{10,78}}, color={0,0,127}));
  connect(PID.y, ahu.uWatVal) annotation (Line(points={{21,90},{32,90},{32,34},
          {45,34}}, color={0,0,127}));
  connect(masFraSet.y, ahu.XSet_w) annotation (Line(points={{-19,-70},{32,-70},
          {32,31},{45,31}},     color={0,0,127}));
  connect(TSet.y, ahu.TSet) annotation (Line(points={{-49,90},{-10,90},{-10,60},
          {30,60},{30,29},{45,29}}, color={0,0,127}));
  connect(ahu.port_b1, temSenWat2.port_a) annotation (Line(points={{66,36},{80,
          36},{80,50},{96,50}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-160,
            -100},{260,160}})),
experiment(Tolerance=1E-6, StopTime=1200),
__Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Applications/DataCenters/HVAC/AHUs/Examples/CoolingCoilHumidifyingHeating_ClosedLoop.mos"
        "Simulate and PLot"),
Documentation(info="<html>
<p>
This model demonstrates the use of
<a href=\"modelica://Buildings.Applications.DataCenters.HVAC.AHUs.CoolingCoilHumidifyingHeating\">
Buildings.Applications.DataCenters.HVAC.AHUs.CoolingCoilHumidifyingHeating</a>. The valve on the water-side and
the electric heater on the air-side is regulated to track a setpoint temperature
for the air outlet. The humidifier on the air-side is manipulated to control the humidity
of the air outlet.
</p>
</html>", revisions="<html>
<ul>
<li>
April 11, 2017, by Yangyang Fu:<br/>
First implementation.
</li>
</ul>
</html>"));
end CoolingCoilHumidifyingHeating_ClosedLoop;