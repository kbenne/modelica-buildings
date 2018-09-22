within Buildings.Occupants.Office.Occupancy;
model Wang2005Occupancy
  "A model to predict Occupancy of a single person office"
  extends Modelica.Blocks.Icons.DiscreteBlock;
  parameter Modelica.SIunits.Time one_mu(displayUnit="min") = 4368 "Mean occupancy duration";
  parameter Modelica.SIunits.Time zero_mu(displayUnit="min") = 2556 "Mean vacancy duration";
  parameter Integer seed = 10 "Seed for the random number generator";

  Modelica.Blocks.Interfaces.BooleanOutput occ
    "The State of occupancy, true for occupied"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

protected
  discrete Real mu;
  discrete Real tNext(start=0);
  discrete Real hold_time(start = 0);
  Real r(min=0, max=1) "Generated random number";
  Integer state[Modelica.Math.Random.Generators.Xorshift1024star.nState];

initial equation
  tNext = 0;
  hold_time = 0;
  occ = true;
  state = Modelica.Math.Random.Generators.Xorshift1024star.initialState(seed, seed);
  r = 0;
  mu = 0;

equation
  when time > pre(tNext) then
    (r, state) = Modelica.Math.Random.Generators.Xorshift1024star.random(pre(state));
    occ = not pre(occ);
    mu = if occ then one_mu else zero_mu;
    hold_time = -mu*Modelica.Math.log(1 - r);
    tNext = time + hold_time;
  end when;

  annotation (graphics={
            Rectangle(extent={{-60,40},{60,-40}}, lineColor={28,108,200}), Text(
            extent={{-40,20},{40,-20}},
            lineColor={28,108,200},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textStyle={TextStyle.Bold},
            textString="Blinds_SI")},
defaultComponentName="occ",
Documentation(info="<html>
<p>
Model predicting the occupancy of a single person office.
</p>
<h4>References</h4>
<p>
The model is documented in the paper &quot;Wang, D., Federspiel, C.C. and
Rubinstein, F., 2005. Modeling occupancy in single person offices. Energy
and buildings, 37(2), pp.121-126.&quot;
</p>
<p>
The model parameters are regressed from a field study in California with 35
single person offices at a large office building from 12/29/1998 to 12/20/1999.
</p>
</html>",
revisions="<html>
<ul>
<li>
August 1, 2018, by Zhe Wang:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(graphics={Text(
          extent={{-98,98},{94,-96}},
          lineColor={28,108,200},
          textString="ob.office
Occupancy")}));
end Wang2005Occupancy;
