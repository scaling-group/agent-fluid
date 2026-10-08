# Candidate diagnosis and hypothesis

## Evidence read before editing

Only one sampled solver is available, so its finite released prefix is also the
best finite example and its termination is the informative failure.  The shared
prewarm sheet shows the held fish above/right of four interacting, fully
developed vortex streets; this is common initial-condition evidence.  In the
released sheet, the naive seed produces a visible traveling body wave and moves
under its own actuation, but it curls from the initially useful down-left
heading into an almost vertical dive.  It never enters the target/cylinder-row
region and leaves the lower domain after only 50.13 release-time units.

The scalar diagnostics agree with that reading: head displacement is
`(-3.55, -13.30)L`, minimum distance improves briefly to `8.61L` but final
distance returns to `12.12L`, and progress is only `0.024`.  The oscillator
runs about `32.8` times the estimated shedding frequency, reaches approximately
the joint velocity/acceleration envelope (`4.54 rad/time` and
`31.42 rad/time^2`), and expends `75002` command-energy units.  RMS relative
crossflow `0.175`, lateral force `21.94`, and moment `541.7` accompany the
failure, but the compact evidence does not give sign-resolved histories that
would justify a crossflow or moment compensator yet.

## Policy hypothesis

Preserve the seed's useful state-feedback traveling bend, but slow and narrow
the saturated rhythm enough to leave steering authority.  Center that rhythm
on a bounded mean-curvature request computed from body-frame target bearing,
and damp the request with normalized measured heading rate.  Apply compatible
mean bend to both joints while retaining posterior lag/emphasis.  This adds the
missing target-referenced capability without a world-frame route, clock, fixed
cylinder coordinates, or uncalibrated vortex-phase response.

Expected falsification: reject this translation if the target bearing grows
immediately while the fish repeats the downward-exit topology (wrong curvature
sign or inadequate authority), if joint saturation remains persistent, or if
leftward progress collapses because the mean bend suppresses propulsion.  A
finite horizon miss with substantially smaller final/mean distance and no
domain exit would be a semantic improvement even before capture.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical undulatory propulsion
source_mechanism: target-driven mean-curvature bias superposed on a posterior-lagged traveling bend
transferable_invariant: use slow body-frame target error to bias average curvature while preserving directional posterior phase lag for thrust
nontransferable_details: published gains, species envelopes, clocked CPG phase, exact Strouhal bands, vortex phases, and task-specific routes
policy_translation: map bounded body-frame bearing and measured heading rate to two joint-center biases; keep a state-encoded anterior oscillator and lagged posterior target
falsification: target error or the same downward exit persists, thrust/progress collapses, or joint/load saturation remains dominant

## Lightweight post-edit checks

The repository unit suite passes all `147` assertions.  A joint-only envelope
sweep (not CFD) with the formal `45/140/900` degree limits produced the expected
opposite mean bends for symmetric bearings.  At the approximately `+0.15 rad`
initial target error, command clipping occupied `1.8%` of joint samples over 12
time units, rather than remaining persistently saturated.  This only validates
the feedback contract and steering allocation; the later formal rollout must
still decide navigation quality.
