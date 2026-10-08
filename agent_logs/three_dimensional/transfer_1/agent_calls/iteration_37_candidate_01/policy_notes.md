# Wake-policy candidate notes

## Evidence diagnosis

- The assigned v49 parent captures at `17.4845 T`, score `-0.06165`, with
  total/observed distance integrals `1.94744/1.33195 L`.  The duplicated v50
  geometry-qualified response captures earlier at `17.4130 T`, score
  `-0.05952`, and `1.94533/1.32998 L`; the inherited score logs reproduce this
  ordering.  The v52 terminal course-slip addition keeps the v50 arrival time
  but regresses to score `-0.06119` and `1.94667/1.32999 L`, so another
  terminal steering residual is not supported.
- All sampled evaluations use direct uniform still water with
  `U_infinity=(0,0,0)` and terminate by capture.  Their top-down sheets show
  self-propulsion, a coherent alternating street, and continuous target
  closure rather than advection or wake collapse.  The v49 oblique row is
  black and one byte-identical v50 rendering is also black; another v50 sheet
  has readable release, `4 T`, `16 T`, and capture oblique frames with an
  organized three-dimensional wake.  Thus the black rows are evaluation
  artifacts and do not support a comparative 3D-wake claim.
- The parent remains closer than v50 by `0.0249/0.0225 L` at `6/8 T`, when its
  reconstructed forward/total body-speed ratios are `0.974/0.996`.  V50 leads
  by `0.0128/0.0364/0.0355/0.0380 L` at `10/12/14/16 T`; its ratio falls to
  `0.874/0.829` at `10/12 T` as lateral motion grows.  This is evidence for a
  propulsion-versus-steering allocation crossover, not carrier retuning.

## Policy hypothesis

Start from the reproduced v50 controller and preserve its carrier, base route
feedback, geometric completion qualifier, actuator allocation, and approach
behavior.  Add one reflection-even axial-motion confidence to the existing
correct-yaw release of the phase-even posterior turn residual.  Squared
positive forward speed divided by total planar speed gives high confidence to
the nearly axial `6-8 T` motion but yields as sway grows around `10-12 T`;
taking the maximum with geometric completion keeps the validated v50 release
when the target angle is already small.  The steering sign remains entirely
target-derived.  The candidate should recover some early parent closure
without losing v50's middle/late lead, capture, coherent wake, or its
`0.9831 L/T`, `0.03225/0.01609` speed/force/moment envelope.  Reject the
mechanism if any of those boundaries regress.

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG control
source_mechanism: release bounded turning authority into posterior propulsion when observed response shows the redirect is productive
transferable_invariant: allocate steering versus propulsion continuously from measured body response while preserving the traveling-wave carrier
nontransferable_details: published gains, species-specific body envelopes, clock phase, exact vortex phase, and prescribed routes
policy_translation: combine normalized squared forward-to-planar body-speed coherence with geometric completion to qualify only the existing correct-yaw posterior-turn release
falsification: reject if the early checkpoint deficit remains, the v50 middle or terminal lead and capture are lost, the two-view wake decoheres, or speed, saturation, force, or moment materially exceed the sampled envelope
