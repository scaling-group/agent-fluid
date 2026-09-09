# Wake-policy candidate notes

## Prior-evidence visual diagnosis

The shared prewarm sheet is common initial-condition evidence: before release,
the held fish sits high and downstream while the four developed cylinder
streets merge across the target corridor.  The assigned parent
(`solver_d978274dbe45`) and all three sampled siblings use the same
steering-reserve controller and reproduce the same finite result: target reach
at `49.142` released time, mean/final distance `2.1560/0.7493L`, command-energy
mean `1272.3`, RMS relative crossflow `0.230`, and RMS force/moment
`39.05/617.13`.  Their released sheets show active self-propulsion rather than
passive advection: an initial targetward redirect is followed by a coherent
left/down traverse into the interacting wake and first crossing of the target
circle.  Repeated identical metrics under the fixed snapshot and seed confirm
reproducible materialization, but they are not evidence of robustness to a new
wake phase.

The most informative failure remains the slower curvature-equilibrium policy
(`solver_0c51696bec78`).  It stays far downstream, reverses without entering
the useful target corridor, and ends in the visible compact vortex/load
blow-up.  Its `unstable_dynamics` termination, minimum distance `9.238L`, RMS
relative crossflow `1.138`, and RMS force/moment `16749.8/290421` agree with
the sheet.  This rejects broad carrier slowdown or replacement.  Conversely,
the successful allocator still reaches both joint-speed limits and raises
force/moment from the earlier raw-residual success (`27.25/525.79`) even while
improving arrival and effort.  The successful sheet also retains a broad
initial hook and visible route curvature.  Aggregate crossflow in the two
successful policies is similar and no signed disturbance history is sampled,
so the evidence does not support direct flow- or force-cancellation feedback.

## Candidate policy hypothesis

Preserve the evaluated `0.55`-period joint-state carrier, posterior lag,
same-sign bearing residual, and `20%` steering-reserve allocator.  Add one new
state-feedback mechanism: form the turn request from current body-frame target
bearing plus a short lead of the eight-observation windowed bearing rate, then
pass that predicted error through the existing bounded steering nonlinearity.
When target bearing is moving away from zero the rate term requests correction
earlier; when the bearing is already collapsing it releases or reverses the
residual before the geometric error changes sign.  This is a line-of-sight
lead mechanism, not a scalar carrier retune, external clock, wake-phase rule,
or memorized route.

Expected test: retain target reach and coherent leftward propulsion while
reducing the initial hook or subsequent route curvature, arrival time, and
force/moment or speed-limit pressure relative to the repeated `49.142` parent.
Falsify it if target reach is lost, arrival is materially delayed, the
seed-like lower exit or unstable failure returns, the carrier loses thrust,
or bounded rate sensitivity introduces command chatter or larger loads.  This
candidate's CFD evaluation occurs after worker exit and is not claimed here.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and wake-interaction control
source_mechanism: sensor-conditioned line-of-sight lead around a rhythmic locomotor carrier
transferable_invariant: persistent body-frame target error and its recent normalized rate can separate growing route error from imminent overshoot while the traveling bend retains propulsion
nontransferable_details: published gains, clocked CPG phase, robot hardware, dimensional beat rates, species kinematics, exact vortex phases, cylinder locations, and source-task routes
policy_translation: add a short candidate-owned lead of bounded recent bearing-window rate to current normalized body-frame bearing before the proven two-joint steering residual and reserve allocator
falsification: reject if semantic success or coherent propulsion is lost, or if route curvature, arrival, speed-limit contact, effort, or force/moment loads do not improve without chatter
