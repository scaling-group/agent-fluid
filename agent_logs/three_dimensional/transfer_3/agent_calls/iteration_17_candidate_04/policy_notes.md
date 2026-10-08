# Intercept-residual posterior-lag candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen physical contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite moving-window dynamics, and capture at
  `25.1185226 T`. The two byte-identical v29 intercept-corridor policies also
  reproduce their coupled-flow result exactly: score `-0.5280772274`, mean
  distance `2.4290872138 L`, and final distance `0.7461352944 L`.
- I inspected both rows of the combined keyframe sheets for that reproduced
  best result and the weaker adverse-force-veto alternative. In both top-down
  rows the fish self-propels along the same compact target-directed arc and
  sheds an organized alternating wake before a quiet held-bend glide. The
  oblique rows show finite three-dimensional Lambda2 packets following the
  body path, with no passive advection, out-of-plane instability, collision,
  loop, or domain-exit precursor. The sheets are too coarse to distinguish
  their very small terminal differences, so the ranking rests on telemetry.
- The force-veto variants are useful negative evidence. Vetoing the earlier
  course-angle release scores `-0.5280861775`; applying the same measured-force
  veto to the intercept release scores `-0.5280778498`. Both retain the same
  capture step but are worse than unvetoed v29. Instantaneous adverse lateral
  force is therefore not a supported extra condition for the already-bounded
  terminal response in direct still water.
- The reproduced v29 trajectory enters the `1.6 L` response band with
  velocity-to-target error about `0.443 rad` and predicted cross-track miss
  about `0.685 L`; both contract monotonically to about `0.310 rad` and
  `0.228 L` at capture while speed stays in `0.646--0.654 L/T` and closure in
  `0.674--0.713 L/T`. Commands below `1.6 L` remain bounded at about
  `0.0977/0.2461 rad/T^2`, with peak force norm `0.002193` and peak moment
  `0.000565`. The wake and mean redirect should therefore be preserved. The
  remaining testable deficiency is the signed course residual before the
  intercept corridor is achieved, not insufficient release authority.

## Policy hypothesis

Preserve v29's state-feedback oscillator, base posterior lag, target-angle
mean-curvature redirect, closure preview, two-joint terminal equilibrium,
helpful-crossflow response gate, `3.5%` paired-release budget, and all command
limits. Add one complementary approach-hold mechanism: while proximity,
positive closure, helpful crossflow, and settled response support the late
controller but predicted miss remains outside the achieved corridor, align the
signed body-frame angle from target direction to measured velocity with the
existing target-derived redirect sign and use that reflection-invariant scalar
to make a small bounded adjustment to the posterior carrier lag. Fade the
adjustment to zero as intercept support reaches one; the inherited paired
release then acts alone. This changes wave shape rather than static curvature,
carrier authority, beat-side gain, or a world-frame route.

Expected result: exact v29 commands outside the inherited late response regime,
unchanged shared bend and release budget, a small independently active
posterior-lag correction during intercept acquisition, and exact return to the
base lag once the compact corridor is achieved. Reject it if replay finds the
gate dormant, unbounded, or active without closure/helpful crossflow; if it
changes outer commands or final full-support commands; or if later CFD delays
or loses capture, increases predicted miss or distance, restores joint stops,
saturation, load growth, instability, or degrades either wake view.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking and two-joint traveling-wave steering
source_mechanism: modulate posterior phase lag from measured direction error while preserving the rhythmic carrier and its mean steering offset
transferable_invariant: when a proven traveling bend and mean redirect already close range, a bounded turn-aligned phase-lag residual can correct approach direction and should vanish after measured translation achieves the intercept
nontransferable_details: published phase offsets and gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phase, capture radius, and task-specific routes
policy_translation: normalized body-frame target and velocity vectors define signed course error, whose product with target-derived redirect sign is reflection-invariant; late proximity, positive closure, helpful relative crossflow, settled two-joint response, and complement of predicted-miss support gate a small posterior-lag adjustment while mean bend and paired-release authority remain fixed
falsification: reject if the residual gate is inactive or changes the outer or achieved-intercept regimes, if it changes shared mean or release authority, or if capture, miss, distance, joint clearance, saturation, loads, stability, or wake coherence regress

## Non-CFD implementation audit

- The lightweight Julia contract returns two finite commands. The candidate's
  returned parameter object owns all directly referenced policy fields,
  including both new posterior-lag controls.
- Replay against all `4,567` stored states from the reproduced v29 rollout
  activates the correction on 184 of 226 states below `1.6 L`, from about
  `1.598 L`/`0.685 L` predicted miss through `0.910 L`/`0.301 L` miss. It is
  exactly command-invariant at and beyond `1.6 L` and whenever intercept
  support is full. The gate peaks at `0.4293`; the effective lag adjustment
  peaks near `0.0301` against the `0.8` base, and the posterior command change
  peaks near `0.000329 rad/T^2` with the anterior command unchanged. A mirrored
  active-state audit confirms that the new residual itself changes sign with
  posterior joint motion rather than introducing a fixed turn direction.
- These checks establish finite output, active bounded feedback, outer and
  achieved-intercept noninterference, and the intended actuator locus only.
  The candidate's coupled-flow score and wake are future evaluation evidence
  and are not claimed here.
