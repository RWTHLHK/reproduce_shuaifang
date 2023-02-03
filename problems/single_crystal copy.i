[Mesh]

    type = GeneratedMesh
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

[]

[Variables]
    [./d] #damage variable
        order=FIRST
        family=LAGRANGE
    [../]
[]

[Kernels]
    [./spatial]
        type = ADVectorDiffusion
        variable = d
    []
[]

[Functions]
    [./distribution]
        type = ParsedFunction
        experssion = -exp((x+y)/0.5)
    [../]
[]
[BCs]
    [./initial_crack]
        type = ADDirichletBC
        variable = d
        boundary = crack
        value = 1
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
  output_initial = true
[]