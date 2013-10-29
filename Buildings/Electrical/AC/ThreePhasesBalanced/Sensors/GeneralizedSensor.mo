within Buildings.Electrical.AC.ThreePhasesBalanced.Sensors;
model GeneralizedSensor "Sensor for power, voltage and current"
  extends Buildings.Electrical.Interfaces.GeneralizedSensor(
    redeclare final package PhaseSystem_n = PhaseSystems.OnePhase,
    redeclare final Interfaces.Terminal_n terminal_n,
    redeclare final Interfaces.Terminal_p terminal_p);
  annotation (defaultComponentName="sen",
  Documentation(info="<html>
<p>
Ideal sensor that measures power, voltage and current.
The two components of the power <i>S</i> are the active and reactive power.
</p>
</html>", revisions="<html>
<ul>
<li>
July 24, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end GeneralizedSensor;
