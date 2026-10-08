# Wake-policy candidate notes

## Prior-evidence visual diagnosis

The shared prewarm sheet shows the common initial condition: the fish is held
above and downstream of four developed, interacting vortex streets. The
released sheets then separate controller behavior clearly. The target-blind
seed initially self-propels along a useful left/down diagonal, but curls into a
steep lower-domain exit after `50.127` released time units; its head displacement
is `(-3.545, -13.300)L` and its closest approach is only `8.615L`. The
angle-equilibrium steering variant turns almost vertically downward and toward
positive x, exits after `13.915`, and has negative progress. The slower
angle-equilibrium variant remains finite longer but never enters the useful
second-row target region; its final frame is a numerical blow-up, consistent
with `unstable_dynamics`, RMS relative crossflow `1.138`, RMS lateral force
`16749.8`, and RMS yaw moment `290421`.

The acceleration-bias policy is the only semantic success. Its keyframes show
a coherent self-propelled left/down approach, a broad correction below the
target, entry into the interacting wake corridor, and an upward return that
crosses the target circle after `62.304` released time units. This agrees with
head displacement `(-10.922, -4.153)L`, final/minimum distance `0.74959L`, and
much smaller RMS force and moment (`27.25`, `525.79`) than the unstable
variant. Its steering sign and `0.55`-period, `28`-degree carrier are therefore
the strongest inherited behavior to preserve.

The success is not yet a clean actuation result: both joints touch the
configured speed and acceleration limits (`4.538` and `31.416` rad-based
units), command-energy mean is `1436.3`, and the visible path uses a broad
`4.293L` maximum lateral target offset before returning. The compact evidence
reports maxima rather than saturation duty cycle, so it supports creating
headroom but does not justify claiming persistent bang-bang action. It also
does not support a signed wake/force residual: the successful and ordinary
lower-exit rollouts have similar aggregate relative-crossflow levels while
their navigation outcomes differ sharply.

## Candidate policy hypothesis

Preserve the successful state-feedback oscillator, posterior lag, and
body-frame bearing-to-acceleration steering unchanged. Add one
direction-prioritized actuator-allocation mechanism: reserve a small fraction
of each joint's steering residual inside a candidate-owned acceleration
envelope just below the episode hard limit, then fit the remaining carrier and
steering command into the residual budget. This keeps the traveling bend as
the propulsive carrier while preventing symmetric hard clipping from erasing
the requested mean turn. It is a structural carrier/residual mixer, not a
scalar-only gait retune.

Expected test: retain target reach and the strong leftward displacement while
reducing maximum acceleration below `31.416`, lowering command effort, and
making the below-target correction less wasteful than the successful parent's
`4.293L` lateral excursion. Falsify the mechanism if target reach is lost,
arrival is materially delayed without a load/effort benefit, the seed-like
lower exit returns, the traveling bend loses thrust, numerical instability
appears, or speed-limit contact remains dominant despite the reserved
acceleration budget. The current candidate's CFD result is not available to
this worker and is not claimed as evidence.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and residual path-following control
source_mechanism: sensor-conditioned bounded steering residual layered on a rhythmic locomotor carrier
transferable_invariant: persistent body-frame direction error should receive explicit finite actuation authority while the joint-state traveling bend retains the remaining propulsion budget
nontransferable_details: published controller gains, robot actuator ratings, dimensional beat rates, clocked phases, species kinematics, exact vortex phases, and source-task routes
policy_translation: map normalized body-frame bearing to the proven two-joint steering residual, reserve a small candidate-owned share of a sub-hard-limit acceleration envelope for that residual, and bound the carrier-plus-remainder using only current joint state
falsification: reject if semantic success, targetward displacement, or coherent propulsion is lost, or if acceleration headroom fails to improve effort, lateral excursion, or limit contact
