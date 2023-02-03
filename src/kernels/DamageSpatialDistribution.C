#include "DamageSpatialDistribution.h"
registerMooseObject("reproduce_shuaifangApp", DamageSpatialDistribution);

InputParameters
DamageSpatialDistribution::validParams(){
    InputParameters params = Kernel::validParams();
    params.addClassDescription("l controls the thickness of phase boundary");

    //add a required parameter
    params.addRequiredParam<Real>("l","the parameter that controls the thickness of phase boundary");
    return params;
}

DamageSpatialDistribution::DamageSpatialDistribution(const InputParameters &parameters) 
    : Kernel(parameters),
    _l(getParam<Real>("l"))
{}

Real
DamageSpatialDistribution::computeQpResidual()
{
    return _test[_i][_qp]*_u[_qp]  + (_l*_l) * _grad_u[_qp] * _grad_test[_i][_qp];
}

Real
DamageSpatialDistribution::computeQpJacobian(){
    return _test[_i][_qp]*_phi[_j][_qp] + (_l*_l) *_grad_phi[_j][_qp] * _grad_test[_i][_qp];
}