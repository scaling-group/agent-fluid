# Wake-policy candidate notes

## Evidence diagnosis

- All four sampled evaluations use direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, contain no cylinders, and terminate in capture.
- The best finite comparator is the split-response policy in
  `solver_0711c7882b23`: capture at `17.7540 T`, score `-0.07917`, and
  total/observed distance integrals `1.96508/1.34990 L`.  The assigned
  wholesale-axial parent is reproduced by `solver_0b60abafcd7c` and
  `solver_992c5492a1b7`: capture at `17.8970 T`, score `-0.08687`, and
  integrals `1.97313/1.35927 L`.
- Both combined keyframe sheets are valid and readable.  Their top-down rows
  show self-propelled, smooth target-directed arcs with coherent alternating
  vorticity from release through capture; their oblique rows show the same
  organized three-dimensional Lambda2 wake.  Neither variant is advected,
  collides, exits the domain, or develops a visibly different useful wake.
- The wholesale-axial parent is the informative control failure: it is
  `0.0050 L` closer at `2 T`, but the split policy leads by `0.0146 L` at
  `6 T` and by `0.0378/0.0720/0.0929/0.0909 L` at `8/10/12/16 T`.
  The split policy raises mean/max speed only from `0.7126/0.9555` to
  `0.7168/0.9603 L/T` and keeps the same `0.03225/0.01609` peak normalized
  lateral-force/yaw-moment envelope.  This supports a response-allocation
  diagnosis, not a missing carrier, steering, or wake-coherence mechanism.
- `solver_520d177a2515` retains approach cadence on productive closing.  Its
  trajectory is identical to the split policy through `16 T` and it crosses
  only one integration step earlier (`17.7485 T`), but its total integral and
  score regress to `1.96640 L` and `-0.08082` because the terminal sample is
  shallower.  This is not evidence for further terminal cadence changes.

## Policy hypothesis

Start from the sampled split-response controller.  Preserve total planar speed
as the broad posterior-wave release signal and axial speed as the release for
the smaller phase-even energy-deficit residual.  Add one mechanism: while the
observed mean-free posterior carrier energy is deficient, interpolate the
broad release toward the more permissive axial gate by only the nonnegative
gap between those two gates.  As tail-wave energy forms, the interpolation
vanishes continuously and restores the completed split hierarchy.  The edit
uses normalized body-frame speed and joint-state oscillator energy, changes no
route or redirect mean, and adds no time or world-frame schedule.

Expected result: retain the parent's first-`2 T` closure advantage without its
post-`6 T` over-emphasis, then match or improve the split policy's middle/late
checkpoint closure and capture while preserving its coherent two-view wake and
speed/action/load envelope.  Reject the mechanism if it loses capture, remains
on the wholesale-axial checkpoint trajectory after wave energy forms, regresses
the split policy's total or observed distance integral, creates persistent
posterior saturation, or materially exceeds `0.9603 L/T`, `0.03225` force, or
`0.01609` moment.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive swimming and sensor-modulated robotic-fish oscillators
source_mechanism: posterior traveling-wave kinematics carry thrust authority while closed-loop response modulates a rhythmic gait
transferable_invariant: emphasize the posterior wave only while its observed mean-free state lacks propulsive energy, then release that emphasis continuously as useful response forms
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, and prescribed routes
policy_translation: interpolate the normalized total-speed launch gate toward its axial-speed counterpart only by a bounded phase-even posterior-energy deficit; retain the two-joint state oscillator and all target-signed mean curvature
falsification: reject if the early lead does not transition into split-policy middle and late closure, or if capture, wake coherence, saturation, speed, force, or moment regresses beyond the sampled envelope
