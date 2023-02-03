[GlobalParams]
  displacements = 'disp_x disp_y'
[]
[Mesh]
    [./sample] # generate test sample geometry
        type = GeneratedMeshGenerator
        dim = 2
        elem_type = QUAD4
        nx = 400
        ny = 400
        nz = 0
        xmin = 0
        xmax = 1
        ymin = 0
        ymax = 1
        zmin = 0
        zmax = 0
    [../]

    [./crack] # generate crack geometry to add BC
        type = BoundingBoxNodeSetGenerator
        input = sample
        new_boundary = 'crack_line'
        bottom_left = '0 0.5 0'
        top_right = '0.5 0.5 0'
    [../]
[]
[Modules/TensorMechanics/Master]
  [all]
    add_variables = true
  []
[]
[Variables]
    [./d] #damage variable
        order=FIRST
        family=LAGRANGE
    [../]
[]

[Kernels]
    [./spatial]
        type = DamageSpatialDistribution
        variable = d
        l = 0.5
    []
[]

[BCs]
    [./initial_crack]
        type = ADDirichletBC
        variable = d
        boundary = crack_line
        value = 1
    [../]
    [bottom_x]
      type = ADDirichletBC
      variable = disp_x
      boundary = bottom
      value = 0
    []
    [bottom_y]
      type = ADDirichletBC
      variable = disp_y
      boundary = bottom
      value = 0
    []
    [uniaxial_loading]
      type = ADFunctionDirichletBC
      variable = disp_y
      boundary = top
      function = '0.5*t*t'
    []
[]

[Postprocessors]
  [./step_size]             # Size of the time step
    type = TimestepSize
  [../]
[]

[Preconditioning]
  [./coupled]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Steady # Steady state problem
  solve_type = NEWTON # Perform a Newton solve

  # Set PETSc parameters to optimize solver efficiency
  petsc_options_iname = '-pc_type -pc_hypre_type' # PETSc option pairs with values below
  petsc_options_value = ' hypre    boomeramg'
[]

[Outputs]
  exodus = true
  console = true
  print_perf_log = true
[]