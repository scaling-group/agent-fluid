# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the common held-fish release condition: four
  developed and interacting vortex streets occupy the diagonal target corridor
  while the fish is held near the upper-right boundary. It is common
  initial-condition evidence, not candidate-specific wake-phase or route
  information.
- All four sampled solvers are finite captures. The assigned parent and two
  functionally identical samples reproduce `target_reached` at `44.121`,
  `1.70618L` mean distance, and score `0.173450`. Their released sheets show a
  zero-centered traveling bend immediately generating a body wake as the fish
  swims diagonally down-left through the merged cylinder wakes without contact.
  Mean body-x velocity is `-0.2470` versus `-0.1848` mean local flow, so the
  useful route is self-propelled rather than passive advection.
- The earlier time-to-go-only sample follows the same broad route but makes a
  deeper terminal trough. Relative to it, the parent's near-target body-course
  damper improves arrival/mean distance from `45.221/1.71458L` to
  `44.121/1.70618L` and lowers force/moment RMS from `439/4345` to `389/3909`,
  at a modest mean-command-energy increase from `1030.39` to `1036.49`.
  Preserve this independently additive course residual and the far/middle gait.
- Two inherited step-17 evaluations both retained capture but visually
  deepened the terminal excursion and regressed the parent. Strengthening the
  course damper by positive normalized closure reached at `45.689` with
  `1.71923L` mean distance and score `0.161543`; one-sided arbitration that
  attenuated opposing heading response reached at `45.331` with `1.72584L` and
  `0.154397`. Their force/moment RMS (`396/3917` and `413/4089`) did not provide
  a compensating load benefit over `389/3909`. This candidate therefore does
  not change route-cue algebra or course authority.
- The parent and both inherited variants touch the exact `4.537856` joint-rate
  cap on both joints while peak commanded accelerations remain near the
  candidate's soft limit. This makes residual-only actuator headroom a
  testable mechanism. It does not prove that rate contact causes the remaining
  terminal excursion, so the base traveling wave must not be gated.

## Policy hypothesis

Add one compact mechanism: independent oscillator-normalized rate-headroom
gates on the existing anterior and posterior half-cycle steering residuals.
Each gate smoothly withdraws only optional turn acceleration as its joint rate
approaches the natural gait-rate reference, retains a nonzero steering floor,
and leaves the zero-centered propulsive accelerations unchanged. Preserve the
time-to-go heading cap, additive near-target body-course damper, yaw-magnitude
gate, positive-closure/course posterior allocator, posterior lag, and soft
acceleration limiter.

Expected evidence is preserved first-crossing capture and diagonal wake-entry
topology with reduced rate-cap contact, command effort, or hydrodynamic load,
without delaying arrival or worsening mean distance materially. Reject the
mechanism if steering weakens enough to deepen the terminal trough, lose
capture, or regress arrival/mean distance without a material effort or load
benefit; also reject it if rate contact is unchanged, because that would show
the base wave rather than the steering residual owns saturation. Success on
the fixed prewarm snapshot would not establish changed-wake robustness.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and residual control
source_mechanism: preserve a rhythmic gait while bounded state feedback modulates only the steering residual
transferable_invariant: keep the propulsive oscillator intact and use oscillator-normalized joint-rate headroom to withdraw optional turn effort before actuator saturation
nontransferable_details: published CPG gains, dimensional joint-rate limits, robot or species kinematics, exact vortex phases, cylinder or target coordinates, capture geometry, and task-specific routes
policy_translation: apply separate smooth rate-headroom gates with nonzero floors to the two half-cycle acceleration residuals, leaving the normalized body-frame route law and base two-joint traveling bend unchanged
falsification: reject if capture or diagonal topology is lost, the terminal trough deepens, arrival or mean distance regresses without material load or effort relief, or joint-rate cap contact remains unchanged
