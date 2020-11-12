within Buildings.Experimental.DHC.EnergyTransferStations.Combined.Generation5;
model ChillerBorefield1
  "ETS model for 5GDHC systems with heat recovery chiller and optional borefield"
  extends ChillerBorefield(
    redeclare Controls.Supervisory1 conSup(
      final controllerType=controllerType,
      final kHot=kHot,
      final kCol=kCol,
      final Ti=Ti,
      final dTDea=dTDea,
      final THeaWatSupSetMin=THeaWatSupSetMin,
      final dTHys=dTHys),
    chi(
      have_res=true,
      final TChiWatSupSetMin=TChiWatSupSetMin));
  parameter Modelica.SIunits.TemperatureDifference dTHys=1.0
    "Temperature hysteresis for supervisory control"
    annotation (Dialog(group="Supervisory controller"));
  parameter Modelica.SIunits.TemperatureDifference dTDea=0.5
    "Temperature dead band for supervisory control"
    annotation (Dialog(group="Supervisory controller"));
equation
  connect(conSup.THeaWatSupSet,chi.THeaWatSupSet)
    annotation (Line(points={{-238,19},{-24,19},{-24,-6},{-12,-6}},color={0,0,127}));
  connect(tanHeaWat.TBot, conSup.THeaWatBot) annotation (Line(points={{-199,97},
          {-186,97},{-186,86},{-266,86},{-266,23},{-262,23}}, color={0,0,127}));
  connect(tanChiWat.TTop, conSup.TChiWatTop) annotation (Line(points={{221,115},
          {242,115},{242,76},{-278,76},{-278,17},{-262,17}}, color={0,0,127}));
  annotation (
    defaultComponentName="ets",
    Documentation(
      revisions="<html>
<ul>
<li>
July 31, 2020, by Antoine Gautier:<br/>
First implementation
</li>
</ul>
</html>",
      info="<html>
<p>
This model is similar to
<a href=\"modelica://Buildings.Experimental.DHC.EnergyTransferStations.Combined.Generation5.ChillerBorefield\">
Buildings.Experimental.DHC.EnergyTransferStations.Combined.Generation5.ChillerBorefield</a>
but uses an alternative supervisory control logic where the chilled water supply temperature
is first reset when the heating water tank is in demand, which triggers the cold rejection
demand and the operation of the systems serving as ambient sources.
See the schematics below and
<a href=\"modelica://Buildings.Experimental.DHC.EnergyTransferStations.Combined.Generation5.Controls.Supervisory1\">
Buildings.Experimental.DHC.EnergyTransferStations.Combined.Generation5.Controls.Supervisory1</a>
for a more detailed description of the operating principles.
</p>
<p>
<img alt=\"System schematics\"
src=\"modelica://Buildings/Resources/Images/Experimental/DHC/EnergyTransferStations/Combined/Generation5/ChillerBorefield1.png\"/>
</p>
</html>"));
end ChillerBorefield1;
