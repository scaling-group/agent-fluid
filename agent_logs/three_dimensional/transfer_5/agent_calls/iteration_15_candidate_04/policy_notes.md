# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis

All four sampled rollouts and the assigned parent's rollout satisfy the released
contract: direct uniform still-water initialization, zero background velocity,
no prewarm or cylinders, stable dynamics, and capture. Across the best-score
counter-tangent sample, the cleaner posterior-relief sample, and the assigned
parent, the top-down sheets show the fish making the same broad target-directed
turn while shedding a coherent alternating red/blue street. The oblique sheets
independently show compact alternating three-dimensional Lambda2 structures
persisting along the curved approach. The fish is self-propelled rather than
advected; neither wake collapse nor a distinct trajectory topology supports
changing the traveling carrier, course bend, or redirect handoff.

The trajectories separate mechanisms that the nearly coincident images cannot.
The sampled load-gated counter-tangent has the best scalar score
(`-0.535298`) and arrives at `23.831520T`, but relative to the unconditional
posterior amplitude-relief sample it has higher peak yaw (`3.264` versus
`3.063 rad/T`) and, inside `3L`, higher mean absolute yaw (`1.682` versus
`1.606 rad/T`), target-transverse speed (`0.245` versus `0.233U`), lateral
force (`0.00894` versus `0.00889`), and yaw moment (`0.00639` versus
`0.00614`). All four sampled policies have zero joint-angle-limit exposure;
their joint-speed and projected-command exposure are similar, so another
whole-command projection is not the evidenced missing layer.

The assigned parent supplies a direct negative result for instantaneous
hydrodynamic-load admission. Gating the same posterior amplitude relief by
reinforcing yaw moment retained capture and the unconditional-relief arrival
time (`23.875523T`), but worsened its inside-`3L` mean absolute yaw from
`1.606` to `1.634 rad/T`, lateral force from `0.00889` to `0.00904`, and yaw
moment from `0.00614` to `0.00622`. It also worsened score from `-0.535565` to
`-0.537144`. Thus instantaneous moment is not an evidenced relief-admission
signal here: it is compatible with a phase-lagged reactive load and removed
useful relief without recovering arrival.

## Candidate hypothesis

Restore posterior half-cycle amplitude relief and replace the falsified moment
gate with smooth target-course urgency. Keep target course as the route layer;
use carrier-rejected excess yaw only for the dissipative sign, observed tail
tangent for the yaw-supporting half-cycle, and the magnitude of the already
normalized target-relative course residual to interpolate relief from `0.14`
to `0.24`. On the unconditional-relief trace this urgency has mean `0.425`
inside `3L`, so the proposed interpolation averages about `0.183`, essentially
the evaluated `0.18` relief while moving authority from low-drift strokes to
high-drift strokes. This is a feedback-allocation change, not cadence or
scalar-only carrier tuning.

Support requires capture with the same coherent wake and broad approach,
arrival no worse than `23.875523T`, and joint improvement over unconditional
relief in terminal yaw or transverse motion without worse lateral force, yaw
moment, joint-speed exposure, or projected commands. Falsify if course urgency
repeats the assigned parent's degradation, if the stronger high-drift relief
weakens propulsion or wake coherence, or if the same arrival/trajectory merely
changes command amplitude without a terminal-state benefit.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and asymmetric flapping
source_mechanism: sensor feedback allocates bounded rhythmic amplitude asymmetry to the stroke associated with an observed direction-tracking error
transferable_invariant: preserve the traveling carrier while route-relative translation supplies urgency, residual yaw supplies dissipative direction, and observed joint state selects the affected half-cycle
nontransferable_details: published gains, dimensional cadence, robot linkage geometry, species-specific envelopes, clock phase, exact vortex phase, and task-specific routes
policy_translation: retain the sampled C-bend carrier and interpolate posterior half-cycle relief from normalized target-course residual magnitude; carrier-rejected yaw and observed tail tangent retain sign and stroke selection
falsification: reject if capture or wake coherence regresses, arrival exceeds unconditional relief, or terminal yaw, transverse motion, loads, joint-speed exposure, and projected commands fail to improve jointly
