# Direction-and-rate-conditioned outer coupling

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts are valid direct-uniform still-water evaluations:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, finite dynamics, and capture.
  The reproduced `v33` outer `12%` common-scale blend is the reference at
  `23.435516 T`, score `-0.40797361`, and mean distance `2.30503257 L`.
- The assigned prefill/parent candidate adds a separate common attenuation when
  an observed joint is near its rate limit and its acceleration points outward.
  It improves capture to `22.891006 T`, score to `-0.37095517`, and mean
  distance to `2.26715504 L`. Its stated headroom interpretation does not
  survive the stored telemetry, however: near-rate samples rise from
  `223/234` anterior/posterior states in `v33` to `234/257`, and every one of
  those samples still has outward acceleration. The result supports normalized
  joint rate as a useful outer response cue, but not a second downstream
  attenuation layer as a demonstrated way to reduce hard-stop contact.
- Distortion-only gating of the entire `12%` coupling is almost neutral and
  slightly slower than `v33` (`23.369514 T`, score `-0.40351798`, mean distance
  `2.30052406 L`). In contrast, retaining the `12%` coupling floor and adding
  at most `6%` only when componentwise clipping rotates the raw two-joint
  command is the clear current best: capture at `21.912008 T`, score
  `-0.32465929`, and mean distance `2.21894719 L`. It reaches `4 L` at
  `16.110 T`, versus `17.028 T` for the assigned parent and `17.627 T` for
  `v33`, while keeping the inherited quiet terminal controller.
- I inspected the complete combined sheets for the best direction-conditioned
  policy, the `v33` baseline, and the assigned parent. In every top-down row,
  motion begins in visibly quiescent fluid, becomes a coherent alternating
  posterior vorticity train, follows a compact target-directed arc, and settles
  into a held-bend glide before capture. The oblique rows show finite localized
  Lambda2 structures shed behind the translating body rather than passive
  advection, wake collapse, a loop, boundary exit, or instability. The best
  policy is visibly farther along at matched `13/17/21 T` sheets and captures
  around `21.91 T`; it does not obtain the gain by destroying the wake.
- Diagnostics agree with the visual comparison. The best policy raises peak
  speed to `0.8778 L/T` from `0.8224 L/T` in `v33`, while peak lateral force and
  yaw moment remain comparable (`0.02679/0.01558` versus
  `0.02647/0.01520`). It has no command clipping inside `4 L`; inside-band
  action maxima fall to `29.13/21.82 rad/T^2`, and inside-band force/moment
  maxima remain `0.01271/0.00713`. Its remaining envelope conflict is strongly
  posterior: acceleration-cap incidence is `25.9%/40.5%`, and rate-stop counts
  are `219/295`, all with outward commands. This makes rate state a plausible
  secondary cue only at the already validated outer coordination locus.
- The inherited optimizer log proposed the best direction-conditioned limiter
  from the traveling-bend invariant and explicitly bounded it outside `4 L`.
  The present samples now supply the missing CFD support for that mechanism.
  The inherited guidance also rejects terminal cadence recovery, reconstructed
  head-rate prediction, force vetoes, beat-side terminal authority, mean-bend
  unloading, and joint-role splits; none is reopened here.

## Policy hypothesis

Use the best sampled direction-conditioned controller as the baseline. Keep
its `12%` outer coupling floor and `6%` clipping-direction increment exactly,
along with every target-relative guidance, oscillator, redirect, and terminal
allocation term. Add one small compatible actuator-envelope cue inside the
same limiter: normalize each observed joint rate by the declared rate limit,
require the corresponding raw acceleration to point outward, and allow at most
another `3%` blend toward common-scale limiting. The existing normalized
distance gate multiplies the full blend, so the mechanism is exactly absent at
and below `4 L`.

This is a state-conditioned coordination mechanism, not a scalar sweep. Unlike
the assigned parent's separate post-limit attenuation, it does not stack a
second transform on the successful command vector; rate exhaustion only
increases how strongly the one limiter preserves the raw anterior/posterior
direction. It is sign-symmetric, bounded, memoryless, and uses joint state plus
body-frame target distance only. The expected test is earlier outer progress
without terminal change or material load growth. Falsify it if it delays or
loses capture, worsens the distance integral, changes any command at or below
`4 L`, produces a less compact path, increases rate/angle-stop dwell or load
peaks materially, destabilizes the rollout, or degrades either wake view.

bookshelf_consulted: true
source_domain: coupled-oscillator robotic-fish control and classical traveling-wave propulsion under bounded actuation
source_mechanism: preserve coordinated anterior-to-posterior bend direction while sensor feedback respects the available joint envelope
transferable_invariant: actuator-envelope feedback should modulate a coordinated rhythmic command as one joint-space object, with stronger common protection only when state shows direction distortion or exhausted outward rate headroom
nontransferable_details: published gains, dimensional cadence, species-specific envelopes and kinematics, full-body waveforms, exact phase lags, vortex phases, capture geometry, and task-specific routes
policy_translation: retain normalized body-frame target feedback and the validated clipping-direction gate, then add normalized observed joint-rate/outward-command support to the same outer common-scale blend while keeping the terminal band algebraically dormant
falsification: reject on terminal-command interference, delayed or lost capture, worse mean distance, less coherent outer motion, increased stop dwell, material force or moment growth, instability, or degraded top-down or oblique wake structure

The new candidate's CFD evaluation occurs only after this worker exits and is
not claimed as evidence here.

## Non-CFD implementation audit

- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable on this account and failed before running a command.
  Its three declared commands were then run directly and separately. The
  guidance check first found an inherited duplicate `copied to guidance/`
  parent marker in the rendered workspace `README.md`; removing only that
  redundant marker allowed the material reusable-update check to pass. The
  finite two-acceleration Julia contract and solver edit-boundary check pass.
- The deterministic schema audit resolves all 85 direct `params.FIELD`
  references to fields in the 86-field object returned by
  `target_policy_params()`; only the `version` label is intentionally unused.
- Direct comparison with the sampled direction-conditioned winner gives
  bit-identical policy commands on five deterministic states spanning
  `0.8--4.0 L`. Limiter-level tests give the same `0.18` blend as that winner
  when rate support is absent, a bounded `0.207778` blend under near-limit
  outward rate, reflection-symmetric output, and no acceleration beyond the
  declared envelope. These establish algebraic terminal noninterference and
  bounded activation, not a same-worker CFD improvement.
