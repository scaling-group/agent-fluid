# Wake-policy candidate notes

## Evidence and visual diagnosis

The assigned parent ends at the ungated `0.50` opposing-posterior-headroom
controller. Its best recorded approach remained an upper hook and missed by
`2.13L`, with about `+1.78L` head-y drift, RMS force/moment `535/5416`, and
both joint rate and command caps active.

All four current solver samples contain the same executable policy; their file
differences are comments only, and their prewarm sheets, release sheets, and
numeric metrics are byte-for-byte or numerically identical. They therefore
provide one deterministic fixed-snapshot observation rather than four
independent replications. In the common prewarm sheet the held fish sits above
and downstream of four already-developed, interacting vortex streets. In the
released sheet the additive body-frame cross-track request changes the prior
upper hook into a broad but productive diagonal descent: the fish is visibly
self-propelled upstream through the wake field, turns toward the target, and
crosses the green capture circle without collision or instability. The
numeric evidence agrees: target capture occurs at `0.747L` after `88.13`
release units, mean distance is `2.736L`, progress is `0.940`, and head travel
is `(-10.92,-4.44)L`. Mean head velocity is more upstream than mean local flow,
so the displacement is not passive advection. RMS relative crossflow is
`0.289`, while RMS force/moment remain substantial at `445/4597`.

No current sampled solver is an informative visual failure: all four rollout
sheets are the same successful image. The inherited optimizer scores do supply
a conservative failure boundary. Later descendants again left the domain with
roughly `+1.78L` head-y motion; one reached only `1.12L` and another `1.56L`
before exiting, and the latter raised RMS force/moment to `715/6922`. Because
their candidate implementations are not present in this workspace, those
failures cannot support a causal claim about a particular mechanism. They do
show that a near pass or lower effort does not substitute for preserving the
successful negative-y route and first crossing.

The successful sample still reaches the exact `45 deg` posterior angle limit,
both exact `260 deg/time` joint-rate limits, and both `1650 deg/time^2` policy
command limits. The visible target approach is productive rather than a
lateral-oscillation failure, so the candidate must preserve the complete
cross-track/bearing controller rather than retune its gain, scale, phase
headroom, or close-range fade from this single operating point.

## Candidate hypothesis

Preserve the sampled arrival controller exactly through its two raw joint
accelerations. Add one actuator-side mechanism: a smooth joint-rate headroom
brake that begins at `220 deg/time` and reaches zero outward authority at
`255 deg/time`. It suppresses only acceleration whose sign would increase the
current joint-speed magnitude; inward/braking acceleration and every command
below the soft threshold remain unchanged. The final `1650 deg/time^2` command
clamp remains in place.

This isolates the observed rate-cap contact without weakening the body-frame
cross-track request or globally clipping the gait. The falsifiable expectation
for the later CFD evaluation is that the diagonal negative-y route and target
capture survive while exact joint-rate cap contact, command energy, and
force/moment load do not worsen. Reject the mechanism and restore the exact
sampled arrival anchor if capture is lost, head-y travel returns positive, the
closest approach exceeds `0.75L`, or lower rate/effort merely buys a slower or
non-arriving trajectory.
