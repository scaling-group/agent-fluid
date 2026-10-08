# Multi-Wake Candidate Diagnosis

## Evidence scope

- The assigned parent is `guidance_examples/optimizer_6a2fe42ff255`, copied
  into the live guidance. Its durable lesson covers the saturated,
  target-blind seed; its inherited worker log proposed the sampled
  `solver_e03b11424785` controller.
- The current solver prefill is sampled `solver_dfe058f97183`. I also compared
  sampled `solver_82b05fa0d389` (the longest finite failure),
  `solver_cd462ea24cb4`, and `solver_e03b11424785`, plus the inherited score
  and policy log for `solver_faf26a1a3edd`.
- The shared prewarm sheet shows the held fish in the upper-right while four
  developed, interacting vortex streets occupy the target corridor. This is
  identical initial-condition evidence for every candidate, not a policy
  result.

## Visual diagnosis and metric cross-check

The target-blind seed visibly self-propels and sheds a strong body wake, but it
turns onto a steep downward path to the target's right, never enters the useful
cylinder-wake region, and exits the lower boundary. Its head displacement
`(-3.545,-13.300)L`, transient `8.615L` minimum versus `12.123L` final
distance, joint velocity/acceleration caps, mean command energy `1496.25`, and
RMS lateral force/moment `21.94/541.70` confirm wasteful over-actuation rather
than sustained approach.

The three slower target-aware sheets have the opposite topology: their fish
poses remain small and their paths bend only slightly before disappearing
through the downstream/right boundary. All terminate after only
`16.27--16.73` released time units, before one shedding cycle, with head
displacement x `+2.18--+2.36L`, no improvement over the initial `12.424L`
minimum distance, and negative progress `-0.148-- -0.158`. Their mean x
velocity is within `0.016--0.023` of mean local-flow x, while mean command
energy is only `0.218--1.513`; thus they are primarily advected and do not
generate enough upstream propulsion to test wake entry or station capture.
All three implementations request positive curvature for positive target
bearing, although the exposed body convention says positive bearing places
the target to the fish's right and requests negative curvature.

The inherited opposite-sign controller `solver_faf26a1a3edd` does not settle
that sign question: its unbounded raw oscillator becomes unstable after
`1.009` released time units, with RMS force/moment about
`94643/1296292` and mean command energy `274.7`. It establishes that a correct
bearing-sign hypothesis must not be coupled to an unbounded joint action.

## One candidate hypothesis

Use one energy-regulated state oscillator between the two observed actuation
extremes: `0.80` period and `22 deg` target amplitude, with energy gain `3.0`
so it develops before downstream advection ends the rollout. Center it on a
negative, smoothly saturated bearing command, with bounded heading-rate
damping, and preserve the lagged opposing posterior oscillation plus a small
same-sign tail steering share. Smoothly cap both accelerations at `20`, below
the episode hard limit, so wake impulses and energy error cannot reproduce the
inherited unbounded instability. Every active value is owned by
`target_policy_params()` and the policy uses only body-frame/task-relative
state.

The hypothesis predicts material negative-x displacement, survival beyond the
`16.7` downstream exits and preferably beyond the seed's `50.1`, bounded
joint action, and sustained reduction of final as well as minimum distance.
It is falsified if the fish again exits downstream with velocity tracking the
local flow (insufficient drive), turns away or exits laterally with growing
bearing (wrong sign/gain), or develops force/moment instability despite the
soft action bound. The new CFD result occurs only after this worker exits, so
no improvement is claimed here.
