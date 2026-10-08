# Candidate wake-policy diagnosis

## Evidence read before editing

- All four sampled rollouts use `uniform_direct` initialization with zero
  background velocity and terminate in capture.  The three independently
  written v33 bidirectional-allocation policies are dynamically identical:
  each captures at `18.766 T`, scores `-0.170272`, and has distance integral
  `2.058347 L`.  Their combined keyframe sheets are byte-identical.
- In both the v32 and v33 combined sheets, the top-down row progresses from
  quiescent release to a coherent alternating wake by `4 T`; the street stays
  attached to a smooth target-directed arc through `8`, `12`, and `16 T`.
  The oblique row shows compact alternating three-dimensional structures and
  a continuous traveled centerline, not passive advection, a standing wiggle,
  or wake breakup.  The target is approached from above-right in both cases.
- Relative to the v32 closing-response capture (`18.755 T`, score
  `-0.171145`, integral `2.058863 L`), full-route posterior-to-anterior
  spillback changes nothing through `4 T` and then trails by `0.0031 L` at
  `12 T`, `0.0177 L` at `16 T`, and `0.0119 L` at `18 T`.  It delays capture
  by `0.011 T`, while slightly improving the integral by `0.000516 L`, lowering
  maximum speed from `0.9492` to `0.9402 L/T`, and lowering any-joint
  acceleration-limit residence from `41.96%` to `41.35%`.  Peak normalized
  force and moment remain unchanged at about `0.03068/0.01564`.  This is a
  terminal-route/saturation tradeoff, not a demonstrated cruise-closure gain.
- The inherited fitted posterior rate common mode is the informative negative
  boundary: it reversed the useful arc, exited at `8.476 T`, and finished
  `12.7296 L` away (sampled score `-15.2248`).  The candidate therefore does
  not add another rate fit, retune the carrier, or reinterpret wake phase.

## Policy hypothesis

Preserve the evaluated oscillator, posterior lag, raw half-cycle phase,
whole-wave observation projection, closing-response cadence release, and
componentwise bounds.  Apply posterior-to-anterior spillback only in the
existing normalized approach regime (`1 - distance_L / approach_distance_L`,
clamped to `[0,1]`).  This should retain the v32 cruise lead until the target is
within `2.1 L` while keeping a bounded share of the v33 terminal steering
redistribution.  It is one structural test: distance-conditioned residual
allocation, with no scalar carrier or route-gain tuning.

Falsify the hypothesis if the rollout loses capture, fails to improve the
v33 score/distance integral or the v32 arrival time, changes the established
target-signed arc or coherent alternating wake, increases any-joint limit
residence above about `42%`, or materially exceeds the observed
`0.95 L/T`, `0.0307` force, or `0.0157` moment envelope.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish gait control and terminal target capture
source_mechanism: separate near-target feedback regime with bounded state-conditioned gait modulation
transferable_invariant: preserve a productive traveling wave and activate the smallest corrective residual only in the regime whose evidence supports it
nontransferable_details: published CPG gains, species kinematics, dimensional cadence, exact wake phase, and task-specific routes
policy_translation: multiply only rejected posterior target steering returned to the anterior joint by a clamped normalized distance-to-target approach gate
falsification: reject if capture, cruise closure, wake coherence, saturation, speed, force, or moment crosses the evidence bounds stated above
