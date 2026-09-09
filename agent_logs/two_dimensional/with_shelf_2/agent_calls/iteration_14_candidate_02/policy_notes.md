# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release while four developed cylinder streets merge around the target. It
  is common initial-condition evidence, so it cannot support a fixed wake
  phase, cylinder coordinate, or memorized route.
- All four sampled solver sheets and all locally available inherited sheets
  are finite `target_reached` cases; no failed keyframe sheet is available.
  The best sampled candidate (`0.165860`) and the informative regressed
  positive-course gate (`0.150759`) remain visually in the same useful family:
  an immediate body-generated traveling wake, active diagonal upstream and
  downward swimming, and one broad correction through the merged wakes into
  capture. For the best sample, mean body x velocity is `-0.2416` while mean
  local-flow x is `-0.1768`, confirming self-propulsion rather than passive
  advection. The regressed case takes longer (`45.837` versus `45.221`), has a
  worse mean distance (`1.7300L` versus `1.7146L`), and raises force/moment RMS
  from `439/4345` to `460/4433`; its nearly identical topology makes it a
  control-allocation boundary, not a different route. The inherited
  propulsive-priority collision remains a nonvisual failure boundary only: it
  passed below capture, approached to `1.872L`, and collided at `58.93` with
  `537/4995` loads, so the base traveling wave is not changed here.
- The assigned parent's exact inherited rollout and the prefilled solver both
  cap heading-response look-ahead by normalized distance divided by total
  body speed. They reproduce `target_reached` at `45.221`, score `0.165860`,
  `1.714578L` mean distance, command-energy mean `1030.385`, and `439/4345`
  force/moment RMS. Both joint rates still touch the `4.538` rad/time cap and
  accelerations approach the candidate's soft limit (`28.78/28.40`), so the
  small improvement over the uncapped `45.260/1.715290L/0.165009` reference is
  terminal route-response evidence, not resolution of load or saturation.
- A matched inherited alternative replaced total body speed in that terminal
  cap with positive windowed closing speed. It retained capture but slightly
  regressed arrival, mean distance, and score to `45.243`, `1.715373L`, and
  `0.164890`, with essentially unchanged `439/4343` loads. Later workers
  should therefore avoid another denominator/gain sweep. The body-speed cap
  is retained, while the missing observable distinction is whether the
  current yaw actually improves the whole body-frame course when lateral slip
  and wake motion are included.

## Policy hypothesis

Preserve the successful zero-centered traveling bend, posterior lag,
yaw-gated half-cycle steering, normalized positive-closure residual, full
negative course suppression, positive-only yaw/rate headroom gate, body-speed
terminal horizon, and smooth limiter. Change only the terminal steering
prediction. Far from capture, use the parent's instantaneous heading-rate
projection unchanged. As the existing distance/body-speed cap shortens the
look-ahead, continuously blend toward a bounded projection of the observed
windowed body-frame bearing rate. Improving bearing then releases unnecessary
turn, while worsening bearing retains corrective authority; because the rate
already includes rotation and translation, this is course/slip-aware without
assigning a direction to moment or crossflow.

This is one state-feedback mechanism change rather than scalar tuning. The
next CFD rollout falsifies it if capture or the diagonal topology is lost, if
arrival exceeds the `45.260` uncapped reference without a compensating load
reduction, if mean distance materially exceeds `1.7146L`, or if it recreates
the inherited below-target collision. A fixed-snapshot improvement would not
establish robustness to changed wake phase, inflow, geometry, target, or
capture radius.

bookshelf_consulted: true
source_domain: biological response-gated redirect and closed-loop robotic-fish CPG path following
source_mechanism: release a redirect into rhythmic tracking according to observed target geometry and whole-course response
transferable_invariant: preserve the established propulsive rhythm and reduce optional redirect only when measured body-frame course evolution confirms that the target bearing is converging
nontransferable_details: published gains, species-specific burst kinematics, robot linkage geometry, dimensional speeds, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: retain the distance/body-speed terminal horizon and blend its bounded heading-rate bearing projection toward a bounded windowed bearing-trend projection only as that horizon shortens; feed the result through the existing two-joint half-cycle law
falsification: reject if capture or diagonal topology is lost, mean distance or arrival regresses without lower load, or terminal course feedback increases joint-limit contact or hydrodynamic load
