# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis

- All four sampled runs satisfy the experiment contract: direct uniform
  still-water initialization at `U_infinity=(0,0,0)`, no cylinders, and
  capture termination. The empty initial wake followed by an alternating
  mid-plane vortex street and paired three-dimensional Lambda2 structures
  shows self-propulsion rather than advection.
- The combined top-down and oblique sheets show the same useful topology in
  all four runs: an early target-directed redirect, a coherent traveling wake
  by `12T`, and continued propulsion through capture near `23.8T`. No sampled
  run is a semantic failure; the least successful finite comparison is the
  v26 half-cycle-only terminal curvature run.
- v26 reduces mean absolute yaw rate inside `3L` from v24's `1.6839 rad/T` to
  `1.6162 rad/T` and peak yaw from `3.2076` to `2.9910 rad/T`, but weakens
  approach speed and delays capture from `23.8315T` to `23.9085T`; its mean
  distance also worsens from `2.434073L` to `2.434609L`. Removing the
  continuous course bend is therefore not justified.
- The inherited-log child v29 adds a posterior, tail-side-selected counter-
  tangent while retaining the continuous course bend. It improves arrival to
  `23.7930T` and mean distance to `2.433953L`, but raises inside-`3L` mean and
  peak absolute yaw to `1.7057` and `3.2886 rad/T`, and raises peak absolute
  moment from v24's `0.01409` to `0.01512`. This intervention supports the
  causal relevance of observed posterior side, but rejects strengthening that
  side with another counter-tangent as a clean yaw/load remedy.
- v25's hard course/yaw consensus has the best sampled scalar score
  (`-0.5357785`) but arrives later than v24 and changes mean distance and yaw
  only negligibly (`23.8590T`, `2.434115L`, `1.6827 rad/T`). The assigned
  parent guidance already rejects another cue-arbitration gate. The policy
  should return to the continuous v24 course bend and test a different
  posterior actuator primitive.

## Candidate hypothesis

Retain the evaluated v24 carrier, response-released C-bend, smooth command
projection, and continuous target-relative terminal course correction. Add one
small mechanism: when carrier-rejected excess yaw is present inside `3L`, use
the observed posterior tangent side to reduce the oscillatory posterior target
only on the yaw-supporting half-cycle. This state-derived amplitude relief
should preserve the anterior oscillator and opposite posterior power stroke
while reducing terminal yaw impulse rather than adding another tangent offset.

Falsify the mechanism if capture is lost, arrival or mean distance regresses
to the v26 range, the alternating wake weakens, posterior limit exposure grows,
or terminal mean/peak yaw and moment fail to improve relative to v24. A useful
result must retain capture and the v24-scale distance integral while lowering
at least one yaw/load diagnostic without materially worsening the others.

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and Lighthill posterior reactive-thrust control
source_mechanism: infer beat side from joint state and apply bounded half-cycle amplitude asymmetry at the posterior propulsor
transferable_invariant: preserve a traveling bend while changing only the posterior half-cycle that supports the unwanted turn
nontransferable_details: published gains, dimensional cadence, species envelopes, exact vortex phase, and task-specific routes
policy_translation: normalized carrier-rejected yaw selects demand; observed q1+q2 selects tail side; a bounded near-target gate relieves only the oscillatory posterior target
falsification: reject if capture or coherent wake is lost, approach metrics regress toward v26, or yaw/load does not improve over v24
```
