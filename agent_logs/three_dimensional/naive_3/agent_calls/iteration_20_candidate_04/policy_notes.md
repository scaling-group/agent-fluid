# Continuous posterior viability-barrier candidate

## Evidence and visual diagnosis

- All four sampled evaluations report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. All capture
  at about `18.27T`. Their top-down rows show the same regular alternating
  vorticity street through approach, and their oblique rows retain compact
  three-dimensional Lambda2 structures at `12T`, `16T`, and capture. The
  motion is self-propelled: every trace reaches about `1.329U`, whereas peak
  local flow is only `0.0315U`. Preserve the target-ray/velocity-course
  observation, zero-centered anterior oscillator, posterior lag, and terminal
  acceleration allocation.
- The highest scalar score belongs to the fixed-width guard
  (`-0.247735`), but it is the informative mechanical failure: the posterior
  joint still reaches exactly `-45 deg`, its outward velocity is reset at the
  stop, and coincident force/yaw-moment peaks reach `0.17183/0.07699`. The
  unguarded captured reference is worse at `0.20756/0.09276`. The visual sheets
  do not resolve this single-step collision, so the aligned joint and load
  traces, rather than scalar rank, decide the protection mechanism.
- Both sampled velocity-conditioned barriers preserve capture and eliminate
  angle contact. The assigned binary viability brake bottoms at `-42.78 deg`
  and the continuous stopping-risk brake at `-43.00 deg`; each reduces whole-
  trace peak force/moment to `0.03716/0.01907`. This is a completed semantic
  improvement over the inherited fixed-width-brake lesson, not merely another
  near-identical score.
- The remaining useful contrast is command allocation. The binary brake first
  diverges from the unguarded trace near `18.150T`, `0.792L`, and then holds
  maximum inward acceleration until posterior velocity reverses. Its applied
  posterior acceleration-limit occupancy is `46.86%`. The continuous sibling
  starts near `18.133T`, `0.798L`, tapers the admissible outward command with
  stopping risk, avoids contact with the same load ceiling, and has lower
  occupancy (`46.40%`) plus a slightly better score (`-0.248270` versus
  `-0.248277`). That supports smoothing the constraint, not changing carrier
  gains, curvature, or the target route.

## Policy hypothesis written before the solver edit

Preserve the captured controller through construction of its allocated
posterior command. Replace only the assigned parent's Boolean maximum-braking
switch with a continuous stopping-risk projection. Use posterior velocity to
select the approached boundary, compare its kinetic stopping distance with the
remaining angular margin, and smoothly lower the admissible acceleration in
that direction as risk crosses an evidence-separated onset. Apply this mechanical
constraint whenever the normalized joint state requires it, independently of
target distance; the current rollout remains unchanged outside its isolated
terminal risk interval, while a held-out trajectory cannot disable joint
protection merely by being farther from the target.

Static replay before finalization showed why the sampled continuous barrier's
`0.50` onset could not simply be detached from its distance gate: its risk
metric exceeds `0.50` in 108 samples above `3L`, with a maximum near `0.506`,
so that translation would perturb the broad carrier. A `0.60` onset is above
that observed nonterminal band and first crosses on the unsafe terminal stroke
near `18.095T`, `0.811L`, `-29.3 deg`, and `-174 deg/T`. The candidate therefore
tests a globally valid constraint without conflating ordinary high-speed
carrier motion with proximity to a joint stop. This numeric separation comes
from the current rollout states, not from the bookshelf sources.

The expected signature is the evidenced broad route and alternating 3D wake,
capture near `18.28T`, no `45 deg` posterior contact, peak force/moment no worse
than `0.0372/0.0191`, and less acceleration-limit occupancy than the assigned
binary brake. Falsify the mechanism if it loses capture or the sub-`1L`
trajectory, changes the broad carrier before joint risk appears, contacts an
angle limit, exceeds the velocity-barrier load peaks, or does not reduce the
binary brake's limit occupancy.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture control
source_mechanism: sensor feedback continuously modulates a productive rhythmic carrier only when an observed terminal constraint requires correction
transferable_invariant: preserve the propulsive rhythm and project only dynamically unsafe joint motion back toward a bounded viable set, releasing the correction as measured risk clears
nontransferable_details: published gains, linkage geometry, species-specific kinematics, dimensional cadence, clock phase, exact vortex phase, source actuator ratings, and task-specific routes
policy_translation: retain normalized target_body_L versus velocity_body_U course feedback and the two-joint carrier; form posterior stopping risk from normalized joint angle, joint velocity, and the owned acceleration envelope, then continuously cap acceleration toward the approached boundary without using target distance as the safety gate
falsification: reject if capture or coherent shedding is lost, broad-route commands change without joint risk, posterior contact returns, terminal force or moment exceeds the sampled velocity-barrier ceiling, or acceleration-limit occupancy does not improve over the binary brake
```
