# Response-released posterior launch candidate

## Completed evidence and visual diagnosis before editing

- The four sampled solver examples are byte-identical v38 policies and finite
  `capture` rollouts.  They reproduce capture at `18.23249 T`, score
  `-0.12650`, total/observed distance integrals `2.01298/1.39980 L`, mean/max
  speed `0.7032/0.9519 L/T`, any-joint acceleration-limit residence `41.54%`,
  and peak normalized planar force/moment `0.03068/0.01579`.  Diagnostics
  confirm direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
- I inspected the reproduced v38 combined sheet from release through capture,
  including its top-down mid-plane vorticity row and oblique body/Lambda2 row.
  The fish visibly self-propels on a smooth target-signed arc; compact startup
  structures grow into a coherent alternating posterior wake in both views.
  There is no passive advection, collision, wake collapse, domain exit, or
  visible instability.  This supports retaining the carrier, route steering,
  crossflow band-pass pose cue, and componentwise actuator allocation.
- The completed v40 response-gated force extension and raw-crossflow-dropout
  force bridge are the informative mechanism failures.  They still capture,
  but regress arrival to `18.30949/18.25449 T`, total distance integral to
  `2.01911/2.01679 L`, and observed integral to `1.40889/1.40574 L` versus
  v38.  Maximum speed becomes `0.9542/0.9604 L/T`; neither changes the
  `0.03068` peak normalized force.  Their top-down sheets retain the same
  organized wake, while both oblique rows are black and cannot support a 3D
  wake benefit.  Together with the inherited v39 full-route union regression,
  this is evidence against adding lateral-load magnitude to pose confidence,
  even behind response or primary-sensor-dropout gates.
- The remaining visible and measured deficit is launch rather than route
  authority.  V38 closes only about `0.074 L` in the first `2 T`, when mean
  speed is `0.133 L/T`; mean closing then rises from `0.296 L/T` during
  `2-4 T` to `0.736 L/T` during `6-8 T`.  The anterior acceleration reaches
  its limit for `35-47%` of samples from `1-4 T`, but the posterior joint has
  zero acceleration-limit residence through `7 T`.  The inherited
  whole-wave route-rate projection remains a hard boundary: it produced a
  wrong-sign turn, `left_domain` at `8.4755 T`, and roughly tenfold load
  peaks, so no new flow/rate/direct-actuation residual is proposed.

## One-candidate policy hypothesis

Preserve v38 exactly outside a response-defined launch condition.  Add one
small wave-shape mechanism: while normalized body speed is low, positive
closing response is not established, the target remains far, and steering
load is modest, scale only the oscillatory posterior tail target around its
unchanged route/redirect mean.  Joint state remains the phase source.  The
gate releases continuously as speed and measured closure appear, so it is
neither a clocked startup stage nor a fixed route segment.  This uses the
observed posterior headroom to build the traveling wake without transferring
clipped anterior carrier demand or changing mean curvature.

The intended signature is more than `0.074 L` closure by `2 T` and an earlier
capture than `18.2325 T`, while retaining v38-like middle/late checkpoints,
the coherent two-view alternating wake, and the sampled
`0.952 L/T`, `41.6%`, `0.03068`, and `0.01579` speed/saturation/force/moment
envelope.  Formal CFD occurs only after this worker exits; none of those
outcomes is claimed here.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a stable traveling-wave carrier, emphasize posterior wave motion when propulsive response is weak, and release the modulation when the desired response appears
transferable_invariant: a two-joint swimmer can use bounded posterior emphasis to build thrust while keeping phase and route curvature in the established state-feedback carrier
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body amplitude envelopes, exact vortex phase, and task-specific routes
policy_translation: multiply only the zero-mean posterior tail-wave target by a bounded gate formed from normalized body-frame speed, normalized closing response, normalized turn load, and target-distance authority; preserve the existing route and redirect means
falsification: reject if first-2T closure does not improve, middle or late closure or capture regresses, posterior saturation becomes persistent, the alternating wake degrades, or speed, normalized force, or yaw moment materially exceeds the reproduced v38 envelope
```

## Evidence boundary

The v38 and v40 numbers and visual claims above come from completed sampled
CFD, the assigned parent guidance, and inherited optimizer logs.  The new
candidate's result becomes evidence for a later worker.

## No-CFD implementation audit

- On the frozen completed v38 trace, the new response gate has mean values
  `0.554/0.275/0.058/0.0014` over `0-1/1-2/2-3/3-4 T` and is exactly zero
  after `4 T`.  Its maximum posterior wave scale is `1.0971`; the anterior
  action is unchanged, and the maximum projected posterior-action difference
  is `4.353 rad/T^2`.  This is a localization check, not a closed-loop result.
- The single candidate SHA-256 is
  `5befc2299e4455d6d62bd677fe394601b84e486df2b85cebacf063429fbf60db`.
  All `63` direct `params.FIELD` uses resolve against the returned schema, and
  the lightweight Julia contract, material-guidance check, and solver boundary
  check pass.  The required check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account, so its three prescribed
  checks were run locally and separately.  No formal CFD was run.
