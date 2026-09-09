# Phase 2 wake-policy candidate notes

## Evidence diagnosis

- All four sampled rollouts satisfy the experiment contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders, finite dynamics, and
  `capture` termination.  Thus there is no sampled failure sheet to contrast;
  the useful comparison is the best finite repeat against the weakest-score
  finite capture, with inherited left-exit misses supplying the failure
  boundary.
- In both top-down and oblique rows, every sampled controller self-propels
  rather than being advected.  From the initially quiescent field it develops
  the same compact, alternating, three-dimensional wake by `4T`, continues a
  productive down-left trajectory through `8--12T`, and reaches the target
  without wake breakup, collision, domain exit, or visible vertical escape.
  The similar wake topology across policies says the carrier should remain
  untouched.
- The byte-identical unified response-and-geometry policy captured twice:
  `solver_e0a2513d969f` at `15.5008T` with score `-0.02109` and distance
  integral `1.90236L`, and `solver_a92c5ea643fa` at `15.6625T` with score
  `-0.02425` and integral `1.90582L`.  The geometry-qualified tail-release
  sibling `solver_64ab25982638` captured at `16.0270T`, while the prefilled
  always-pulse response-release policy `solver_d32fb3a02de7` captured at
  `15.9830T`.  All four had zero joint dwell beyond `40 deg`, but occupied the
  near-rate band for roughly `17--18%` of samples and reached the acceleration
  cap; their peak planar force/moment remained in the compact
  `0.0342--0.0366/0.0173--0.0180` class.
- Terminal phase remains variable even among captures.  The identical unified
  policy crossed once with velocity `(-1.286,-0.014)U` and heading `0.259rad`,
  and once with `(-1.162,-0.534)U` and heading `0.765rad`.  The inherited bank
  also reports identical-controller misses in the `1.01--1.22L` band followed
  by left exit.  Raw target bearing rotates with beat-scale body yaw, whereas
  the cross and dot products of body-frame target and velocity are invariant
  to that common rotation.  This supports changing the terminal observation,
  not the successful carrier or its gains.

## Policy hypothesis

Start from the sampled unified response-and-geometry handoff.  Preserve its
far-field navigation, oscillator, posterior lag/pulse, carrier-separated yaw
response, and common release gate.  For terminal mean bend and pulse direction,
smoothly move from raw pursuit at low speed or non-closing motion to signed
constant-course predicted miss as speed and closing alignment become reliable.
This is one observation/feedback mechanism: carrier-insensitive terminal
interception.  It should suppress beat-phase steering reversals near capture
without braking propulsion or changing the direct route.  Reject it if formal
evaluation loses capture, repeats the inherited left-exit miss band, changes
the compact wake/direct trajectory, increases joint-limit occupancy or loads,
or merely lowers effort without semantic improvement.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking
source_mechanism: sensor feedback modulates a low-dimensional rhythmic generator while the propulsive oscillator remains autonomous
transferable_invariant: separate the carrier rhythm from task feedback and base steering handoff on an observation that does not inherit the carrier phase
nontransferable_details: published CPG gains, oscillator timing, robot geometry, species kinematics, and source-task routes
policy_translation: retain the two-joint state-feedback carrier and blend normalized body-frame pursuit toward rotation-invariant target/velocity predicted miss only when measured speed and closing alignment make that estimate reliable
falsification: reject on loss of capture or direct-route wake coherence, recurrence of the 1.01--1.22L left-exit miss, or worse joint-rate and force/moment quality
