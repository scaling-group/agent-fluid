# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The assigned parent preserves the `0.55`-period, `28 deg`
  posterior-lagged traveling bend, circular body-frame bearing filter, and
  bounded `12 deg` total-curvature request split `40/60` across the two joints.
  Its completed rollout reaches the `0.75L` target at `35.6895` released time
  with `1.7619L` mean distance. This is the reachability scaffold and should
  not be weakened or replaced.
- The shared prewarm sheet shows the held fish above four developed,
  interacting vortex streets. The parent and strongest distinct released
  sheets both show an early targetward redirect, an active posterior traveling
  bend, sustained self-propelled diagonal motion across the wakes, and direct
  first entry into the capture circle. Neither sheet shows collision, terminal
  overshoot, or a repeated wake-driven reversal that would calibrate a force or
  crossflow residual.
- Three sampled policies are equation-equivalent filtered `40/60` replays and
  return identical results: capture at `35.6895`, `1.7619L` mean distance,
  `50,871.28` total command energy, `59.28` lateral-force RMS, and `821.23`
  moment RMS. They establish deterministic repeatability at the common wake
  snapshot, not three independent mechanisms.
- The one genuinely distinct sample keeps the total curvature and propulsion
  unchanged but shifts up to five percentage points of curvature allocation
  from anterior to posterior as the magnitude of persistent bearing grows. It
  remains a direct capture and improves arrival to `35.0625`, mean distance to
  `1.7339L`, total command energy to `50,174.96`, force RMS to `56.57`, and
  moment RMS to `793.76`. Mean command energy and power proxy rise slightly to
  `1431.01` and `109.66`, and both joints still touch the velocity and
  acceleration limits, so the evidence supports navigation and aggregate-load
  improvement rather than actuator headroom or efficiency.
- The inherited bearing-window-rate child is the informative failure. Its
  keyframes show almost no propulsive bending before downstream domain exit;
  metrics confirm only `0.140/0.163 rad` peak joint angles, `8.64` mean command
  energy, displacement `(+2.175,-0.874)L`, and no approach inside `12.424L`.
  This candidate excludes trend feedback and preserves the full evidenced
  traveling-bend drive.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: elongated-body fish propulsion and robotic-fish mean-curvature turning
source_mechanism: preserve a directional posterior traveling wave while steering by bounded asymmetry of the rhythmic bend
transferable_invariant: when a large target-relative turn is requested, modestly posterior-weighting a fixed total-curvature budget can retain propulsive wave direction while increasing steering effectiveness
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, exact vortex phases, fixed routes, and source-specific anterior/posterior allocations
policy_translation: circularly filter normalized body-frame bearing, retain the bounded total-curvature command, and use its magnitude only to shift a small owned fraction of that unchanged command from the anterior joint to the posterior joint
falsification: reject the redistribution if capture is lost or delayed, mean distance or aggregate loads exceed the fixed `40/60` parent, the compact diagonal topology changes adversely, or held-out wake and target conditions reverse the benefit

## Candidate hypothesis

Produce exactly one evidence-selected candidate by promoting the completed
bearing-conditioned posterior-allocation controller. The policy retains the
parent's oscillator, amplitude, posterior lag, circular bearing filter, and
`12 deg` total-curvature bound. Only the allocation mechanism changes: the
aligned limit remains `40/60`, while large persistent target error smoothly
approaches `35/65` without increasing total steering bias.

The downstream evaluation should reproduce direct target capture near
`35.06` released time and `1.734L` mean distance, with lower total command
energy and lower force/moment RMS than the fixed-allocation parent. The prior
completed sample, not bookshelf gains, is the reason for selecting the exact
translation. No new CFD result is claimed by this worker.
