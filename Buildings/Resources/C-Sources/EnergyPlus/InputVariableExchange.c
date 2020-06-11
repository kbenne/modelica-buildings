/*
 * Modelica external function to communicate with EnergyPlus.
 *
 * Michael Wetter, LBNL                  5/22/2020
 */

#include "InputVariableExchange.h"
#include "EnergyPlusFMU.h"

#include <stdlib.h>
#include <math.h>
#include <string.h>


/* Exchange data between Modelica zone and EnergyPlus zone
*/
void InputVariableExchange(
  void* object,
  int initialCall,
  double u,
  double time,
  double* y){

  FMUInputVariable* inpVar = (FMUInputVariable*) object;
  FMUBuilding* bui = inpVar->ptrBui;

  fmi2Status status;

  if (FMU_EP_VERBOSITY >= TIMESTEP)
    ModelicaFormatMessage("Exchanging data with EnergyPlus: t = %.2f, initialCall = %d, mode = %s, zone = %s.\n",
      time, initialCall, fmuModeToString(bui->mode), inpVar->modelicaNameInputVariable);

  if (! inpVar->isInstantiated){
    /* This input variable has not been initialized because the simulator removed the call to initialize().
    */
    InputVariableInstantiate(object, time);
 /*   ModelicaFormatError(
      "Error, input variable %s should have been initialized. Contact support.",
      inpVar->modelicaNameInputVariable);
      */
  }

  if (initialCall){
    inpVar->isInitialized = true; /* Set to true as it will be initialized right below */
    if (FMU_EP_VERBOSITY >= MEDIUM)
      ModelicaFormatMessage("Initial call for input variable %s with time = %.f\n", inpVar->modelicaNameInputVariable, time);
  }
  else
  {
    if (FMU_EP_VERBOSITY >= TIMESTEP)
      ModelicaFormatMessage("Did not enter initialization mode for input variable %s., isInitialized = %d\n",
        inpVar->modelicaNameInputVariable, inpVar->isInitialized);
  }

  /* Get out of the initialization mode if this input variable is no longer in the initial call
     but the FMU is still in initializationMode */
  if ((!initialCall) && bui->mode == initializationMode){
    if (FMU_EP_VERBOSITY >= MEDIUM)
      ModelicaFormatMessage(
        "fmi2_import_exit_initialization_mode: Enter exit initialization mode of FMU in InputVariableExchange() for input variable = %s.\n",
        inpVar->modelicaNameInputVariable);
    status = fmi2_import_exit_initialization_mode(bui->fmu);
    if( status != fmi2_status_ok ){
      ModelicaFormatError("Failed to exit initialization mode for FMU for building %s and input variable %s",
        bui->modelicaNameBuilding, inpVar->modelicaNameInputVariable);
    }
    /* After exit_initialization_mode, the FMU is implicitly in event mode per the FMI standard */
    setFMUMode(bui, eventMode);
  }


  if ( (time - bui->time) > 0.001 ) {
    /* Real time advanced */
    advanceTime_completeIntegratorStep_enterEventMode(bui, inpVar->modelicaNameInputVariable, time);
  }

  /* Set input values, which are of the order below
     const char* inpNames[] = {"T", "X", "mInlets_flow", "TAveInlet", "QGaiRad_flow"};
  */
  inpVar->inputs->valsSI[0] = u;


  if (FMU_EP_VERBOSITY >= TIMESTEP)
    ModelicaFormatMessage(
      "Input to fmu for input variable %s: u = %.2f\n",
      inpVar->modelicaNameInputVariable,
      inpVar->inputs->valsSI[0]);

  setVariables(bui, inpVar->modelicaNameInputVariable, inpVar->inputs);

  if (FMU_EP_VERBOSITY >= TIMESTEP)
    ModelicaFormatMessage("Returning from InputVariableExchange() for %s.\n", inpVar->modelicaNameInputVariable);

  /* Dummy output, used to enable forcing a direct dependency of outputs to inputs */
  *y = u;
  return;
}