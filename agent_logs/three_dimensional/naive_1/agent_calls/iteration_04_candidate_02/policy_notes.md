# Candidate diagnosis and hypothesis

## Evidence read before editing

All sampled diagnostics report `uniform_direct` initialization, still water
`U_infinity=(0,0,0)`, no cylinders, and the validated moving window.  I read
the combined top-down vorticity and oblique Lambda2 sheets for the capture,
the `1.0927L` near miss, and the prefilled posterior-only failure, then checked
their trajectories and controller source.

- The sampled response-gated differential-curvature controller is the only
  semantic success: it carries a coherent alternating top-down street and
  compact three-dimensional caudal structures all the way to capture at
  `19.228T` and `0.7482L`.  Its heading stays in `[-0.056, 0.803] rad`, no
  joint-angle samples reach the hard limit, and the route progresses from
  `12.3277L` without a late departure.
- The ungated differential-curvature controller has equally strong visible
  propulsion and reaches `1.0927L` at `19.058T`, but it passes the target,
  curls away, and exits the lower margin at `32.071T` with `9.5549L` final
  distance.  Persistent geometry authority without measured-response release
  therefore has useful reach but insufficient approach regulation.
- The prefilled posterior-only controller forms a wake but hooks upward after
  only `0.6256L` best progress and exits at `9.576T`.  Its smooth acceleration
  envelope cannot rescue the missing anterior/posterior steering allocation;
  changing only the posterior bend would confound steering structure with
  another scalar or limiter edit.
- The differential turn-rate servo reaches `4.9765L` but exits high after its
  beat-scale yaw signal repeatedly reverses the route request.  Target geometry
  must own turn sign; measured yaw is suitable only for bounded one-sided
  release at this observation bandwidth.
- The successful controller still touches the joint-rate limit on `25.7%` of
  rows and its raw acceleration request exceeds the envelope on `94.4%` of
  rows (with no angle saturation).  Capture is strong semantic evidence for
  the steering mechanism, not evidence that its effort is efficient.  This
  candidate isolates that proven architecture; later evidence should test an
  actuation-aware carrier change separately rather than silently mixing it
  into the steering comparison.

## Policy hypothesis

Use normalized body-frame lateral target fraction to set a bounded, persistent
route sign.  Apply it as opposite-sign mean offsets at both joints so the
anterior joint supplies prompt yaw while the larger posterior offset retains
the traveling bend.  Correctly signed recent yaw may release at most a bounded
fraction of this offset; it may not reverse it.  Preserve the seed oscillator
and posterior lag unchanged.  The prior capture is direct evidence that this
small mechanism combination can complete the assigned task; the new rollout
must still falsify it if it loses capture, wake coherence, or acceptable load
history.  No claim is made here about the unevaluated candidate result.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG steering and mean-curvature turning
source_mechanism: sensor-modulated rhythmic carrier with bounded average bend
transferable_invariant: persistent target error sets bend sign while measured correcting response can continuously release, but not invert, steering authority
nontransferable_details: published CPG gains, dimensional beat rates, robot geometry, species kinematics, exact vortex phase, and task-specific routes
policy_translation: normalize body-frame lateral target displacement by distance, bound it with tanh, distribute one request as opposite anterior/posterior mean curvature, and use recent body turn rate only for bounded one-sided release
falsification: reject if turn sign is wrong, capture is lost, the coherent traveling wake collapses, boundary-exit topology returns, or saturation and loads make the success fragile
