#pragma once
#include "Kernel.h"

class DamageSpatialDistribution : public Kernel
{
    public:
        static InputParameters validParams();
        DamageSpatialDistribution(const InputParameters & parameters);
    protected:
        virtual Real computeQpResidual() override;
        virtual Real computeQpJacobian() override;
        const Real _l;
};
