within Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines;
model TwoPortMatrixRLC_N
  "PI model of a line parameterized with impedance and admittance matrices and neutral line"
  extends Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.TwoPort_N;
  parameter Modelica.SIunits.Voltage V_nominal(min=0, start=480)
    "Nominal voltage (V_nominal >= 0)"  annotation(Evaluate=true, Dialog(group="Nominal conditions"));
  parameter Modelica.SIunits.Impedance Z11[2]
    "Element [1,1] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z12[2]
    "Element [1,2] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z13[2]
    "Element [1,3] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z14[2]
    "Element [1,4] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z22[2]
    "Element [2,2] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z23[2]
    "Element [2,3] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z24[2]
    "Element [2,4] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z33[2]
    "Element [3,3] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z34[2]
    "Element [3,4] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z44[2]
    "Element [4,4] of impedance matrix";
  final parameter Modelica.SIunits.Impedance[2] Z21 = Z12
    "Element [2,1] of impedance matrix";
  final parameter Modelica.SIunits.Impedance[2] Z31 = Z13
    "Element [3,1] of impedance matrix";
  final parameter Modelica.SIunits.Impedance[2] Z32 = Z23
    "Element [3,1] of impedance matrix";
  final parameter Modelica.SIunits.Impedance[2] Z41 = Z14
    "Element [4,1] of impedance matrix";
  final parameter Modelica.SIunits.Impedance[2] Z42 = Z24
    "Element [4,2] of impedance matrix";
  final parameter Modelica.SIunits.Impedance[2] Z43 = Z34
    "Element [4,3] of impedance matrix";

  parameter Modelica.SIunits.Admittance B11
    "Element [1,1] of admittance matrix";
  parameter Modelica.SIunits.Admittance B12
    "Element [1,2] of admittance matrix";
  parameter Modelica.SIunits.Admittance B13
    "Element [1,3] of admittance matrix";
  parameter Modelica.SIunits.Admittance B14
    "Element [1,4] of admittance matrix";
  parameter Modelica.SIunits.Admittance B22
    "Element [2,2] of admittance matrix";
  parameter Modelica.SIunits.Admittance B23
    "Element [2,3] of admittance matrix";
  parameter Modelica.SIunits.Admittance B24
    "Element [2,4] of admittance matrix";
  parameter Modelica.SIunits.Admittance B33
    "Element [3,3] of admittance matrix";
  parameter Modelica.SIunits.Admittance B34
    "Element [3,4] of admittance matrix";
  parameter Modelica.SIunits.Admittance B44
    "Element [4,4] of admittance matrix";
  final parameter Modelica.SIunits.Admittance B21 = B12
    "Element [2,1] of admittance matrix";
  final parameter Modelica.SIunits.Admittance B31 = B13
    "Element [3,1] of admittance matrix";
  final parameter Modelica.SIunits.Admittance B32 = B23
    "Element [3,2] of admittance matrix";
  final parameter Modelica.SIunits.Admittance B41 = B14
    "Element [4,1] of admittance matrix";
  final parameter Modelica.SIunits.Admittance B42 = B24
    "Element [4,2] of admittance matrix";
  final parameter Modelica.SIunits.Admittance B43 = B34
    "Element [4,3] of admittance matrix";
protected
  function product = Buildings.Electrical.PhaseSystems.OnePhase.product
    "Product between complex quantities";
  Modelica.SIunits.Current Isr[4,2](
    start = zeros(4,Buildings.Electrical.PhaseSystems.OnePhase.n),
    stateSelect = StateSelect.prefer) "Currents that pass through the lines";
  Modelica.SIunits.Current Ish_p[4,2](
    start = zeros(4,Buildings.Electrical.PhaseSystems.OnePhase.n),
    stateSelect = StateSelect.prefer) "Shunt current on side p";
  Modelica.SIunits.Current Ish_n[4,2](
    start = zeros(4,Buildings.Electrical.PhaseSystems.OnePhase.n),
    stateSelect = StateSelect.prefer) "Shunt current on side n";

  Modelica.SIunits.Voltage v1_n[2](
    start = Buildings.Electrical.PhaseSystems.OnePhase.phaseVoltages(V_nominal/sqrt(3), phi= 0),
    stateSelect = StateSelect.never) = terminal_n.phase[1].v
    "Voltage in line 1 at connector N";
  Modelica.SIunits.Voltage v2_n[2](
    start = Buildings.Electrical.PhaseSystems.OnePhase.phaseVoltages(V_nominal/sqrt(3), phi= -2*Modelica.Constants.pi/3),
    stateSelect = StateSelect.never) = terminal_n.phase[2].v
    "Voltage in line 2 at connector N";
  Modelica.SIunits.Voltage v3_n[2](
    start = Buildings.Electrical.PhaseSystems.OnePhase.phaseVoltages(V_nominal/sqrt(3), phi= 2*Modelica.Constants.pi/3),
    stateSelect = StateSelect.never) = terminal_n.phase[3].v
    "Voltage in line 3 at connector N";
  Modelica.SIunits.Voltage v4_n[2](
    start = Buildings.Electrical.PhaseSystems.OnePhase.phaseVoltages(0),
    stateSelect = StateSelect.never) = terminal_n.phase[4].v
    "Voltage in line 4 (neutral) at connector N";
  Modelica.SIunits.Voltage v1_p[2](
    start = Buildings.Electrical.PhaseSystems.OnePhase.phaseVoltages(V_nominal/sqrt(3), phi= 0),
    stateSelect = StateSelect.never) = terminal_p.phase[1].v
    "Voltage in line 1 at connector P";
  Modelica.SIunits.Voltage v2_p[2](
    start = Buildings.Electrical.PhaseSystems.OnePhase.phaseVoltages(V_nominal/sqrt(3), phi= -2*Modelica.Constants.pi/3),
    stateSelect = StateSelect.never) = terminal_p.phase[2].v
    "Voltage in line 2 at connector P";
  Modelica.SIunits.Voltage v3_p[2](
    start = Buildings.Electrical.PhaseSystems.OnePhase.phaseVoltages(V_nominal/sqrt(3), phi= 2*Modelica.Constants.pi/3),
    stateSelect = StateSelect.never) = terminal_p.phase[3].v
    "Voltage in line 3 at connector P";
  Modelica.SIunits.Voltage v4_p[2](
    start = Buildings.Electrical.PhaseSystems.OnePhase.phaseVoltages(0),
    stateSelect = StateSelect.never) = terminal_p.phase[4].v
    "Voltage in line 4 (neutral) at connector P";
equation

  // Link the connectors to propagate the overdetermined variable
  for i in 1:4 loop
      Connections.branch(terminal_p.phase[i].theta, terminal_n.phase[i].theta);
      terminal_p.phase[i].theta = terminal_n.phase[i].theta;
  end for;

  // Kirkoff current law for the terminal n (left side)
  Isr[1,:] = terminal_n.phase[1].i - Ish_n[1,:];
  Isr[2,:] = terminal_n.phase[2].i - Ish_n[2,:];
  Isr[3,:] = terminal_n.phase[3].i - Ish_n[3,:];
  Isr[4,:] = terminal_n.phase[4].i - Ish_n[4,:];

  // Kirkoff current law for the terminal p (right side)
  Isr[1,:] + terminal_p.phase[1].i = Ish_p[1,:];
  Isr[2,:] + terminal_p.phase[2].i = Ish_p[2,:];
  Isr[3,:] + terminal_p.phase[3].i = Ish_p[3,:];
  Isr[4,:] + terminal_p.phase[4].i = Ish_p[4,:];

  // Voltage drop caused by the impedance matrix
  terminal_n.phase[1].v - terminal_p.phase[1].v = product(Z11, terminal_n.phase[1].i)
                                                + product(Z12, terminal_n.phase[2].i)
                                                + product(Z13, terminal_n.phase[3].i)
                                                + product(Z14, terminal_n.phase[4].i);
  terminal_n.phase[2].v - terminal_p.phase[2].v = product(Z21, terminal_n.phase[1].i)
                                                + product(Z22, terminal_n.phase[2].i)
                                                + product(Z23, terminal_n.phase[3].i)
                                                + product(Z24, terminal_n.phase[4].i);
  terminal_n.phase[3].v - terminal_p.phase[3].v = product(Z31, terminal_n.phase[1].i)
                                                + product(Z32, terminal_n.phase[2].i)
                                                + product(Z33, terminal_n.phase[3].i)
                                                + product(Z34, terminal_n.phase[4].i);
  terminal_n.phase[4].v - terminal_p.phase[4].v = product(Z41, terminal_n.phase[1].i)
                                                + product(Z42, terminal_n.phase[2].i)
                                                + product(Z43, terminal_n.phase[3].i)
                                                + product(Z44, terminal_n.phase[4].i);

  // Current loss at the terminal n
  Ish_n[1,:] = product({0, B11/2}, v1_n)
             + product({0, B12/2}, v2_n)
             + product({0, B13/2}, v3_n)
             + product({0, B14/2}, v4_n);
  Ish_n[2,:] = product({0, B21/2}, v1_n)
             + product({0, B22/2}, v2_n)
             + product({0, B23/2}, v3_n)
             + product({0, B24/2}, v4_n);
  Ish_n[3,:] = product({0, B31/2}, v1_n)
             + product({0, B32/2}, v2_n)
             + product({0, B33/2}, v3_n)
             + product({0, B34/2}, v4_n);
  Ish_n[4,:] = product({0, B41/2}, v1_n)
             + product({0, B42/2}, v2_n)
             + product({0, B43/2}, v3_n)
             + product({0, B44/2}, v4_n);

  // Current loss at the terminal n
  Ish_p[1,:] = product({0, B11/2}, v1_p)
             + product({0, B12/2}, v2_p)
             + product({0, B13/2}, v3_p)
             + product({0, B14/2}, v4_p);
  Ish_p[2,:] = product({0, B21/2}, v1_p)
             + product({0, B22/2}, v2_p)
             + product({0, B23/2}, v3_p)
             + product({0, B24/2}, v4_p);
  Ish_p[3,:] = product({0, B31/2}, v1_p)
             + product({0, B32/2}, v2_p)
             + product({0, B33/2}, v3_p)
             + product({0, B34/2}, v4_p);
  Ish_p[4,:] = product({0, B41/2}, v1_p)
             + product({0, B42/2}, v2_p)
             + product({0, B43/2}, v3_p)
             + product({0, B44/2}, v4_p);

  annotation (
  defaultComponentName="line",
 Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                               graphics={
          Line(points={{-92,0},{-72,0}}, color={0,0,0}),
          Line(points={{68,0},{88,0}}, color={0,0,0}),
        Rectangle(
          extent={{-72,40},{70,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
          Text(
            extent={{-140,100},{140,60}},
            lineColor={0,0,0},
          textString="%name"),
          Text(
            extent={{-72,30},{70,10}},
            lineColor={0,0,0},
          textString="R+jX 4x4"),
          Text(
            extent={{-72,-10},{70,-30}},
            lineColor={0,0,0},
          textString="C 4x4")}),
    Documentation(revisions="<html>
<ul>
<li>
January 14, 2015, by Marco Bonvini:<br/>
Created model and documantation.
</li>
</ul>
</html>", info="<html>
<p>
RLC line model (&pi;-model) that connects two AC three phases
unbalanced interfaces and neutral line. This model can be used to represent a
cable in a three phases unbalanced AC system.
</p>

<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Electrical/AC/ThreePhasesUnbalanced/Lines/twoPortRLCMatrix_N.png\"/>
</p>

<p>
The model is parameterized with an impedance matrix <i>Z</i> and
an admittance matrix <i>B</i>.
The impedance matrix is symmetric, and therefore only the upper triangular
part of the matrix needs to be defined.
</p>

<p>
This model is a more detailed version of the model <a href=\"modelica://Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortMatrixRL_N\">
Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortMatrixRL_N</a> that includes
the capacitive effects of the lines.
</p>

<h4>Note</h4>
<p>
The fourth line is the neutral one.
</p>

</html>"));
end TwoPortMatrixRLC_N;