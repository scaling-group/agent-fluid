# Candidate diagnosis and hypothesis

## Prior evidence and visual diagnosis

The assigned parent guidance ends with a concrete negative terminal result:
recovering `3%` cadence in the settled intercept-supported glide changed 160 of
226 terminal states but regressed from the v29 center-intercept result
(`-0.52807723`, mean distance `2.42908721 L`, final distance `0.74613529 L`) to
score `-0.52812468`, mean distance `2.42912466 L`, and final distance
`0.74618530 L`. The inherited head-point rate reconstruction likewise changed
118 terminal commands and regressed to `-0.52819594`. Those results rule out
another terminal cadence or predictor stack and identify the outer actuator
locus as the useful independent regime.

All four current sampled solvers contain the same v33 partial-coupled-
saturation policy and reproduce the same successful direct-uniform still-water
rollout exactly: capture at `23.4355164 T`, score `-0.40797361`, mean distance
`2.30503257 L`, final distance `0.74906033 L`, and no instability. This is a
material improvement over the reproduced v29 baseline at `25.1185226 T`, score
`-0.52807723`, and mean distance `2.42908721 L`, although v33's threshold
crossing is slightly looser. The policy comparison isolates the improvement to
an outer-only `12%` blend from independent acceleration clipping toward common-
scale clipping; target-relative guidance and the below-`4 L` terminal controller
are unchanged.

The four combined keyframe sheets are byte-identical. Their top-down row shows
self-propelled progress along a compact target-directed arc, a strong alternating
vorticity train by `4 T`, continued coherent shedding through `20 T`, and a
quiet held-bend glide into the capture circle. Their oblique row shows finite,
localized three-dimensional Lambda2 structures shed behind the moving fish
rather than passive advection, wake collapse, or a domain-exit loop. The
diagnostics confirm `U_infinity=(0,0,0)`, direct uniform initialization, monotone
net progress from `12.32772 L` to capture, no acceleration-cap samples inside
`4 L`, peak body-frame lateral force `0.02647`, and peak yaw moment `0.01520`.
No sampled failure image is available in this workspace, so the inherited
head-rate and cadence regressions provide the informative negative boundary;
they do not support a new visual claim.

The reproduced v33 trajectory still reaches the declared acceleration limit on
`26.7%/33.0%` of all anterior/posterior commands (`35.5%/43.9%` outside `4 L`).
More specifically, joint speed reaches the hard `260 deg/T` rate limit on
228/237 stored anterior/posterior states, and 223/234 of those cap states retain
an acceleration command pointing farther outward. Joint angles remain below
`44 deg`, and the terminal commands remain small. Thus the remaining measured
envelope conflict is outer rate headroom, not terminal tracking, mean curvature,
or capture-point prediction.

## Policy hypothesis

Preserve v33's state-feedback oscillator, posterior lag, target-angle redirect,
partial common-scale acceleration limiter, closure preview, shared terminal
mean bend, helpful-crossflow and settled-response gates, center-velocity
intercept corridor, and paired terminal release. Add one outer-only rate-
headroom mechanism after the proven acceleration limiter: normalize each
observed joint rate by the declared physical rate envelope, smoothly detect a
near-limit joint whose bounded acceleration points farther outward, and apply a
small common attenuation to both carrier accelerations. Common attenuation
preserves the already successful anterior/posterior command direction; the
normalized distance gate makes it exactly dormant at and below `4 L`.

This is a joint-state actuator-envelope mechanism, not scalar-only tuning. It
adds no time, route, target identity, world coordinate, force cancellation,
rate reconstruction, cadence change, mean-bend change, beat-side steering, or
joint-role split. Stored-state audit must show finite bounded commands, smooth
activation near rate exhaustion, modest authority loss, and exact terminal
noninterference. Later CFD should reduce hard rate-stop contact without losing
v33's faster capture or coherent wake. Falsify it if it changes any command at
or below `4 L`, causes material outer command loss, delays or loses capture,
worsens mean distance, changes the compact path, weakens either wake view,
increases joint-stop dwell or peak loads, or becomes unstable.

bookshelf_consulted: true
source_domain: classical traveling-wave and elongated-body swimming together with sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: maintain an anterior-to-posterior traveling-bend relationship while sensor feedback keeps rhythmic actuation inside the available actuator envelope
transferable_invariant: when joint-state feedback detects that one member of a coordinated two-joint rhythm is exhausting rate headroom, bounded common attenuation preserves the requested joint-space direction better than independently flattening or abruptly stopping one joint
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics and actuator envelopes, full-body waves, exact phase lags, vortex phase, capture geometry, and task-specific routes
policy_translation: use normalized observed joint rates and the sign of the bounded carrier acceleration to apply a smooth parameter-owned common attenuation only outside the normalized `4 L` terminal band; retain all body-frame target guidance and terminal allocation unchanged
falsification: reject on terminal-command interference, excessive outer command loss, delayed or lost capture, worse distance integral, changed path or mean bend, renewed rate/angle-stop dwell, load growth, instability, or degradation of the top-down or oblique wake

The new candidate's CFD evaluation occurs only after this worker exits and is
not claimed as evidence here.

## Non-CFD implementation audit

- Applying the new rate-headroom algebra to the reproduced v33 stored trace as
  a proxy activates it on 652 of 4,261 states. It is inactive on every sample
  at or below `4 L`, its common scale remains in `[0.95, 1]`, mean absolute
  command changes are `0.1276/0.1417 rad/T^2`, and the maximum change is
  `1.5272 rad/T^2`. This establishes bounded intervention and terminal
  noninterference on stored states only, not coupled-flow improvement.
- Direct v33/v34 evaluation on 15 deterministic states spanning `0.8--4.0 L`
  gives bit-identical commands. Near-limit outward-rate states beyond `4 L`
  change as intended, inward commands produce zero guard, reflected rate and
  command signs give the same guard, and all outputs remain inside the declared
  acceleration envelope.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account and failed before running a command. Its
  three prescribed checks were then run directly and separately. The guidance
  check first exposed the inherited duplicate parent marker in `README.md`;
  removing only that duplicate marker made the material reusable-update check
  pass. The full finite two-joint Julia contract and solver-boundary check also
  pass. A deterministic schema audit resolves all 83 direct `params.FIELD`
  references to the 84 returned fields; only the version label is not consumed
  by control algebra.
