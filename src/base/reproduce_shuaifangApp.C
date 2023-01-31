#include "reproduce_shuaifangApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
reproduce_shuaifangApp::validParams()
{
  InputParameters params = MooseApp::validParams();

  return params;
}

reproduce_shuaifangApp::reproduce_shuaifangApp(InputParameters parameters) : MooseApp(parameters)
{
  reproduce_shuaifangApp::registerAll(_factory, _action_factory, _syntax);
}

reproduce_shuaifangApp::~reproduce_shuaifangApp() {}

void
reproduce_shuaifangApp::registerAll(Factory & f, ActionFactory & af, Syntax & syntax)
{
  ModulesApp::registerAll(f, af, syntax);
  Registry::registerObjectsTo(f, {"reproduce_shuaifangApp"});
  Registry::registerActionsTo(af, {"reproduce_shuaifangApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
reproduce_shuaifangApp::registerApps()
{
  registerApp(reproduce_shuaifangApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
reproduce_shuaifangApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  reproduce_shuaifangApp::registerAll(f, af, s);
}
extern "C" void
reproduce_shuaifangApp__registerApps()
{
  reproduce_shuaifangApp::registerApps();
}
