# Amplitude-deficit posterior-launch candidate

## Completed evidence and visual diagnosis before editing

- The assigned v38 parent and its duplicate sampled rollout are finite captures
  from direct uniform still water with `U_infinity=(0,0,0)`, no cylinders, and
  no prewarm.  They reproduce capture at `18.23249 T`, score `-0.12650`,
  total/observed distance integrals `2.01298/1.39980 L`, mean/max speed
  `0.7032/0.9519 L/T`, and any-joint acceleration-limit residence `41.54%`.
- The strongest completed sample is v41's response-released posterior launch.
  It captures at `17.91900 T`, score `-0.09321`, and total/observed integrals
  `1.97941/1.36531 L`.  Its distance lead over v38 is
  `0.0227/0.0767/0.0817/0.1045/0.2066/0.3625/0.3726/0.3160 L` at
  `2/4/6/8/10/12/14/16 T`.  The gain is not free effort relief: mean/max speed
  rises to `0.7128/0.9675 L/T`, acceleration-limit residence rises to `43.92%`,
  and peak absolute normalized lateral-force/yaw-moment values change from
  `0.03067/0.01579` to `0.03182/0.01608`.
- I inspected v41 and v38 from release through capture in both required
  view-specific sheets.  Their top-down rows show self-propulsion on a smooth
  target-signed arc: compact startup vorticity develops into a coherent
  alternating posterior street without collision, route reversal, wake
  collapse, or boundary exit.  Both sampled oblique sheets are entirely black,
  as is the inherited load-bridge regression's oblique sheet.  That rendering
  failure forbids a new 3D Lambda2 or depth-structure claim; the policy
  hypothesis is grounded in the top-down motion and completed trajectory/load
  diagnostics.
- The inherited force-confidence and crossflow-dropout bridges are informative
  mechanism regressions.  They retain a similar organized top-down wake but
  capture only at `18.30949/18.25449 T` and worsen total/observed integrals to
  `2.01911/1.40889 L` and `2.01679/1.40574 L` versus v38.  The sampled v39
  response-arbitrated reverse spillover is only a small v38 improvement
  (`18.19399 T`, `2.01039/1.39913 L`) and remains far behind v41.  This rules
  out adding another flow/load cue or stacking extra steering onto the launch
  mechanism.
- V41 changes only the response-defined launch, yet its completed trajectory
  shows zero posterior acceleration-limit residence through `12 T`; its
  posterior carrier-energy proxy grows from about `0.25` in the first half
  beat interval to `0.76` by `1.5-2 T` and about `1.0` after `2.5 T`.  Thus the
  remaining falsifiable opportunity is to distinguish a genuinely
  underdeveloped traveling wave from low body speed, while preserving v41 once
  joint-state wave energy has formed.

## One-candidate policy hypothesis

Start from the completed v41 policy and retain its carrier, target geometry,
crossflow-confidence pose sensing, route feedback, actuator allocation, and
response-released posterior launch.  Add one compact amplitude-envelope
mechanism: form a reflection-even, phase-insensitive posterior carrier-energy
proxy from the mean-rejected two-joint tail tangent and its normalized tangent
rate.  Only while that observed wave energy is deficient may the existing
low-speed, absent-closing, far-target, low-turn launch gate request a small
additional posterior wave-scale residual.  The residual vanishes continuously
as joint-state wave energy builds; it cannot alter route/redirect mean
curvature, select a beat side, or act outside the response-defined launch.

The intended signature is a larger first-`2 T` closure than v41's
`0.0969 L`, capture earlier than `17.919 T`, and total/observed integrals below
`1.9794/1.3654 L`, while preserving its top-down alternating wake and keeping
maximum speed, acceleration-limit residence, and normalized force/moment peaks
near the completed `0.968 L/T`, `43.9%`, and `0.03182/0.01608` envelope.  The
new candidate's CFD evaluation occurs only after this worker exits; none of
those outcomes is claimed here.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and closed-loop robotic-fish CPG amplitude modulation
source_mechanism: emphasize posterior traveling-wave motion while the locomotor amplitude state is underdeveloped, then release modulation as observed oscillation and propulsive response establish
transferable_invariant: a two-joint swimmer can govern bounded posterior emphasis with a phase-insensitive observed wave-energy deficit while retaining state-feedback phase and target-derived mean curvature
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body amplitude envelopes, exact vortex phases, and task-specific routes
policy_translation: compute a reflection-even energy proxy from normalized mean-rejected tail tangent and two-joint tangent rate; use only its bounded deficit to add posterior wave scale inside the existing body-frame speed, closing-response, distance, and turn-load launch gate
falsification: reject if first-2T closure does not beat v41, middle or late closure or capture regresses, posterior saturation becomes persistent, the top-down wake decoheres, readable future oblique evidence reveals 3D degradation, or speed and normalized loads materially exceed the completed v41 envelope
```

## Evidence boundary

All outcome numbers and visual claims above come from the assigned parent,
completed sampled solver results, and inherited optimizer logs.  The candidate
below has no same-worker CFD evidence.

## No-CFD implementation audit

- The single candidate SHA-256 is
  `64201a3babfc5a5f10ba9f47e17933688c281ef7791e11495eb0dc1cd1be1488`.
  All `65` distinct direct `params.FIELD` references resolve against the `67`
  fields returned by `target_policy_params()`.
- A synthetic comparison against completed v41 leaves the anterior action
  unchanged, increases only the low-energy posterior action, and recovers the
  v41 action exactly after the wave-energy deficit closes.  The added energy
  proxy is unchanged when its mean-rejected pose and tangent-rate signs are
  jointly reflected.  This is a structural audit, not a closed-loop result.
- The material-guidance check, lightweight Julia contract, and solver boundary
  check pass when run locally and separately.  The required check-runner was
  invoked, but its pinned `gpt-5.4-mini` model is unavailable for this account.
  The rendered README contained the same assigned-parent marker twice; the
  duplicate line was removed so the prescribed material-guidance check could
  identify the parent unambiguously.  No formal CFD was run.
