# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- Every sampled rollout uses direct uniform initialization in still water with
  `U_infinity=[0,0,0]`, no cylinders, no prewarm snapshot, and no numerical
  instability. In the strongest finite sample (`3.691L` minimum), the
  top-down row shows a persistent alternating caudal street and the oblique
  row shows discrete three-dimensional Lambda2 structures through the
  approach. The fish is self-propelled, but the visible trajectory passes
  below the target and exits the lower boundary with about `3.05 rad` of full
  head-relative target error. Propulsion is useful; route recovery is absent.
- The prefilled posterior half-stroke policy is weaker (`3.909L`) and has the
  same lower-going topology. Combining anterior and posterior half-cycle
  selection improves the minimum to `3.691L`, but its full target error is
  still `1.364 rad` at closest approach. Its anterior command is already
  acceleration-clipped for about `68%` of samples, so another phase-residual
  gain increase is not a distinct or credible source of yaw authority.
- Two inherited rear-aware variants keep the full target error active after
  abeam yet reproduce the `3.691L` minimum and still exit low at about
  `33.6T`; their full errors remain about `2.54--2.55 rad` at exit. This is a
  semantic repair without a trajectory repair, so full-angle gating alone is
  not enough.
- The inherited terminal curvature-capture trial is the informative failure.
  It suppresses anterior self-excitation and further unloads the tail inside
  `6L`. Its top-down wake becomes nearly steady and its oblique Lambda2
  structures fade after the maneuver starts. Joint rates and actions decay
  toward zero, forward speed rises through an inertial coast, the minimum
  worsens to `4.145L`, and lower-boundary exit advances to `27.79T`. A terminal
  maneuver must not remove the rhythmic carrier that supplies controllable
  hydrodynamic authority.
- The sampled whole-body gait's force/moment peaks remain near `0.032/0.016`
  and its reported rate-cap occupancy is about `13.7/5.5%`. The new test should retain
  that early envelope and must not claim same-worker CFD evidence.

## One candidate hypothesis

Start from the sampled `3.691L` whole-body half-cycle gait and retain it
exactly outside the near-target, large-error regime. Use the full signed angle
from normalized `target_body_L` so a target behind the head is not mistaken
for alignment. Inside `5L`, smoothly exchange the already saturated anterior
phase residual for a one-sided oscillation envelope: shift the anterior center
toward the requested bend while reducing its oscillation amplitude by the
same angular increment. This keeps the target-side excursion within the
existing envelope, removes part of the cancelling excursion, and—unlike the
failed terminal trial—keeps Van der Pol self-excitation and the lagged
posterior wave active. No extra tail relief is added.

The falsifiable expectation is unchanged early motion and wake formation,
followed by a still-oscillatory target-side curvature bias before the sampled
miss. Reject the mechanism if the pre-`5L` trace changes, closest approach
does not beat `3.691L`, full error does not fall below `1 rad`, the wake or
joint cycle collapses into coasting, the same lower exit persists without
earlier target-side yaw, or saturation and loads materially exceed the sampled
envelope.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG amplitude and offset modulation combined with biological burst redirection
source_mechanism: persistent direction error reshapes a rhythmic bending envelope toward one side while sensor feedback releases the asymmetry on alignment
transferable_invariant: trade the cancelling side of a propulsive cycle for bounded target-side curvature without extinguishing the autonomous traveling rhythm
nontransferable_details: published gains, clock-driven phase, robot linkage geometry, species-specific envelopes, prescribed maneuver timing, exact vortex phase, and task-specific routes
policy_translation: normalized distance and full body-frame target angle smoothly shift the anterior oscillator center and reduce its amplitude by the same amount while joint state retains phase and drives the lagged posterior carrier
falsification: reject if the early wake changes, the 3.691L minimum or 1 rad error boundary is not improved, cyclic joint motion decays into coasting, the lower exit remains without earlier target-side yaw, or rate and load envelopes worsen materially
