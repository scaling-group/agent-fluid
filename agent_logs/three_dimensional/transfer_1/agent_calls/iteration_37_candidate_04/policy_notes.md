# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts satisfy the experiment contract: direct uniform
  initialization, `U_infinity=(0,0,0)`, no prewarm, no cylinders, and
  `capture` termination at `0.7492--0.7499L` after `18.45--18.75T`.
- The combined sheets for the best-scoring outer-bearing sample and the
  prefilled anterior-transfer sample show self-propulsion, not advection: from
  quiescent release each fish lays down a persistent alternating top-down
  vorticity street and paired oblique Lambda2 structures while turning toward
  the target. The terminal panels retain an active traveling bend; neither
  wake visibly collapses or becomes one-sided before capture. The lateral
  motion is propulsive but strongly beat-phased near the capture boundary.
- No sampled keyframe set is a failed rollout, so a visual best-versus-failure
  comparison is unavailable in this workspace. The best finite sample is
  `solver_ac993a461b7c` (`-0.14991`, capture at `18.6560T`); the slower
  prefilled mechanism sample is `solver_55f3a103ab95` (`-0.15335`, capture at
  `18.7495T`). The assigned-parent logs supply the informative semantic
  failures: steps 33, 34, and 36 exited the lower boundary after closest
  approaches of `1.4107L`, `1.1790L`, and `1.4731L`. Inherited guidance also
  records that exact repeats of bearing and spatial-allocation modifiers join
  this lower branch despite retaining coherent wakes.
- Metrics agree with the images rather than indicating a propulsion deficit.
  Sampled arrival speed is about `0.87--0.90L/T`; action clamps on
  `68.46--68.76%` of anterior rows and `70.64--71.00%` of posterior rows;
  speed-limit residence is `10.41--10.82%` and `11.38--11.67%`. Fixed spatial
  transfer and outer-bearing qualification do not improve that envelope.

## Control diagnosis

The response gate uses a target-to-head vector but estimates inertial LOS rate
with center velocity. This mixes two material points exactly where success is
defined by head crossing. Reconstructing head LOS rate from the sampled
trajectories changes the sign of the center-velocity surrogate on
`38.2--50.2%` of rows between `4L` and capture, with an RMS discrepancy of
`0.203--0.237 rad/T`. That is a feedback-semantic defect, not evidence for
another steering gain, bearing residual, or anterior/posterior reallocation.

## Single candidate hypothesis

Restore the exact intercept-guarded speed-reserve allocation sampled twice as
successful here, preserve its traveling bend and all evaluated gains, and
replace only the LOS-rate observation used by the response-release veto. When
available, differentiate the normalized body-frame target-to-head vector via
`target_body_rate_L` and add measured body rotation analytically; otherwise
retain the old center-velocity fallback. The resulting rate is tied to the
same head point used by `distance_L` and the capture rule. It should reject
false steering release caused by carrier-phase center/head disagreement while
leaving far-field closure, propulsion, and joint allocation unchanged.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and biological burst redirect
source_mechanism: preserve the propulsive rhythm while releasing bounded turning only after observed directional response
transferable_invariant: steering release should follow measured goal-relative response at the controlled point while the traveling bend remains active
nontransferable_details: published gains, oscillator frequencies, species-specific burst kinematics, actuator layouts, exact phases, and routes
policy_translation: retain the two-joint state-feedback carrier and steering allocation; replace the terminal LOS veto with normalized target-to-head kinematics already present in the observation
falsification: reject if repeated CFD does not improve semantic capture reliability, retains the lower-pass topology, weakens either wake, or worsens arrival, clipping, speed residence, force, or moment beyond the sampled baseline envelope
