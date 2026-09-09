# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled solvers and the two inherited failures used direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. The visible translation and wake are therefore released-swimmer
  dynamics rather than background advection.
- I inspected both rows of the combined keyframe sheets for the strongest
  sampled speed-reserve capture and the latest inherited capture-hold failure.
  Both show sustained self-propulsion, an alternating top-down vortex street,
  and compact oblique Lambda2 structures. The capture crosses at `0.7494L`
  after `18.601T`; the failure retains its traveling wake through a `1.4597L`
  lower pass and exits at `10.4685L`. The failure is terminal path geometry,
  not carrier collapse, advection, or instability.
- The sampled set contains two exact speed-reserve baseline captures at
  `0.7466--0.7494L` and two posterior-wave captures at `0.7480--0.7492L`.
  Inherited exact replays sharpen the distinction: guidance records four
  baseline captures, whereas the posterior wave-shape mechanism fell to `3/5`
  after lower exits at `1.2589L` and `1.3584L`. The prefilled posterior policy
  is therefore compatible with capture but not repeat-backed improvement.
- The assigned parent's next capture-corridor release floor also missed below
  at `1.4597L`. At closest pass it was still self-propelling near `0.823L/T`,
  with target/velocity alignment already negative and reconstructed projected
  miss about `1.43L`. This falsifies treating instantaneous projected-corridor
  membership as a safe reason to relax additive steering; widening that gate
  or tuning only its release fraction would repeat the same unsupported idea.
- Successful baseline approaches are geometrically diverse: the two sampled
  captures reach the boundary with reconstructed projected miss about
  `0.24L` and `0.73L`, target/velocity alignment about `0.95` and `0.23`, and
  speed about `0.86` and `0.83L/T`. Their active wakes and broad far-field
  closure argue for preserving the full evaluated carrier, achieved-course
  route error, intercept veto, additive steering, and sparse outward-carrier
  reserve as one coupled mechanism.

## One candidate hypothesis

Restore the exact evaluated
`dogfish3d_intercept_guarded_speed_reserve_v1` policy bytes. This removes only
the prefilled posterior wave-shape perturbation and does not add scalar tuning
or stack a new terminal residual. The candidate preserves the state-feedback
traveling bend, normalized body-frame achieved-course steering, interception
guard, and actuator-state carrier reserve that own the strongest repeat record.

Expected test: recover the baseline capture class while retaining the coherent
top-down and oblique wakes and remaining inside its sampled actuator and load
envelope. Falsify this reversion if a new exact replay exits, weakens the
traveling wake, or establishes that baseline capture reliability is no better
than the `3/5` posterior policy. Later workers should require repeat evidence
before trying a new geometry-gated yaw/slip mechanism; they should not answer a
miss by weakening steering, altering carrier phase, or tuning a failed scalar.

bookshelf_consulted: true
source_domain: classical undulatory propulsion and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve a posterior-lagged traveling bend while bounded target-geometry feedback supplies route correction
transferable_invariant: an active propulsive wave and closed-loop steering should remain separate, and terminal scheduling must not erase or phase-perturb the carrier without repeat evidence
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, exact vortex phase, prescribed paths, and task coordinates
policy_translation: retain the evaluated joint-state traveling bend and normalized body-frame achieved-course/intercept controller, including only sparse actuator-state relief of outward carrier effort near the envelope
falsification: reject if exact replay loses capture, changes far-field closure or either wake view, or leaves the sampled baseline force, moment, clipping, or speed-limit envelope
