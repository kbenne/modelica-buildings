within Buildings.Fluid.FMI.Interfaces;
connector FluidPort_a "Connector for fluid inlet"
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true);

  input Buildings.Fluid.FMI.Interfaces.FlowProperties inflow(
    redeclare final package Medium = Medium) "Inflowing properties";
  output Buildings.Fluid.FMI.Interfaces.FluidProperties outflow(
    redeclare final package Medium = Medium) "Outflowing properties";

  annotation (defaultComponentName="port_a",
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Polygon(
          points={{-100,100},{-100,-100},{100,0},{-100,100}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillPattern=FillPattern.Backward,
          fillColor={0,0,255})}));
end FluidPort_a;
