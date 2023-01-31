//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html
#include "reproduce_shuaifangTestApp.h"
#include "reproduce_shuaifangApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"
#include "ModulesApp.h"

InputParameters
reproduce_shuaifangTestApp::validParams()
{
  InputParameters params = reproduce_shuaifangApp::validParams();
  return params;
}

reproduce_shuaifangTestApp::reproduce_shuaifangTestApp(InputParameters parameters) : MooseApp(parameters)
{
  reproduce_shuaifangTestApp::registerAll(
      _factory, _action_factory, _syntax, getParam<bool>("allow_test_objects"));
}

reproduce_shuaifangTestApp::~reproduce_shuaifangTestApp() {}

void
reproduce_shuaifangTestApp::registerAll(Factory & f, ActionFactory & af, Syntax & s, bool use_test_objs)
{
  reproduce_shuaifangApp::registerAll(f, af, s);
  if (use_test_objs)
  {
    Registry::registerObjectsTo(f, {"reproduce_shuaifangTestApp"});
    Registry::registerActionsTo(af, {"reproduce_shuaifangTestApp"});
  }
}

void
reproduce_shuaifangTestApp::registerApps()
{
  registerApp(reproduce_shuaifangApp);
  registerApp(reproduce_shuaifangTestApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
reproduce_shuaifangTestApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  reproduce_shuaifangTestApp::registerAll(f, af, s);
}
extern "C" void
reproduce_shuaifangTestApp__registerApps()
{
  reproduce_shuaifangTestApp::registerApps();
}
