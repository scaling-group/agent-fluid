# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled rollouts are finite captures from direct uniform still water
with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. Three
policies reproduce the progress-qualified carrier bit-for-bit: capture at
`23.37501T`, score `-0.50515772`, scoring mean/final distance
`2.402131/0.748882L`, and `235` moving-window shifts. The fourth is the
informative weaker capture. It fades the extra progress cadence solely by
distance between `4L` and `3L`, reaches `3L` at the same `20.129997T`, but
then captures at `23.45752T` with worse score and mean distance
`-0.50554000/2.402686L`.

I inspected the combined keyframe sheets of the replicated progress carrier
and the distance-fade comparison from release through termination. In both the
top-down mid-plane-vorticity rows and oblique body/Lambda2 rows, the fish
self-propels from quiescence on the same smooth target-directed arc and sheds a
coherent alternating three-dimensional wake. There is no passive advection,
wake collapse, collision, domain exit, or numerical instability. The fade's
small difference is below keyframe resolution, so its trajectory and load
histories determine the comparison.

The distance fade confirms that withdrawing the reserve can reduce terminal
rotation and load, but rejects unconditional proximity as the handoff cue.
Inside `3L`, it reduces mean/peak absolute yaw from `1.71255/3.29199` to
`1.67618/3.22576 rad/T` and mean/peak absolute moment from
`0.006591/0.014507` to `0.006348/0.013529`, yet delays capture by `0.08250T`,
worsens scoring mean distance by `0.000555L`, and increases peak target-line
cross-track speed from `0.61953U` to `0.62705U`. Thus lower yaw/load alone did
not improve the terminal approach, and another distance threshold or scalar
fade retune would repeat the same trade rather than test a new controller
mechanism.

## Single candidate hypothesis

Start from the assigned progress-qualified split-observer policy. Preserve its
target-radial propulsion qualification, response-released C-bend, continuous
anterior course response, distributed phase classification, posterior
traveling wave, steering gains, and smooth component-wise command projection.
Replace the failed distance-only handoff with one demand-coupled authority
handoff: multiply only the small progress-cadence reserve by the complement of
the absolute existing terminal course-brake command. That command is already
bounded and requires proximity, motion, carrier-rejected excess yaw, and
target-line cross-track response. The baseline cadence remains active, and
aligned terminal translation keeps the reserve rather than coasting merely
because the fish is close.

This should preserve the identical `3L` crossing and most of the full-release
arrival gain while withdrawing extra propulsion specifically during measured
terminal stabilization demand. Falsify it if capture is delayed to the
distance-fade result or beyond, score/mean distance regresses, peak cross-track
speed does not improve over full release, yaw/moment do not remain below the
full-release values, wake coherence changes, or actuator feasibility worsens.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal approach control
source_mechanism: sensory arbitration between an established traveling-wave propulsion carrier and measured near-target stabilization demand
transferable_invariant: preserve base propulsion while yielding only extra rhythmic authority in proportion to an active bounded course-correction demand
nontransferable_details: published gains, dimensional frequencies and speeds, clocked phase, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: use the complement of the existing normalized body-frame terminal course-brake magnitude to gate only the target-progress cadence reserve; leave baseline cadence, posterior lag, and steering unchanged
falsification: reject if CFD loses the sampled middle-course progress, delays capture to the distance-only fade or worse, fails to improve the full-release cross-track/yaw/load trade, changes the coherent wake, or worsens actuator limits

## Validation plan

Do not run formal CFD in this worker. After materializing the single candidate
and updating durable guidance, invoke the configured check runner, perform its
non-CFD boundary and schema checks, and run a lightweight Julia contract smoke
only if the runtime is available.

## Validation status

The configured check runner was invoked, but its pinned `gpt-5.4-mini` model is
unsupported by this account and failed before workspace inspection. Its three
prescribed non-CFD checks were therefore run directly. The guidance checker
initially found the assigned parent duplicated in the rendered workspace
`README.md`; removing only the duplicate marker repaired the input, and the
rerun passes with a material reusable guidance update. The solver boundary
check passes.

The prescribed Julia contract smoke was invoked but cannot start because no
Julia executable is installed. A deterministic static audit finds exactly one
nonempty canonical candidate, both public functions exactly once, and `70`
unique direct `params.FIELD` references among `72` returned fields with no
undeclared reference; only `version` and `control_period` are metadata. The
policy contains no explicit time/step state, randomness, file I/O, cylinder or
wake-position cue, mutable global state, or memorized route. Candidate SHA-256:
`682c9f06d70bf89ddc0b03cf51e6c1e58f3b44758bb24c1f9c7c714e403abb8a`.
No formal CFD was run.
