# Terminal posterior-response candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase 2 contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and `horizon` termination at `100T`. I inspected
  both the top-down mid-plane-vorticity and oblique body/Lambda2 rows of every
  combined keyframe sheet. The fish self-propel in all four cases and retain
  coherent alternating planar wakes and compact three-dimensional structures;
  passive advection, wake collapse, collision, domain exit, and instability do
  not explain the misses.
- The inherited course-response reserve (`solver_951085a20092`) remains the
  best orbit-contraction scaffold: it reaches `1.314/4.056/3.077L`
  minimum/mean/final distance, spends about `15.94T` inside `2L` and `5.38T`
  inside `1.5L`, and uses the anterior/posterior acceleration reserve on about
  `0.249/0.103` of all states. The assigned parent's ahead-only terminal
  response bridge (`solver_34419dc4414e`) is a negative result: it reaches only
  `1.371L`, spends `5.62T` inside `2L`, and preserves the powered orbit.
- The prefilled terminal course hold (`solver_6eb170b0d70a`) does produce a
  useful late trajectory change, improving minimum/final distance to
  `1.241/2.082L`. It does not establish capture or a robust hold: mean distance
  worsens to `4.158L` relative to the unheld reserve, time inside `1.5L` falls
  to `2.87T`, and the best pass occurs only at `97.092T`. At that pass the fish
  still moves at `0.669U`, target-ray/course error is `1.692 rad`, radial
  course dot product is `-0.121`, and yaw is only `-0.129 rad/T` while both
  joints sit near a same-sign static C-bend (`-22.7/-23.9 deg`). The top-down
  and oblique sheets likewise show a coherent powered loop, not terminal
  alignment or stall.
- The sampled response bridge and broader course hold jointly close another
  same-sign equilibrium-persistence edit: one worsens the approach and the
  other only shifts the tight orbit. The remaining mismatch is dynamic turn
  response after the equilibrium bend is established. The prefill has no
  posterior command clamping inside `2L`; on its completed trace, posterior
  acceleration leads yaw acceleration with correlation about `-0.79` at
  `0.16--0.22T`. This is only an empirical sign/authority calibration, but it
  supports testing a bounded posterior response rather than more static
  curvature or scalar drive relief.

## Policy hypothesis

Preserve the full prefilled terminal-course-hold scaffold, including its
carrier, far/middle trajectory, geometry-released C-turn, response-selected
curvature reserve, terminal persistence, posterior brake, and phase lag. Add
one compact terminal actuator topology: when the fish is inside the existing
terminal distance envelope, retains finite speed, and normalized
target-ray/course dot product is tangent or receding, apply a bounded posterior
acceleration residual in the signed course-error direction. The residual
vanishes for radial closure and outside the terminal region. This converts the
observed target-relative response deficit directly into unused posterior
dynamic authority instead of increasing the already-established C-bend.

Support requires capture, a pass below `1.24L`, longer residence inside
`1.5L`, or a clearly inward terminal recovery while retaining the coherent
release and comparable load/clamp residence. Reject if the first pass changes
materially, posterior clamping or loads rise, the wake stalls or strongly
one-sides, or the same `1.2--2L` powered orbit remains without capture or
inward response.

```text
bookshelf_consulted: true
source_domain: biological burst redirects and residual control over robotic-fish rhythmic locomotion
source_mechanism: preserve the propulsive rhythm, but use measured directional response to apply and release a bounded maneuver residual rather than holding static curvature indefinitely
transferable_invariant: a large target/course mismatch with weak radial response can select transient dynamic turn authority while useful closure continuously releases that authority
nontransferable_details: published gains, species-specific burst kinematics, dimensional beat frequency, exact maneuver timing, vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target and velocity directions, distance, and speed gate a reflection-equivariant posterior acceleration residual within the two-joint state-feedback contract; all established carrier and equilibrium terms remain unchanged
falsification: reject if cruise or the first pass changes, wake coherence degrades, posterior limit/load residence rises, or no capture, closer pass, longer near-target residence, or inward terminal recovery appears
```

## Evaluation boundary

The candidate has no same-worker CFD evidence. Frozen-trace selector replay and
dry controller checks after editing can establish locality, sign, boundedness,
reflection equivariance, finiteness, and parameter ownership only. EvE performs
the coupled CFD evaluation after this worker exits.

## Implemented candidate and non-CFD probes

The candidate retains the complete prefilled controller and adds three owned
parameters for a posterior acceleration residual. The residual reuses the
existing normalized terminal distance and finite-speed envelopes, adds a
tangent/receding course-dot gate, and takes its sign from bounded course error.
It does not alter oscillator state, equilibrium curvature, wave phase, target
identity, coordinates, a route, or any environment surface.

Frozen replay on the completed prefill trace makes the selector exactly zero
to displayed precision through `12T`; through `20T` its mean/maximum weight is
`0.00059/0.00987`, and at the original `2.466L` first pass it changes posterior
acceleration by only `0.001 rad/T^2`. It adds `1.896 rad/T^2` at the
`1.641L` tangent pass, only `0.009 rad/T^2` at the radially closing `1.730L`
pass, and `2.965 rad/T^2` at the prefill's `1.241L` receding minimum. Inside
`2L`, mean/maximum absolute residual is `1.224/3.083 rad/T^2`; counterfactual
posterior action never reaches the `+/-28 rad/T^2` command reserve. These
results establish selector locality and available authority only, not an
integrated trajectory prediction.

The required material-guidance check, lightweight Julia contract, and editable
solver-boundary check pass. Mirrored terminal probes negate both actions to
within `1e-10`; zero-speed and very large finite states remain finite and
bounded by the declared command reserve. No formal CFD was run.
