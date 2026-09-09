# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet confirms the common initial condition: the held fish
is above and downstream of the target while four interacting vortex streets
are already developed.  In every released sheet the fish then self-propels
upstream into the disturbed region rather than being passively advected.  For
the sampled `0.50` opposing-headroom policy, mean head velocity is about
`-0.174` while mean local flow is `-0.123`, and the head travels `-12.28L`.
The sheet shows the fish passing above the target before a coherent upward hook
and top-boundary exit.  The hook is a route failure, not a collision or
numerical instability, and it develops while the body is embedded in the
visibly unsteady wake.

The isolated headroom bracket remains the far-field anchor.  Raising its gain
from `0.35` to `0.50` improved head-x travel from `-11.33L` to `-12.28L` and
closest approach from `3.03L` to `2.13L`, although progress stayed near
`0.51`, both joint rates and commands reached their caps, and RMS force/moment
rose from `511/5305` to `535/5416`.  The prefilled close-only continuation to
`0.55` does not survive its own evidence: it changes travel to `-12.66L` but
worsens closest approach to `2.21L`, raises RMS force/moment to `566/5660`,
and produces the same visible hook and upper exit.  This closes further
headroom-strength increases, including distance-localized ones.

Inherited receding-distance, fore-aft, bearing-rate, lateral-motion, and
posterior-target-clipping tests likewise lost approach or propulsion without
changing the upper-exit topology.  Those results argue against stacking
another recovery gate or actuation envelope on the approach anchor.  Across
the current samples, however, local body-frame crossflow has RMS
`0.301--0.306` with only `-0.024` to `-0.031` mean, so it is a large signed wake
disturbance rather than a route bias.  It is also distinct from the inherited
relative-slip and body-lateral-speed terms that were already falsified.

## Single candidate hypothesis

Restore the complete sampled `0.50` opposition-headroom policy and remove the
failed close `0.55` increment.  Add one bounded term to the posterior steering
command that opposes measured local body-frame wake crossflow.  Scale the
crossflow by `0.30`, the observed RMS range, and limit its contribution to
`0.20` of the normalized steering command.  This leaves the anterior
oscillator, posterior traveling-wave target, static bearing request, phase
allocation, and acceleration cap unchanged.  The term has nearly zero mean in
the sampled episodes, uses no prescribed inflow, remote probe, coordinate,
elapsed time, or case-specific route, and should reject wake-driven lateral
excursions without adding another static steering bias.

The next CFD result supports the hypothesis only if it preserves roughly the
`0.50` anchor's `-12.28L` upstream leg while improving on its `2.13L` closest
approach, changing the upper-hook topology, or materially reducing lateral
crossflow/load response.  It is falsified if it weakens upstream propulsion,
repeats the same upper exit with no approach or load benefit, or reacts to the
oscillatory crossflow by increasing command/load saturation.  In that case
later workers should restore the unaugmented `0.50` anchor and avoid treating
instantaneous local crossflow as a steering-error surrogate without first
demonstrating a slower or phase-selective wake signal.
