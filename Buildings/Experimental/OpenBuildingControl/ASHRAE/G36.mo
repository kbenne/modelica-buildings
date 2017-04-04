within Buildings.Experimental.OpenBuildingControl.ASHRAE;
package G36 "Package with control sequences from ASHRAE Guideline 36"
  extends Modelica.Icons.VariantsPackage;

  package AtomicSequences

    model EconEnableDisable "Economizer enable/disable switch"

      CDL.Interfaces.RealInput TOut(unit="K", displayUnit="degC")
        "Outdoor temperature"
        annotation (Placement(transformation(extent={{-140,134},{-100,174}}),
            iconTransformation(extent={{-140,134},{-100,174}})));
      CDL.Interfaces.BooleanInput uFre(start=false) "Freezestat status"
        annotation (Placement(transformation(extent={{-140,38},{-100,78}}),
            iconTransformation(extent={{-140,38},{-100,78}})));
      CDL.Interfaces.RealInput TSup(unit="K", displayUnit="degC")
        "Supply air temperature"
        annotation (Placement(transformation(extent={{-140,84},{-100,124}}),
            iconTransformation(extent={{-140,84},{-100,124}})));
      CDL.Interfaces.RealOutput yEcoDamPosMax(min=0, max=1)
        "Output sets maximum allowable economizer damper position. Fixme: Should this remain as type real? Output can take two values: disable = yEcoDamPosMin and enable = yEcoDamPosMax."
        annotation (Placement(transformation(extent={{100,44},{138,82}}),
            iconTransformation(extent={{100,44},{138,82}})));
      CDL.Interfaces.RealInput uEcoDamPosMin
        "Minimal economizer damper position, output from a separate sequence."
        annotation (Placement(transformation(extent={{-140,-6},{-100,34}}),
            iconTransformation(extent={{-140,-6},{-100,34}})));
      CDL.Interfaces.RealInput uEcoDamPosMax
        "Maximum economizer damper position, either 100% or set to a constant value <100% at commisioning."
        annotation (Placement(transformation(extent={{-140,-54},{-100,-14}}),
            iconTransformation(extent={{-140,-54},{-100,-14}})));
      CDL.Logical.Switch assignDamperPosition
        "If control loop signal = 1 opens the damper to it's max position; if signal = 0 closes the damper to it's min position."
        annotation (Placement(transformation(extent={{76,-70},{96,-50}})));
      CDL.Logical.Or or1
        "If any of the conditions evaluated is 1, the block returns 1 and it's inverse in the following block closes the damper to uEcoDamPosMin. If all conditions are 0, the damper can be opened up to uEcoDamPosMax"
        annotation (Placement(transformation(extent={{10,-20},{30,0}})));
      CDL.Logical.Hysteresis hysTOut(final uLow = 297 - 1, uHigh = 297)
        "Close damper when TOut is above the uHigh, open it again only when TOut falls down to uLow"
        annotation (Placement(transformation(extent={{-70,150},{-50,170}})));
      //fixme: units for instantiated limits, example TOut limit is 75K, delta = 1K
      CDL.Logical.Or or2
        "fixme: should we have an or block that allows multiple inputs?"
        annotation (Placement(transformation(extent={{10,8},{30,28}})));
      CDL.Logical.Not not1
        annotation (Placement(transformation(extent={{40,-20},{60,0}})));
      CDL.Logical.LessThreshold TSupThreshold(threshold=276.483)
        "fixme: timer still not implemented, threshold value provided in K, units not indicated"
        annotation (Placement(transformation(extent={{-78,88},{-58,108}})));
    equation
      connect(assignDamperPosition.u1, uEcoDamPosMin) annotation (Line(points={{74,-52},
              {-18,-52},{-18,14},{-120,14}},           color={0,0,127}));
      connect(assignDamperPosition.u3, uEcoDamPosMax) annotation (Line(points={{74,-68},
              {22,-68},{22,-66},{-30,-66},{-30,-34},{-120,-34}},
                                                       color={0,0,127}));
      connect(assignDamperPosition.y, yEcoDamPosMax) annotation (Line(points={{97,
              -60},{104,-60},{104,63},{119,63}}, color={0,0,127}));
      connect(or1.u2, uFre) annotation (Line(points={{8,-18},{-10,-18},{-10,58},{-120,
              58}},color={255,0,255}));
      connect(TOut, hysTOut.u)
        annotation (Line(points={{-120,154},{-96,154},{-96,160},{-72,160}},
                                                        color={0,0,127}));
      connect(or1.y, not1.u)
        annotation (Line(points={{31,-10},{38,-10}}, color={255,0,255}));
      connect(not1.y, assignDamperPosition.u2) annotation (Line(points={{61,-10},{68,
              -10},{68,-60},{74,-60}}, color={255,0,255}));
      connect(or2.y, or1.u1) annotation (Line(points={{31,18},{42,18},{42,34},{-6,
              34},{-6,4},{2,4},{2,-10},{8,-10}},
                     color={255,0,255}));
      connect(TSupThreshold.y, or2.u2) annotation (Line(points={{-57,98},{-26,98},
              {-26,10},{8,10}}, color={255,0,255}));
      connect(TSup, TSupThreshold.u) annotation (Line(points={{-120,104},{-100,
              104},{-100,98},{-80,98}}, color={0,0,127}));
      connect(hysTOut.y, or2.u1) annotation (Line(points={{-49,160},{-22,160},{-22,18},
              {8,18}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,200}},
            initialScale=0.1),                                      graphics={
            Rectangle(
            extent={{-100,-38},{100,162}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
                              Line(
              points={{2,116},{82,116}},
              color={28,108,200},
              thickness=0.5),
            Text(
              extent={{-94,32},{-24,-4}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="uEcoDamPosMin"),
            Text(
              extent={{-96,-12},{-26,-48}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="uEcoDamPosMax"),
            Text(
              extent={{26,114},{96,78}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="yEcoDamPos"),
            Text(
              extent={{-96,166},{-26,130}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="TOut"),
            Text(
              extent={{-96,124},{-26,88}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="TSup"),
            Text(
              extent={{-96,78},{-26,42}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="uFre"),
              Line(
              points={{-78,-4},{2,-4},{2,116}},
              color={28,108,200},
              thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,200}},
            initialScale=0.1)),
                 Documentation(info="<html>      
             <p>
             implementation fixme: timers for TSup, AND for 10 min delay
             </p>   
  <p>
  Fixme: There might be a need to convert this block in a generic enable-disable
  control block that receives one or more hysteresis conditions, one or more 
  timed conditions, and one or more additional boolean signal conditions. For 
  now, the block is implemented as economizer enable-disable control block, an
  atomic sequence implemented in the economizer control composite sequence.
  </p>
  <p>
  The economizer enable-disable sequence implements conditions from 
  ASHRAE guidline 36 (G36) as listed on the state machine diagram below. The 
  sequence output is binary, it either sets the economizer damper position to
  its high (yEcoDamPosMax) or to its low limit (yEcoDamPosMin).
  </p>

<p>
Fixme: Edit conditions based on any additional stakeholder input, e.g. include
space averaged MAT sensor output.
</p>
<p>
Fixme - Implementation issues: Delay placement; Excluding hysteresis by simply 
setting the delta parameter to 0. Delay seems to replace hysteresis in practice, 
at least based on our current project partners input.
</p>

<p align=\"center\">
<img alt=\"Image of set point reset\"
src=\"modelica://Buildings/Resources/Images/Experimental/OpenBuildingControl/ASHRAE/G36/EconHighLimitLockout.png\"/>
</p>
</html>"));
    end EconEnableDisable;

    block VAVSingleZoneTSupSet "Supply air set point for single zone VAV system"

      parameter Modelica.SIunits.Temperature TMax
        "Maximum supply air temperature for heating"
        annotation (Dialog(group="Temperatures"));

      parameter Modelica.SIunits.Temperature TMin
        "Minimum supply air temperature for cooling"
        annotation (Dialog(group="Temperatures"));

      parameter Real yHeaMax(min=0, max=1, unit="1")
        "Maximum fan speed for heating"
        annotation (Dialog(group="Speed"));

      parameter Real yMin(min=0, max=1, unit="1")
        "Minimum fan speed"
        annotation (Dialog(group="Speed"));

      parameter Real yCooMax(min=0, max=1, unit="1") = 1
        "Maximum fan speed for cooling"
        annotation (Dialog(group="Speed"));

      CDL.Interfaces.RealInput uHea(min=0, max=1)
        "Heating control signal"
        annotation (Placement(transformation(extent={{-140,60},{-100,100}})));

      CDL.Interfaces.RealInput uCoo(min=0, max=1)
        "Cooling control signal"
        annotation (Placement(transformation(extent={{-140,20},{-100,60}})));

      CDL.Interfaces.RealInput TSetZon(unit="K", displayUnit="degC")
        "Average of heating and cooling setpoints for zone temperature"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

      CDL.Interfaces.RealInput TZon(unit="K", displayUnit="degC")
        "Zone temperature"
        annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));

      CDL.Interfaces.RealInput TOut(unit="K", displayUnit="degC")
        "Outdoor air temperature"
        annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));

      CDL.Interfaces.RealOutput THea(unit="K", displayUnit="degC")
        "Heating supply air temperature setpoint"
        annotation (Placement(transformation(extent={{100,50},{120,70}})));

      CDL.Interfaces.RealOutput TCoo(unit="K", displayUnit="degC")
        "Cooling supply air temperature setpoint"
        annotation (Placement(transformation(extent={{100,-10},{120,10}}),
            iconTransformation(extent={{100,-10},{120,10}})));

      CDL.Interfaces.RealOutput y(min=0, max=1, unit="1") "Fan speed"
      annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

    protected
      CDL.Continuous.Line TSetCooHig
        "Table to compute the setpoint for cooling for uCoo = 0...1"
        annotation (Placement(transformation(extent={{0,100},{20,120}})));
      CDL.Continuous.Line offSetTSetHea
        "Table to compute the setpoint offset for heating for uCoo = 0...1"
        annotation (Placement(transformation(extent={{0,140},{20,160}})));
      CDL.Continuous.Add addTHe "Adder for heating setpoint calculation"
        annotation (Placement(transformation(extent={{60,160},{80,180}})));
      CDL.Continuous.Line offSetTSetCoo
        "Table to compute the setpoint offset for cooling for uHea = 0...1"
        annotation (Placement(transformation(extent={{0,60},{20,80}})));
      CDL.Continuous.Add addTCoo "Adder for cooling setpoint calculation"
        annotation (Placement(transformation(extent={{60,80},{80,100}})));

      CDL.Continuous.Add dT(final k2=-1) "Difference zone minus outdoor temperature"
        annotation (Placement(transformation(extent={{-80,-200},{-60,-180}})));
      CDL.Continuous.AddParameter yMed(
        p=yCooMax - (yMin - yCooMax)/(0.56 - 5.6)*5.6,
        k=(yMin - yCooMax)/(0.56 - 5.6)) "Fan speed at medium cooling load"
        annotation (Placement(transformation(extent={{-40,-200},{-20,-180}})));
      Controls.SetPoints.Table yHea(final table=[0.5,yMin; 1,yHeaMax])
        "Fan speed for heating"
        annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      CDL.Logical.LessEqualThreshold yMinChe1(final threshold=0.25)
        "Check for cooling signal for fan speed"
        annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
      CDL.Logical.Switch switch1
        annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
      CDL.Logical.LessEqualThreshold yMinChe2(final threshold=0.5)
        "Check for cooling signal for fan speed"
        annotation (Placement(transformation(extent={{-80,-130},{-60,-110}})));
      CDL.Logical.Switch switch2
        annotation (Placement(transformation(extent={{20,-130},{40,-110}})));
      CDL.Logical.LessEqualThreshold yMinChe3(threshold=0.75)
        "Check for cooling signal for fan speed"
        annotation (Placement(transformation(extent={{-80,-160},{-60,-140}})));
      CDL.Logical.Switch switch3
        annotation (Placement(transformation(extent={{-20,-160},{0,-140}})));
      CDL.Continuous.Add add(final k1=-1)
        annotation (Placement(transformation(extent={{0,-240},{20,-220}})));
      CDL.Continuous.Add add1
        annotation (Placement(transformation(extent={{40,-270},{60,-250}})));
      CDL.Continuous.Gain gain(final k=4)
        annotation (Placement(transformation(extent={{-80,-256},{-60,-236}})));
      CDL.Continuous.AddParameter yMed1(
        final p=2*yMin,
        final k=-yMin)
        "Fan speed at medium cooling load"
        annotation (Placement(transformation(extent={{-20,-290},{0,-270}})));
      CDL.Continuous.Gain gain1(final k=4)
        annotation (Placement(transformation(extent={{-80,-356},{-60,-336}})));
      CDL.Continuous.Product product
        annotation (Placement(transformation(extent={{-40,-250},{-20,-230}})));
      CDL.Continuous.AddParameter yMed2(
        final p=-3*yCooMax,
        final k=4*yCooMax)
        "Fan speed at medium cooling load"
        annotation (Placement(transformation(extent={{-20,-390},{0,-370}})));
      CDL.Continuous.Product product1
        annotation (Placement(transformation(extent={{-40,-350},{-20,-330}})));
      CDL.Continuous.Add add2(
        final k1=4,
        final k2=-1)
        annotation (Placement(transformation(extent={{0,-340},{20,-320}})));
      CDL.Continuous.Add add3
        annotation (Placement(transformation(extent={{40,-370},{60,-350}})));
      CDL.Continuous.Limiter yMedLim(
        final uMax=yCooMax,
        final uMin=yMin) "Limiter for yMed"
        annotation (Placement(transformation(extent={{-10,-200},{10,-180}})));
      CDL.Continuous.Limiter TDea(uMax=24 + 273.15, uMin=21 + 273.15)
        "Limiter that outputs the dead band value for the supply air temperature"
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      CDL.Continuous.Line TSetHeaHig
        "Block to compute the setpoint for heating for uHea = 0...1"
        annotation (Placement(transformation(extent={{2,180},{22,200}})));
      CDL.Continuous.Constant con0(final k=0) "Contant that outputs zero"
        annotation (Placement(transformation(extent={{-80,180},{-60,200}})));
      CDL.Continuous.Constant con25(final k=0.25) "Contant that outputs 0.25"
        annotation (Placement(transformation(extent={{-80,150},{-60,170}})));
      CDL.Continuous.Constant con05(final k=0.5) "Contant that outputs 0.5"
        annotation (Placement(transformation(extent={{-80,110},{-60,130}})));
      CDL.Continuous.Constant con75(final k=0.75) "Contant that outputs 0.75"
        annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
      CDL.Continuous.Constant conTMax(final k=TMax) "Constant that outputs TMax"
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      CDL.Continuous.Constant conTMin(final k=TMin) "Constant that outputs TMin"
        annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
      CDL.Continuous.Add TDeaTMin(final k2=-1) "Outputs TDea-TMin"
        annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));

      CDL.Continuous.AddParameter addTDea(
        final p=-1.1,
        final k=-1)
        "Adds constant offset"
        annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
      CDL.Continuous.Add TMaxTDea(
        final k2=-1) "Outputs TMax-TDea"
        annotation (Placement(transformation(extent={{-20,10},{0,30}})));
    equation
      connect(offSetTSetHea.u, uCoo) annotation (Line(points={{-2,150},{-2,150},{
              -32,150},{-32,52},{-94,52},{-94,40},{-120,40}},
                                         color={0,0,127}));
      connect(offSetTSetHea.y, addTHe.u2) annotation (Line(points={{21,150},{21,150},
              {40,150},{40,164},{58,164}},
                                    color={0,0,127}));
      connect(addTHe.y, THea)
        annotation (Line(points={{81,170},{92,170},{92,60},{110,60}},
                                                    color={0,0,127}));
      connect(TSetCooHig.y, addTCoo.u1) annotation (Line(points={{21,110},{40,110},
              {40,96},{58,96}},
                              color={0,0,127}));
      connect(offSetTSetCoo.y, addTCoo.u2) annotation (Line(points={{21,70},{40,70},
              {40,84},{58,84}},   color={0,0,127}));
      connect(TSetCooHig.u, uCoo) annotation (Line(points={{-2,110},{-2,110},{-22,110},
              {-32,110},{-32,52},{-94,52},{-94,40},{-120,40}},
                                          color={0,0,127}));
      connect(offSetTSetCoo.u, uHea) annotation (Line(points={{-2,70},{-2,70},{-20,
              70},{-60,70},{-90,70},{-90,80},{-120,80}},
                                        color={0,0,127}));
      connect(addTCoo.y, TCoo)
        annotation (Line(points={{81,90},{81,90},{84,90},{84,0},{110,0}},
                                                                color={0,0,127}));
      connect(dT.u1, TZon) annotation (Line(points={{-82,-184},{-86,-184},{-86,-40},
              {-120,-40}},
                     color={0,0,127}));
      connect(dT.u2, TOut) annotation (Line(points={{-82,-196},{-90,-196},{-90,-80},
              {-120,-80}},
                     color={0,0,127}));
      connect(dT.y, yMed.u)
        annotation (Line(points={{-59,-190},{-59,-190},{-42,-190}},
                                                                 color={0,0,127}));
      connect(yMinChe1.u, uCoo) annotation (Line(points={{-82,-90},{-82,-90},{-94,-90},
              {-94,40},{-120,40}},       color={0,0,127}));
      connect(switch1.u2, yMinChe1.y) annotation (Line(points={{58,-90},{-40,-90},{-59,
              -90}},       color={255,0,255}));
      connect(switch2.y, switch1.u3) annotation (Line(points={{41,-120},{50,-120},{50,
              -98},{58,-98}},   color={0,0,127}));
      connect(yMinChe2.u, uCoo) annotation (Line(points={{-82,-120},{-94,-120},{-94,
              40},{-120,40}}, color={0,0,127}));
      connect(yMinChe3.u, uCoo) annotation (Line(points={{-82,-150},{-94,-150},{-94,
              40},{-120,40}}, color={0,0,127}));
      connect(switch3.y, switch2.u3) annotation (Line(points={{1,-150},{10,-150},{10,
              -128},{18,-128}}, color={0,0,127}));
      connect(yMinChe2.y, switch2.u2) annotation (Line(points={{-59,-120},{-59,-120},
              {18,-120}}, color={255,0,255}));
      connect(yMinChe3.y, switch3.u2) annotation (Line(points={{-59,-150},{-40,-150},
              {-22,-150}}, color={255,0,255}));
      connect(yMedLim.y, add.u1) annotation (Line(points={{11,-190},{20,-190},{20,-208},
              {-50,-208},{-50,-224},{-2,-224}}, color={0,0,127}));
      connect(gain.u, uCoo) annotation (Line(points={{-82,-246},{-94,-246},{-94,40},
              {-120,40}}, color={0,0,127}));
      connect(gain.y, yMed1.u) annotation (Line(points={{-59,-246},{-58,-246},{-54,-246},
              {-54,-280},{-22,-280}}, color={0,0,127}));
      connect(add.y, add1.u1) annotation (Line(points={{21,-230},{32,-230},{32,-254},
              {38,-254}}, color={0,0,127}));
      connect(yMed1.y, add1.u2) annotation (Line(points={{1,-280},{10,-280},{10,-266},
              {38,-266}}, color={0,0,127}));
      connect(add1.y, switch2.u1) annotation (Line(points={{61,-260},{72,-260},{72,-134},
              {8,-134},{8,-112},{18,-112}}, color={0,0,127}));
      connect(gain1.u, uCoo) annotation (Line(points={{-82,-346},{-94,-346},{-94,40},
              {-120,40}}, color={0,0,127}));
      connect(product.u1, yMedLim.y) annotation (Line(points={{-42,-234},{-50,-234},
              {-50,-208},{20,-208},{20,-190},{11,-190}},
                                                     color={0,0,127}));
      connect(product.y, add.u2) annotation (Line(points={{-19,-240},{-12,-240},{-12,
              -236},{-2,-236}}, color={0,0,127}));
      connect(product.u2, gain.y)
        annotation (Line(points={{-42,-246},{-59,-246}}, color={0,0,127}));
      connect(yMedLim.y, add2.u1) annotation (Line(points={{11,-190},{20,-190},{20,-208},
              {-50,-208},{-50,-324},{-2,-324}}, color={0,0,127}));
      connect(product1.y, add2.u2) annotation (Line(points={{-19,-340},{-14,-340},{-14,
              -336},{-2,-336}}, color={0,0,127}));
      connect(add2.y, add3.u1) annotation (Line(points={{21,-330},{24,-330},{24,-354},
              {38,-354}}, color={0,0,127}));
      connect(yMed2.y, add3.u2) annotation (Line(points={{1,-380},{22,-380},{22,-366},
              {38,-366}}, color={0,0,127}));
      connect(product1.u2, gain1.y) annotation (Line(points={{-42,-346},{-59,-346}},
                          color={0,0,127}));
      connect(product1.u1, yMedLim.y) annotation (Line(points={{-42,-334},{-50,-334},
              {-50,-218},{-50,-208},{20,-208},{20,-190},{11,-190}},        color={0,
              0,127}));
      connect(yMed2.u, uCoo) annotation (Line(points={{-22,-380},{-54,-380},{-94,-380},
              {-94,40},{-120,40}}, color={0,0,127}));
      connect(add3.y, switch3.u3) annotation (Line(points={{61,-360},{76,-360},{76,-168},
              {-34,-168},{-34,-158},{-22,-158}}, color={0,0,127}));
      connect(yHea.y, switch1.u1) annotation (Line(points={{1,-70},{18,-70},{40,-70},
              {40,-82},{58,-82}}, color={0,0,127}));
      connect(switch1.y, y) annotation (Line(points={{81,-90},{90,-90},{90,-60},{110,
              -60}}, color={0,0,127}));
      connect(yMedLim.y, switch3.u1) annotation (Line(points={{11,-190},{20,-190},{
              20,-170},{-40,-170},{-40,-142},{-22,-142}},
                                                       color={0,0,127}));
      connect(yMedLim.u, yMed.y)
        annotation (Line(points={{-12,-190},{-19,-190}}, color={0,0,127}));
      connect(TDea.u, TSetZon)
        annotation (Line(points={{-82,0},{-82,0},{-120,0}},  color={0,0,127}));
      connect(con0.y, TSetHeaHig.x1) annotation (Line(points={{-59,190},{-52,190},{
              -52,198},{0,198}},
                             color={0,0,127}));
      connect(TDea.y, TSetHeaHig.f1) annotation (Line(points={{-59,0},{-52,0},{-52,
              194},{0,194}},
                        color={0,0,127}));
      connect(con05.y, TSetHeaHig.x2) annotation (Line(points={{-59,120},{-46,120},
              {-46,186},{0,186}},color={0,0,127}));
      connect(conTMax.y, TSetHeaHig.f2) annotation (Line(points={{-59,30},{-40,30},
              {-40,182},{0,182}},color={0,0,127}));
      connect(uHea, TSetHeaHig.u) annotation (Line(points={{-120,80},{-90,80},{-90,70},
              {-36,70},{-36,190},{0,190}}, color={0,0,127}));
      connect(TSetHeaHig.y, addTHe.u1) annotation (Line(points={{23,190},{40,190},{
              40,176},{58,176}},
                            color={0,0,127}));
      connect(con0.y, offSetTSetHea.x1) annotation (Line(points={{-59,190},{-56,190},
              {-56,158},{-2,158}}, color={0,0,127}));
      connect(con25.y, offSetTSetHea.x2) annotation (Line(points={{-59,160},{-54,
              160},{-54,146},{-2,146}},
                                   color={0,0,127}));
      connect(con0.y, offSetTSetHea.f1) annotation (Line(points={{-59,190},{-56,190},
              {-56,154},{-2,154}}, color={0,0,127}));
      connect(yHea.u, uHea) annotation (Line(points={{-22,-70},{-90,-70},{-90,80},{-120,
              80}}, color={0,0,127}));
      connect(TDea.y, TDeaTMin.u1) annotation (Line(points={{-59,0},{-40,0},{-40,-14},
              {-22,-14}}, color={0,0,127}));
      connect(conTMin.y, TDeaTMin.u2) annotation (Line(points={{-59,-30},{-50,-30},{
              -50,-26},{-22,-26}}, color={0,0,127}));
      connect(TDeaTMin.y, addTDea.u)
        annotation (Line(points={{1,-20},{-2,-20},{8,-20}}, color={0,0,127}));
      connect(addTDea.y, offSetTSetHea.f2) annotation (Line(points={{31,-20},{34,
              -20},{34,40},{-14,40},{-14,142},{-2,142}},
                                                    color={0,0,127}));
      connect(TSetCooHig.x1, con05.y) annotation (Line(points={{-2,118},{-24,118},{
              -46,118},{-46,120},{-59,120}},
                                         color={0,0,127}));
      connect(TSetCooHig.f1, TDea.y) annotation (Line(points={{-2,114},{-10,114},{
              -52,114},{-52,0},{-59,0}},
                                     color={0,0,127}));
      connect(TSetCooHig.x2, con75.y) annotation (Line(points={{-2,106},{-8,106},{
              -44,106},{-44,90},{-59,90}},
                                       color={0,0,127}));
      connect(TSetCooHig.f2, conTMin.y) annotation (Line(points={{-2,102},{-2,114},
              {-50,114},{-50,-30},{-59,-30}},color={0,0,127}));
      connect(offSetTSetCoo.f1, con0.y) annotation (Line(points={{-2,74},{-56,74},{
              -56,190},{-59,190}},
                               color={0,0,127}));
      connect(offSetTSetCoo.x1, con0.y) annotation (Line(points={{-2,78},{-56,78},{
              -56,70},{-56,190},{-59,190}},
                                        color={0,0,127}));
      connect(offSetTSetCoo.x2, con05.y) annotation (Line(points={{-2,66},{-10,66},
              {-46,66},{-46,120},{-59,120}},color={0,0,127}));
      connect(TMaxTDea.u1, conTMax.y) annotation (Line(points={{-22,26},{-40,26},{-40,
              30},{-59,30}}, color={0,0,127}));
      connect(TDea.y, TMaxTDea.u2) annotation (Line(points={{-59,0},{-40,0},{-40,14},
              {-22,14}}, color={0,0,127}));
      connect(TMaxTDea.y, offSetTSetCoo.f2) annotation (Line(points={{1,20},{10,20},
              {10,50},{-10,50},{-10,62},{-2,62}}, color={0,0,127}));
      annotation (
      defaultComponentName = "setPoiVAV",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),                                        graphics={
            Rectangle(
            extent={{-100,-100},{100,100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255}),
        Polygon(
          points={{80,-76},{58,-70},{58,-82},{80,-76}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(points={{8,-76},{78,-76}},   color={95,95,95}),
        Line(points={{-54,-22},{-54,-62}},color={95,95,95}),
        Polygon(
          points={{-54,0},{-60,-22},{-48,-22},{-54,0}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-88,-6},{-47,-26}},
          lineColor={0,0,0},
              textString="T"),
        Text(
          extent={{64,-82},{88,-93}},
          lineColor={0,0,0},
              textString="u"),
            Line(
              points={{-44,-6},{-30,-6},{-14,-42},{26,-42},{38,-62},{60,-62}},
              color={0,0,255},
              thickness=0.5),
            Line(
              points={{-44,-6},{-30,-6},{-14,-42},{2,-42},{18,-66},{60,-66}},
              color={255,0,0},
              pattern=LinePattern.Dot,
              thickness=0.5),
        Line(points={{-4,-76},{-60,-76}}, color={95,95,95}),
        Polygon(
          points={{-64,-76},{-42,-70},{-42,-82},{-64,-76}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
            Text(
              extent={{-98,90},{-72,68}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="uHea"),
            Text(
              extent={{-96,50},{-70,28}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="uCoo"),
            Text(
              extent={{68,72},{94,50}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="THea"),
            Text(
              extent={{68,12},{94,-10}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="TCoo"),
            Text(
              extent={{74,-50},{100,-72}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="y"),
            Text(
              extent={{-96,-30},{-70,-52}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="TZon"),
            Text(
              extent={{-98,-68},{-72,-90}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="TOut"),
        Line(points={{-54,50},{-54,10}},  color={95,95,95}),
        Polygon(
          points={{-54,72},{-60,50},{-48,50},{-54,72}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-88,68},{-47,48}},
          lineColor={0,0,0},
              textString="y"),
            Line(points={{-46,44},{-28,20},{18,20},{28,36},{38,36},{50,54}}, color={
                  0,0,0}),
            Line(points={{18,20},{38,20},{50,54},{28,54},{18,20}}, color={0,0,0}),
            Text(
              extent={{-96,12},{-70,-10}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="TSetZon")}),
            Diagram(
            coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-420},{100,220}}), graphics={
            Rectangle(
              extent={{-88,-314},{70,-400}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-88,-214},{70,-300}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{32,-304},{68,-286}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="0.25 < y < 0.5"),
            Text(
              extent={{32,-404},{68,-386}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="0.75 < y < 1"),
            Rectangle(
              extent={{-88,-172},{70,-210}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{30,-212},{66,-194}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="0.5 < y < 0.75")}),
        Documentation(info="<html>
<p>
Block that outputs the set points for the supply air temperature for heating and cooling
and the fan speed for a single zone VAV system.
</p>
<p>
For the temperature set points, the
parameters are the maximum supply air temperature <code>TMax</code>,
and the minimum supply air temperature for cooling <code>TMin</code>.
The deadband temperature is equal to the
average set point for the zone temperature
for heating and cooling, as obtained from the input <code>TSetZon</code>,
constraint to be within <i>21</i>&deg;C (&asymp;<i>70</i> F) and
<i>24</i>&deg;C (&asymp;<i>75</i> F).
The setpoints are computed as shown in the figure below.
Note that the setpoint for the supply air temperature for heating is
lower than <code>TMin</code>, as shown in the figure.
</p>
<p>
For the fan speed set point, the
parameters are the maximu fan speed at heating <code>yHeaMax</code>,
the minimum fan speed <code>yMin</code> and
the maximum fan speed for cooling <code>yCooMax</code>.
For a cooling control signal of <code>yCoo &gt; 0.25</code>,
the speed is faster increased the larger the difference is between
the zone temperature minus outdoor temperature <code>TZon-TOut</code>.
The figure below shows the sequence.
</p>
<p align=\"center\">
<img alt=\"Image of set point reset\"
src=\"modelica://Buildings/Resources/Images/Experimental/OpenBuildingControl/ASHRAE/G36/VAVSingleZoneTSupSet.png\"/>
</p>
<p>
Note that the inputs <code>uHea</code> and <code>uCoo</code> must be computed
based on the same temperature sensors and control loops.
</p>
</html>",     revisions="<html>
<ul>
<li>
January 10, 2017, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end VAVSingleZoneTSupSet;

    package Validation "Package with validation models"
      extends Modelica.Icons.ExamplesPackage;

      model VAVSingleZoneTSupSet_T
        "Validation model for outdoor minus room air temperature"
        extends Modelica.Icons.Example;

        AtomicSequences.VAVSingleZoneTSupSet setPoiVAV(
          yHeaMax=0.7,
          yMin=0.3,
          TMax=303.15,
          TMin=289.15,
          yCooMax=0.9)
          "Block that computes the setpoints for temperature and fan speed"
          annotation (Placement(transformation(extent={{0,-10},{20,10}})));

        CDL.Continuous.Constant uHea(k=0) "Heating control signal"
          annotation (Placement(transformation(extent={{-80,70},{-60,90}})));

        CDL.Continuous.Constant uCoo(k=0.6) "Cooling control signal"
          annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

        Modelica.Blocks.Sources.Ramp TOut(
          duration=1,
          height=18,
          offset=273.15 + 10) "Outdoor air temperature"
          annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));

        CDL.Continuous.Constant TZon(k=273.15 + 22) "Zone temperature"
          annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
        CDL.Continuous.Add dT(k2=-1) "Difference zone minus outdoor temperature"
          annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
        CDL.Continuous.Constant TSetZon(k=273.15 + 22) "Average zone set point"
          annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
      equation
        connect(uCoo.y, setPoiVAV.uCoo) annotation (Line(points={{-59,50},{-31.5,50},
                {-31.5,4},{-2,4}},color={0,0,127}));
        connect(TZon.y, setPoiVAV.TZon) annotation (Line(points={{-59,-10},{-32,-10},{
                -32,-4},{-2,-4}}, color={0,0,127}));
        connect(TOut.y, setPoiVAV.TOut) annotation (Line(points={{-59,-50},{-28,-50},{
                -28,-8},{-2,-8}}, color={0,0,127}));
        connect(uHea.y, setPoiVAV.uHea) annotation (Line(points={{-59,80},{-59,80},{
                -20,80},{-20,8},{-2,8}},
                                     color={0,0,127}));
        connect(dT.u1, TZon.y) annotation (Line(points={{-2,-34},{-32,-34},{-32,-10},{
                -59,-10}}, color={0,0,127}));
        connect(dT.u2, TOut.y) annotation (Line(points={{-2,-46},{-28,-46},{-28,-50},{
                -59,-50}}, color={0,0,127}));
        connect(TSetZon.y, setPoiVAV.TSetZon) annotation (Line(points={{-59,20},{-40,
                20},{-40,0},{-2,0}}, color={0,0,127}));
        annotation (
        experiment(StopTime=1.0),
        __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Experimental/OpenBuildingControl/ASHRAE/G36/Validation/VAVSingleZoneTSupSet_T.mos"
              "Simulate and plot"),
          Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Experimental.OpenBuildingControl.ASHRAE.G36.VAVSingleZoneTSupSet\">
Buildings.Experimental.OpenBuildingControl.ASHRAE.G36.VAVSingleZoneTSupSet</a>
for a change in temperature difference between zone air and outdoor air.
Hence, this model validates whether the adjustment of the fan speed for medium
cooling load is correct implemented.
</p>
</html>",       revisions="<html>
<ul>
<li>
January 10, 2017, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
      end VAVSingleZoneTSupSet_T;

      model VAVSingleZoneTSupSet_u "Validation model for control input"
        extends Modelica.Icons.Example;

        AtomicSequences.VAVSingleZoneTSupSet setPoiVAV(
          yHeaMax=0.7,
          yMin=0.3,
          TMax=303.15,
          TMin=289.15)
          "Block that computes the setpoints for temperature and fan speed"
          annotation (Placement(transformation(extent={{0,-10},{20,10}})));

        CDL.Continuous.Constant TZon(k=273.15 + 23) "Zone air temperature"
          annotation (Placement(transformation(extent={{-80,-22},{-60,0}})));

        CDL.Continuous.Constant TOut(k=273.15 + 21) "Outdoor temperature"
          annotation (Placement(transformation(extent={{-80,-62},{-60,-40}})));

        Modelica.Blocks.Sources.Ramp uHea(
          duration=0.25,
          height=-1,
          offset=1) "Heating control signal"
          annotation (Placement(transformation(extent={{-80,70},{-60,90}})));

        Modelica.Blocks.Sources.Ramp uCoo(duration=0.25, startTime=0.75)
          "Cooling control signal"
          annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

        CDL.Continuous.Constant TSetZon(k=273.15 + 22) "Average zone set point"
          annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
      equation
        connect(TZon.y, setPoiVAV.TZon) annotation (Line(points={{-59,-11},{-31.5,-11},
                {-31.5,-4},{-2,-4}}, color={0,0,127}));
        connect(TOut.y, setPoiVAV.TOut) annotation (Line(points={{-59,-51},{-24,-51},{
                -24,-8},{-2,-8}}, color={0,0,127}));
        connect(uHea.y, setPoiVAV.uHea) annotation (Line(points={{-59,80},{-12,80},{
                -12,8},{-2,8}},
                            color={0,0,127}));
        connect(uCoo.y, setPoiVAV.uCoo) annotation (Line(points={{-59,50},{-59,50},{
                -16,50},{-16,4},{-2,4}},
                                     color={0,0,127}));
        connect(TSetZon.y, setPoiVAV.TSetZon) annotation (Line(points={{-59,20},{-20,
                20},{-20,0},{-2,0}}, color={0,0,127}));
        annotation (
        experiment(StopTime=1.0),
        __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Experimental/OpenBuildingControl/ASHRAE/G36/Validation/VAVSingleZoneTSupSet_u.mos"
              "Simulate and plot"),
          Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Experimental.OpenBuildingControl.ASHRAE.G36.VAVSingleZoneTSupSet\">
Buildings.Experimental.OpenBuildingControl.ASHRAE.G36.VAVSingleZoneTSupSet</a>
for different control signals.
</p>
</html>",       revisions="<html>
<ul>
<li>
January 10, 2017, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
      end VAVSingleZoneTSupSet_u;

      model EconEnableDisable_TOut
        "Validation model for econ high limit lockout based on the 
  outdoor air temperature_fixm   e"
        extends Modelica.Icons.Example;

        EconEnableDisable econEnableDisable
          annotation (Placement(transformation(extent={{-20,-6},{0,24}})));
        CDL.Logical.Constant FreezestatStatus(k=false)
          "Keep freezestat alarm off for this validation test"
          annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
        CDL.Continuous.Constant EcoDamPosMax(k=0.9)
          "Maximal allowed economizer damper position"
          annotation (Placement(transformation(extent={{-80,-52},{-60,-32}})));
        CDL.Continuous.Constant EcoDamPosMin(k=0.1)
          "Minimum allowed economizer damper position"
          annotation (Placement(transformation(extent={{-80,-86},{-60,-66}})));
        CDL.Interfaces.RealOutput yEcoDamPosMax
          annotation (Placement(transformation(extent={{38,0},{58,20}})));
        CDL.Continuous.Constant TSup(k=277.594)
          "Set TSup to a constant value above 38F"
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Blocks.Sources.Ramp TOut(
          duration=1200,
          height=10,
          offset=293.15)      "Outdoor air temperature"
          annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      equation
        connect(FreezestatStatus.y, econEnableDisable.uFre) annotation (Line(
              points={{-59,-10},{-40,-10},{-40,9.8},{-22,9.8}}, color={255,0,255}));
        connect(EcoDamPosMax.y, econEnableDisable.uEcoDamPosMin) annotation (Line(
              points={{-59,-42},{-36,-42},{-36,5.4},{-22,5.4}}, color={0,0,127}));
        connect(EcoDamPosMin.y, econEnableDisable.uEcoDamPosMax) annotation (Line(
              points={{-59,-76},{-32,-76},{-32,0.6},{-22,0.6}}, color={0,0,127}));
        connect(econEnableDisable.yEcoDamPosMax, yEcoDamPosMax) annotation (Line(
              points={{1.9,10.3},{26.95,10.3},{26.95,10},{48,10}}, color={0,0,127}));
        connect(TSup.y, econEnableDisable.TSup) annotation (Line(points={{-59,30},
                {-46,30},{-46,14.4},{-22,14.4}}, color={0,0,127}));
        connect(TOut.y, econEnableDisable.TOut) annotation (Line(points={{-59,70},
                {-42,70},{-42,19.4},{-22,19.4}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Ellipse(lineColor = {75,138,73},
                      fillColor={255,255,255},
                      fillPattern = FillPattern.Solid,
                      extent={{-100,-100},{100,100}}),
              Polygon(lineColor = {0,0,255},
                      fillColor = {75,138,73},
                      pattern = LinePattern.None,
                      fillPattern = FillPattern.Solid,
                      points={{-36,58},{64,-2},{-36,-62},{-36,58}})}), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end EconEnableDisable_TOut;
    annotation (Documentation(revisions="<html>
</html>",     info="<html>
<p>
This package contains models that validate the control sequences.
The examples plot various outputs, which have been verified against
analytical solutions. These model outputs are stored as reference data to
allow continuous validation whenever models in the library change.
</p>
</html>"));
    end Validation;
    annotation (Icon(graphics={Rectangle(
            extent={{-60,60},{60,-60}},
            lineColor={28,108,200},
            lineThickness=0.5)}));
  end AtomicSequences;

  package CompositeSequences

    model EconomizerDocuTemporary

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
      defaultComponentName = "setPoiVAV",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),                                        graphics={
            Rectangle(
            extent={{-100,-100},{100,100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255}),
        Polygon(
          points={{80,-76},{58,-70},{58,-82},{80,-76}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(points={{8,-76},{78,-76}},   color={95,95,95}),
        Line(points={{-54,-22},{-54,-62}},color={95,95,95}),
        Polygon(
          points={{-54,0},{-60,-22},{-48,-22},{-54,0}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-88,-6},{-47,-26}},
          lineColor={0,0,0},
              textString="T"),
        Text(
          extent={{64,-82},{88,-93}},
          lineColor={0,0,0},
              textString="u"),
            Line(
              points={{-44,-6},{-30,-6},{-14,-42},{26,-42},{38,-62},{60,-62}},
              color={0,0,255},
              thickness=0.5),
            Line(
              points={{-44,-6},{-30,-6},{-14,-42},{2,-42},{18,-66},{60,-66}},
              color={255,0,0},
              pattern=LinePattern.Dot,
              thickness=0.5),
        Line(points={{-4,-76},{-60,-76}}, color={95,95,95}),
        Polygon(
          points={{-64,-76},{-42,-70},{-42,-82},{-64,-76}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
            Text(
              extent={{-98,90},{-72,68}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="uHea"),
            Text(
              extent={{-96,50},{-70,28}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="uCoo"),
            Text(
              extent={{68,72},{94,50}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="THea"),
            Text(
              extent={{68,12},{94,-10}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="TCoo"),
            Text(
              extent={{74,-50},{100,-72}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="y"),
            Text(
              extent={{-96,-30},{-70,-52}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="TZon"),
            Text(
              extent={{-98,-68},{-72,-90}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="TOut"),
        Line(points={{-54,50},{-54,10}},  color={95,95,95}),
        Polygon(
          points={{-54,72},{-60,50},{-48,50},{-54,72}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-88,68},{-47,48}},
          lineColor={0,0,0},
              textString="y"),
            Line(points={{-46,44},{-28,20},{18,20},{28,36},{38,36},{50,54}}, color={
                  0,0,0}),
            Line(points={{18,20},{38,20},{50,54},{28,54},{18,20}}, color={0,0,0}),
            Text(
              extent={{-96,12},{-70,-10}},
              lineColor={0,0,127},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="TSetZon")}),
            Diagram(
            coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-420},{100,220}}), graphics={
            Rectangle(
              extent={{-88,-314},{70,-400}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-88,-214},{70,-300}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{32,-304},{68,-286}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="0.25 < y < 0.5"),
            Text(
              extent={{32,-404},{68,-386}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="0.75 < y < 1"),
            Rectangle(
              extent={{-88,-172},{70,-210}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{30,-212},{66,-194}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="0.5 < y < 0.75")}),
        Documentation(info="<html>
<p>
Fixme
This is initial and somewhat broad documentation based on comments from BE. 
G36. The documentation should turn into a description how sequences 1, 2, and 3 
get combined in EconomizerSequence. Add block diagram that explains how the 
3 sequences interact, point to their individual documentations.
</p>
<p>
Economizer damper is used to control the outdor airflow to the building HVAC 
system. The economizer is primarily used to reduce the heating and cooling 
energy consumption, but depending on the configuration it is also be used to
satisfy the minimum outdoor air requirement, as perscribed by the applicable
building code. Thus we differentiate between a single common economizer 
damper and a separate minimum outdoor air damper. In case of a separate minimum
outdoor air damper, the first control sequence described bellow should get 
modified. However, the three sequences we utilize are the most generic version
of economizer control as described in G36.
<p>
The first control sequence resets the MinOA-P (minimum outside air damper 
position) and the MaxRA-P (maximum return air damper position). A PI 
controller determines mentioned damper postion limits based on the error between 
outdoor air setpoint and measured outdoor airflow.
</p>
<p>
Sequence 1: MinOAReset
</p>
<p>
Inputs: OA volume setpoint, OA volume measurement
</p>
<p>
Outputs: MinOA-P setpoint, MaxRA-P setpoint
</p>
<p align=\"center\">
<img alt=\"Image of set point reset\"
src=\"modelica://Buildings/Resources/Images/Experimental/OpenBuildingControl/ASHRAE/G36/SingleCommonEconDamperMinOA.png\"/>
</p>
<p>
The second sequence is the high limit lockout used to disable the economizer, 
in other words to set the MaxOA-P = MinOA-P.
Fixme: List variables as provided on the chart below.
</p>
<p>
Sequence 2: Enable-disable more suitable (based on Pauls comments about low temp shutdown to MinOA-P):
- Includes high limit lockout, freezestat [fixme: and MAT temperature (in case that there is a 
MAT sensor - space average accross the coil?)]
</p>


</p>
<p>
Inputs: TOut, Freezstat status, time since last disable, [fixme: MAT temperature 
(based on answer from Pau)?
</p>
<p>
Outputs: MaxOA-P setpoint (set to min if disabled)
</p>
<p align=\"center\">
<img alt=\"Image of set point reset\"
src=\"modelica://Buildings/Resources/Images/Experimental/OpenBuildingControl/ASHRAE/G36/EconHighLimitLockout.png\"/>
</p>
<p>
The third control sequence modulates OA and RA dampers. It takes MinOA-P and 
MaxRA-P outputs from the first sequence as inputs that set the corresponding 
damper position limits. The positions for both OA and RA dampers are set by 
a single PI loop. The damper positions are modulated between the MinOA-P 
(MinRA-P) and MaxOA-P (MaxRA-P) positions based on the control signal from a 
controller which regulates SAT to SATsp. The heating signal must be off.
</p>
<p>
Sequence 3: DamperModulation
</p>
<p>
Inputs: SAT measurement, SAT setpoint, MinOA-P, MaxOA-P (100% or set at 
comissioning, thus parameter), MaxRA-P
</p>
<p>
Outputs: OA-P, RA-P
</p>
<p align=\"center\">
<img alt=\"Image of set point reset\"
src=\"modelica://Buildings/Resources/Images/Experimental/OpenBuildingControl/ASHRAE/G36/DamperModulationSequenceEcon.PNG\"/>
</p>







<p>
Fixme: Leaving VAV docs here for now, remove when harmonized.
</p>
<p>
For the temperature set points, the
parameters are the maximum supply air temperature <code>TMax</code>,
and the minimum supply air temperature for cooling <code>TMin</code>.
The deadband temperature is equal to the
average set point for the zone temperature
for heating and cooling, as obtained from the input <code>TSetZon</code>,
constraint to be within <i>21</i>&deg;C (&asymp;<i>70</i> F) and
<i>24</i>&deg;C (&asymp;<i>75</i> F).
The setpoints are computed as shown in the figure below.
Note that the setpoint for the supply air temperature for heating is
lower than <code>TMin</code>, as shown in the figure.
</p>
<p>
For the fan speed set point, the
parameters are the maximu fan speed at heating <code>yHeaMax</code>,
the minimum fan speed <code>yMin</code> and
the maximum fan speed for cooling <code>yCooMax</code>.
For a cooling control signal of <code>yCoo &gt; 0.25</code>,
the speed is faster increased the larger the difference is between
the zone temperature minus outdoor temperature <code>TZon-TOut</code>.
The figure below shows the sequence.
</p>
Note that the inputs <code>uHea</code> and <code>uCoo</code> must be computed
based on the same temperature sensors and control loops.
</p>
</html>",     revisions="<html>
<ul>
<li>
January 10, 2017, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end EconomizerDocuTemporary;

    package Validation
      annotation (Icon(graphics={
            Rectangle(
              lineColor={200,200,200},
              fillColor={248,248,248},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100,-100},{100,100}},
              radius=25),
            Polygon(
              origin={18,24},
              lineColor={78,138,73},
              fillColor={78,138,73},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
    end Validation;
    annotation (Icon(graphics={
          Rectangle(
            extent={{-70,60},{-30,20}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Rectangle(
            extent={{-70,-20},{-30,-60}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Rectangle(
            extent={{30,20},{70,-20}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Line(
            points={{-30,40},{0,40},{0,10},{30,10}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-30,-40},{0,-40},{0,-10},{30,-10}},
            color={28,108,200},
            thickness=0.5)}));
  end CompositeSequences;
annotation (Documentation(info="<html>
<p>
This package contains control sequences from
ASHRAE Guideline 36.
</p>
</html>"));
end G36;