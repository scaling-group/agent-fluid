# Exact phase-balanced traveling-wave restoration candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts, the assigned-parent rollout, and the two latest
  inherited descendants use direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and
  `horizon` termination at `100T`. I inspected the combined top-down
  mid-plane-vorticity and oblique body/Lambda2 sheets for all four samples,
  the assigned parent, both latest descendants, and the inherited `1.175L`
  phase-balanced reference. The fish self-propels in every case and the wakes
  remain coherent, so passive advection, wake collapse, collision, domain
  exit, and instability do not explain the misses.
- The visual distinction is controller activity. The `1.175L` reference
  carries an alternating, visibly undulating wake through its tight return;
  it remains inside `1.25L` for about `2.35T` with mean absolute anterior and
  posterior joint velocities near `0.775/0.360 rad/T` inside `2L`. The four
  sampled sheets instead show a broad repeated arc with a nearly rigid
  negative C-bend. Their minima are only `2.215--2.439L`, and representative
  joint velocities are roughly `0.00004--0.003 rad/T` despite translational
  speed near `0.68U`.
- The assigned parent's response-gated posterior phase reaches
  `2.439/3.861/3.310L` minimum/mean/final distance and parks both joints. The
  inherited two-sided posterior phase-plane energy addition improves the
  parked cluster's minimum only to `2.173L`, worsens final distance to
  `3.547L`, and still has joint velocities near `0.001/0.003 rad/T` at its
  minimum. The newest phase-independent anterior turn-response residual is
  nonzero at a frozen parked state, but its coupled rollout reaches only
  `2.077/3.890/3.512L`; its top-down and oblique sheets retain the same broad,
  nearly rigid C-bend loop. A locally nonzero corrective action therefore did
  not preserve the active terminal carrier or yield a semantic improvement.
- Those results close posterior phase response, posterior phase-plane energy,
  and direct response-gated anterior acceleration as additions to this
  sensitive carrier. They also strengthen the inherited warning that frozen
  action locality is not coupled hydrodynamic locality. The only surviving
  positive mechanism is the exact symmetric anterior phase-balanced regulator
  about the moving C-turn equilibrium. This candidate restores that evaluated
  controller verbatim rather than tuning a failed residual or adding a fourth
  mechanism to the parked descendants.

## Policy hypothesis

Restore the completed `1.175L` phase-balanced policy exactly: bounded
body-frame bearing curvature, target-behind C-turn, continuous target-ray to
course hold, moving joint equilibria, symmetric two-sided anterior energy
feedback, posterior lag and wave authority, brake, wave envelope, and command
reserve. Remove the prefilled joint-state equilibrium-unbend addition and do
not retain the completed posterior-phase, posterior-energy, or direct
turn-response residuals. The test is whether returning to the last mechanism
with demonstrated active near-target motion reproduces the tight return and
avoids the common parked C-bend topology.

Support requires the coherent active return, a closest approach near or below
`1.175L`, terminal joint activity, and residence inside `1.25L` without worse
clamp/load margins. Falsify the restoration if it reproduces the sampled
`>2L` rigid C-bend, loses wake coherence, saturates persistently, or fails to
recover the evidenced near-target residence. The new coupled CFD result is
available only after this worker exits; no same-worker improvement is claimed.

```text
bookshelf_consulted: true
source_domain: classical elongated-body reactive propulsion and closed-loop robotic-fish CPG control
source_mechanism: sustain an anterior-driven traveling bend with posterior lag, and keep route feedback subordinate to the rhythmic carrier
transferable_invariant: preserve phase-balanced energy about the moving anterior equilibrium and a lagged posterior wave instead of allowing corrective residuals to replace the traveling rhythm with a static C-bend
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body joint counts, clocked phase, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target and velocity retain the evaluated course/geometry gates; measured joint position and velocity sustain the symmetric anterior carrier; the posterior target remains a bounded lagged function of anterior state
falsification: reject if the active coherent return is not recovered, either joint parks or saturates, closest approach and near-target residence do not return to the 1.175L reference, or wake/load margins worsen
```

## Evaluation boundary

The candidate intentionally removes unevidenced additions and restores a
previously completed policy. Deterministic checks can establish exact source
identity, schema ownership, finite bounded action, reflection equivariance,
and editable-boundary compliance; only the later CFD evaluation can establish
whether the active trajectory reproduces in this materialized child.

## Implemented candidate and non-CFD checks

The solver now matches the completed phase-balanced reference byte for byte:
both files are `11257` bytes with SHA-256
`2d24e7eaf41db9d22802471d12b03033c833b7fd9f80ce0979ee51eaecb27712`.
Relative to the prefill, it removes the equilibrium-unbend completion/quiet
gate and restores the four owned phase-balanced-energy parameters and the
symmetric velocity-odd anterior term. It adds no time, step count, mutable
state, world coordinate, target identity, route, random input, or file access.

After removing a duplicated copied-parent marker in the rendered workspace
`README.md` that initially prevented unique parent selection, the mandated
checker passed its material-guidance comparison, lightweight Julia contract,
deterministic parameter-schema guard, and solver editable-boundary check. The
contract probe returned a finite two-element `phi_ddot`, and exact source
identity passed. No formal CFD was run.
