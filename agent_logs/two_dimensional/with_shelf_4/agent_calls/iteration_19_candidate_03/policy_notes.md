# Multi-wake target-policy candidate

## Visual diagnosis and inherited evidence

- The shared prewarm sheet shows the held fish above and downstream of four
  fully developed, interacting vortex streets.  Those streets already fill
  the target corridor at release, but the identical prewarm sheets make their
  exact phase a common initial condition rather than a transferable clock or
  route signal.
- All four sampled solvers are deterministic copies of the signed-power-guard
  policy: their prewarm and released sheets are byte-identical and they reach
  the target after `123.018` released units with `3.594L` mean distance,
  `3.288L` minimum cylinder clearance, and about `-11.04L` upstream head
  displacement.  Mean local streamwise flow is only `-0.0630`, so the visible
  alternating posterior-lagged bend is active propulsion rather than passive
  advection.  The sheet shows a compact targetward fold through the wake
  corridor, not collision avoidance at the clearance limit.
- The signed-power guard is a completed positive mechanism, not merely a
  proposal.  Relative to the assigned parent's anterior-only response it
  advances capture from `135.019` to `123.018`, lowers mean distance from
  `3.685L` to `3.594L`, total command energy from `110448` to `95084`, and RMS
  crossflow/force/moment from `0.1535/18.53/362.61` to
  `0.1429/17.03/334.45`.  It also limits posterior acceleration to `28.738`
  rad/time^2, although anterior acceleration still touches the `31.416` cap.
- No sampled rollout is a semantic failure.  The most informative inherited
  mechanism failure is course alignment stacked on the anterior-only action
  response: its sheet retains propulsion but prolongs the midcourse zig-zag,
  delays capture to `162.222`, worsens mean distance to `4.433L`, and raises
  energy to `136964`.  The same course residual on direct action gives only a
  modest distance benefit (`4.184L` to `4.077L`) without that large detour.
  Thus course error is not safe as an always-available additive residual when
  action history is controlling oscillator phase.
- Sampled optimizer guidance supplies further negative boundaries: gating the
  direct moment residual by bearing divergence, attenuating it by yaw-power
  sign, moving route asymmetry into the posterior wave, bearing-based tail-lag
  relief, and unconditioned crossflow or lateral-target residuals all preserve
  alternating motion but lengthen the route and raise effort/load.  This
  candidate therefore keeps moment rejection, posterior tracking, gait gains,
  and the signed-power guard unchanged.

## Policy hypothesis

Add one response-conditioned arbitration mechanism to the current best
scaffold.  First form the existing target-bearing and direct-moment command and
measure the anterior signed power contributed by its short previous-action
response.  Convert the existing power guard into a continuous
`direct_tracking_gate`: it is zero while history is neutral or
energy-removing, and approaches one only when positive lag power makes the
guard restore raw joint-state feedback.  Admit the inherited body-frame
course-alignment correction only through that gate, then recompute the final
half-cycle command and signed-power guard.  Course correction therefore acts
as a phase/response-conditioned steering pulse during direct tracking rather
than competing continuously with action-history phase.

The expectation is preservation of capture, about `-11L` upstream
translation, direct yaw-moment rejection, and the alternating posterior wave,
with a shorter visible midcourse fold or lower mean distance than `3.594L`.
Reject the mechanism if capture is lost or delayed beyond the assigned
parent's `135.019`, mean distance exceeds `3.685L`, minimum clearance falls
materially below `3.288L`, the anterior cap is contacted more aggressively,
or energy and RMS crossflow/force/moment rise materially above
`95084` and `0.1429/17.03/334.45`.  Formal CFD occurs only after this worker
exits, so these are falsification criteria rather than claims for the new
candidate.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and phase-aware CPG actuator control
source_mechanism: schedule a target-course correction by the locomotor controller's observed response phase while preserving the propulsive traveling wave
transferable_invariant: a secondary route correction should receive authority only in locomotor phases where current joint-state feedback, rather than lagged command history, owns the steering response
nontransferable_details: published gains, hardware servo constants, species-specific curvature envelopes, dimensional beat settings, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: retain normalized body-frame bearing, velocity, moment, joint state, and previous-action feedback; gate the evidenced course error by the signed positive-lag-power bypass of joint 1 and leave the posterior lagged wave direct except for its existing power guard
falsification: reject if capture, upstream translation, clearance, or the alternating wave regresses, or if course-fold reduction and distance improve only by increasing cap contact, effort, crossflow, force, or moment beyond the signed-power baseline
