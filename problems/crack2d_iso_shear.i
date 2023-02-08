#This input uses PhaseField-Nonconserved Action to add phase field fracture bulk rate kernels
[Mesh]
  [sample] # generate test sample geometry
    type = GeneratedMeshGenerator
    dim = 2
    elem_type = QUAD4
    nx = 100
    ny = 100
    nz = 0
    xmin = 0
    xmax = 1
    ymin = 0
    ymax = 1
    zmin = 0
    zmax = 0
  []

  [crack] # generate crack geometry to add BC
    type = BoundingBoxNodeSetGenerator
    input = sample
    new_boundary = 'crack_line'
    bottom_left = '0 0.5 0'
    top_right = '0.5 0.5 0'
  []
[]

[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Modules]
  [PhaseField]
    [Nonconserved]
      [c]
        free_energy = F
        kappa = kappa_op
        mobility = L
      []
    []
  []
  [TensorMechanics]
    [Master]
      [mech]
        add_variables = true
        strain = SMALL
        additional_generate_output = 'stress_xx'
        save_in = 'resid_x resid_y'
      []
    []
  []
[]

[AuxVariables]
  [resid_x]
  []
  [resid_y]
  []
[]

[Kernels]
  [solid_x]
    type = PhaseFieldFractureMechanicsOffDiag
    variable = disp_x
    component = 0
    c = c
  []
  [solid_y]
    type = PhaseFieldFractureMechanicsOffDiag
    variable = disp_y
    component = 1
    c = c
  []
[]

[BCs]
  [xdisp_top]
    type = FunctionDirichletBC
    variable = disp_x
    boundary = top
    function = 't'
  []

  [initial_crack]
    type = ADDirichletBC
    variable = c
    boundary = crack_line
    value = 1
  []

  [xfix]
    type = DirichletBC
    variable = disp_x
    boundary = 'crack_line bottom'
    value = 0
  []
  [yfix]
    type = DirichletBC
    variable = disp_y
    boundary = 'bottom top crack_line'
    value = 0
  []
[]

[Materials]
  [pfbulkmat]
    type = GenericConstantMaterial
    prop_names = 'gc_prop l visco'
    prop_values = '1e-3 0.01 1e-4'
  []
  [define_mobility]
    type = ParsedMaterial
    material_property_names = 'gc_prop visco'
    property_name = L
    expression = '1.0/(gc_prop * visco)'
  []
  [define_kappa]
    type = GenericConstantMaterial
    prop_names = 'kappa_op'
    prop_values = '1e-6'
  []
  [elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 120
    poissons_ratio = 0.3
  []
  [damage_stress]
    type = ComputeLinearElasticPFFractureStress
    c = c
    E_name = 'elastic_energy'
    D_name = 'degradation'
    F_name = 'local_fracture_energy'
    decomposition_type = strain_spectral
  []
  [degradation]
    type = DerivativeParsedMaterial
    property_name = degradation
    coupled_variables = 'c'
    expression = '(1.0-c)^2*(1.0 - eta) + eta'
    constant_names = 'eta'
    constant_expressions = '0.0'
    derivative_order = 2
  []
  [local_fracture_energy]
    type = DerivativeParsedMaterial
    property_name = local_fracture_energy
    coupled_variables = 'c'
    material_property_names = 'gc_prop l'
    expression = 'c^2 * gc_prop / 2 / l'
    derivative_order = 2
  []
  [fracture_driving_energy]
    type = DerivativeSumMaterial
    coupled_variables = c
    sum_materials = 'elastic_energy local_fracture_energy'
    derivative_order = 2
    property_name = F
  []
[]

[Postprocessors]
  [resid_x]
    type = NodalSum
    variable = resid_x
    boundary = 2
  []
  [resid_y]
    type = NodalSum
    variable = resid_y
    boundary = 2
  []
[]

[Preconditioning]
  [smp]
    type = SMP
    full = true
  []
[]

[Executioner]
  type = Transient

  solve_type = PJFNK
  petsc_options_iname = '-pc_type -ksp_gmres_restart -sub_ksp_type -sub_pc_type -pc_asm_overlap'
  petsc_options_value = 'asm      31                  preonly       lu           1'

  nl_rel_tol = 1e-6
  l_max_its = 50
  nl_max_its = 20

  dt = 1e-4
  end_time = 0.015
  [Adaptivity]
    coarsen_fraction = 0.1
    refine_fraction = 0.7
    max_h_level = 1
  []
[]

[Outputs]
  exodus = true
[]
