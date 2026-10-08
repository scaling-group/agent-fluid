# Bidirectional phase-local speed-headroom candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and moving-window transport
  that inserts inertially still fluid. All four capture. There is therefore no
  failed termination in the sampled set; the informative contrast is route
  quality and actuator viability rather than termination class.
- I inspected the combined top-down/oblique sheets for the unguarded assigned
  parent, the best finite bidirectional sample, and the slower posterior-biased
  one-way sample from release through capture. All show forward translation
  with a coherent alternating red/blue mid-plane street and compact alternating
  three-dimensional Lambda2 structures behind the caudal region. None shows a
  standing wiggle, collision, wake collapse, or terminal coast. The traces
  confirm self-propulsion: peak body speed is `1.37--1.40U` while peak sampled
  local flow is only `0.031--0.033U`.
- The assigned unguarded soft-envelope parent captures fastest at `16.943T`
  with mean distance `2.08985L`, but both joints sit exactly at the
  `260 deg/T` speed stops for `3.73/3.54%` of the trace. The one-way
  anterior-to-posterior high-onset allocator removes exact contact but regresses
  to `17.035T`, mean distance `2.09268L`, and score `-0.207429`.
- In contrast, the byte-identical bidirectional sample was evaluated twice and
  deterministically captures at `16.988T`, improves mean distance to
  `2.08931L` and score to `-0.204764`, and stays below both speed limits at
  `258.91/259.19 deg/T`. Its peak force/yaw-moment coefficients
  (`0.03634/0.01804`) remain close to the parent's `0.03609/0.01766`, while
  posterior angle use falls from `0.5907` to `0.5700 rad`. The unchanged visual
  wake and improved mean route distinguish useful phase-local work recovery
  from added carrier drive.

## Single-candidate policy hypothesis

Promote the sampled bidirectional high-onset speed governor and cross-joint
carrier-work allocator as the sole candidate. Preserve the evidenced
zero-centered anterior oscillator, posterior traveling-wave lag, body-frame
velocity-course steering, terminal posterior acceleration reserve, soft
acceleration shoulder, and posterior stopping-risk projection. When a speed
guard removes only positive-power acceleration in the last normalized speed
shell, offer a bounded part to the phase-separated receiver: anterior donor
work follows the agreeing posterior carrier direction, and posterior donor
work enters only an anterior stroke already doing positive work. Receiver
speed and acceleration headroom gates keep the transfer inside both actuator
envelopes.

This tests reproducibility of a semantic improvement already supported by two
identical sampled evaluations, rather than tuning an unevidenced scalar. Expect
capture, coherent alternating shedding, no exact speed contact, score no worse
than `-0.204764`, mean distance no worse than `2.08931L`, and posterior angle no
larger than `0.5700 rad`. Falsify the promoted mechanism if capture or wake
coherence is lost, either joint reaches `260 deg/T`, score/route regress beyond
the one-way sample, or force/yaw moment materially exceed `0.03634/0.01804`.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: retain a posterior-emphasized traveling bend while state feedback modifies only bounded phase-compatible rhythmic work
transferable_invariant: preserve wave direction and oscillator phase while redirecting only actuator-unavailable positive work into a phase-separated receiver with measured headroom
nontransferable_details: published gains, dimensional beat frequencies, species-specific envelopes, full-body kinematics, external clock phase, exact vortex timing, and task-specific routes
policy_translation: use normalized joint speed and joint-state power sign to guard the final speed shell, then allocate bounded removed acceleration into the compatible other-joint stroke without changing normalized body-frame target-course feedback
falsification: reject if capture or alternating three-dimensional shedding is lost, exact speed contact returns, route metrics regress beyond the one-way sample, or load and posterior-angle bounds are exceeded
```
