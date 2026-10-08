# Axial-response-qualified geometric release

## Completed evidence and visual diagnosis before editing

- All four sampled rollouts are finite captures from direct uniform still water
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot.  The
  weakest sampled v48 capture finishes at `17.52849 T`, score `-0.06531`, and
  total/observed distance integrals `1.95072/1.33364 L`; its readable combined
  sheet shows active self-propulsion on a smooth target-signed arc, with an
  organized alternating wake in both the top-down vorticity and oblique
  Lambda2 rows.
- The prefilled v49 approach-retained partition is a closed-loop improvement
  over v48: it captures at `17.48449 T`, score `-0.06165`, and integrals
  `1.94744/1.33195 L`.  Its maximum speed and any-joint acceleration-limit
  residence are `0.96017 L/T` and `40.17%`, versus `0.97314 L/T` and `42.61%`
  for sampled v48, while both have peak normalized planar force/moment
  `0.03225/0.01609`.  The improvement supports returning target-signed
  posterior curvature on approach without reopening the carrier or base route.
- Completed v50 geometrically qualifies the out-of-band correct-yaw release
  and improves again: capture occurs at `17.41299 T`, score `-0.05952`, and
  total/observed integrals `1.94533/1.32998 L`.  Relative to v49 it gives up
  `0.02493/0.02249 L` at the `6/8 T` checkpoints, then leads by
  `0.01280/0.03641/0.03554/0.03727 L` at `10/12/14/16 T`.  This is a useful
  trajectory change rather than only a deeper terminal sample: arrival is
  `0.07150 T` earlier and both integrals improve.  Maximum speed rises to
  `0.98310 L/T`, any-joint limit residence is nearly unchanged at `40.11%`,
  and peak normalized force/moment remains `0.03225/0.01609`.
- I inspected the v49 and v50 combined sheets and the readable v48 comparator
  from release through capture.  All top-down rows show compact startup
  vorticity developing into a coherent alternating posterior street, with no
  passive advection, reversal, collision, or wake collapse.  The v49 and v50
  oblique rows are black after frame 000, so they are rendering/evidence
  failures and cannot support a comparative 3D-wake claim; only readable v48
  establishes the inherited carrier's organized two-view wake.  The new
  candidate must preserve that carrier and be falsified by complete readable
  two-view evidence.
- The assigned-parent guidance and inherited step 32-34 notes show successive
  semantic improvements rather than three stagnant iterations: distance
  arbitration failed, geometry partitioning produced a useful route,
  approach priority survived CFD, and geometric qualification improved middle
  and terminal closure.  Earlier inherited tests also rule out scalar cadence,
  approach-thrust, and base-route retuning.  I nevertheless consulted the
  bookshelf because the proposed edit uses its posterior-propulsion versus
  steering-allocation invariant.

## One-candidate policy hypothesis

Start from completed v50 and preserve its normalized body-frame sensing,
state-feedback carrier, posterior lag, selective crossflow pose confidence,
base route and redirect steering, launch residuals, carrier-first spillover,
half-cycle steering, approach priority, and componentwise actuator projection.
Change only the geometric confidence on the existing out-of-band correct-yaw
release.  Blend v50's centerline-completion confidence toward one by the
already computed positive-forward-body-speed deficit: while axial launch
response is weak, a correct-sign yaw may release the supplementary posterior
curvature without also requiring small bearing error, preserving posterior
traveling-wave authority; as axial response develops, the deficit vanishes
and the controller becomes exactly v50, requiring yaw response and geometric
completion together.  The blend is bounded and continuous, uses no clock or
world-frame route cue, preserves the inherited release's sign structure, and
introduces no scalar gain.

The next CFD rollout should recover some of v49's `6-8 T` lead while retaining
v50's `10-16 T` and arrival advantages, with the same target-signed arc and no
material increase beyond the sampled `0.98310 L/T`, `40.17%`,
`0.03225/0.01609` speed/saturation/load envelope.  Reject the mechanism if the
weak-response release does not improve early closure, allows target error to
accumulate into a middle-route regression, delays or shallows capture, causes
beat-sensitive switching, loses the coherent readable two-view wake, or
materially increases speed, saturation, force, or moment.  Formal CFD occurs
only after this worker exits.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and sensor-modulated robotic-fish turning
source_mechanism: preserve posterior traveling-wave authority for thrust while supplementary turning curvature is allocated by observed locomotor response
transferable_invariant: when forward body-axis response is still weak, redundant supplementary curvature should yield before established axial propulsion is sacrificed; once propulsion is established, steering release must again require both correct response and geometric completion
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body CPG phase, exact vortex timing, and task-specific routes
policy_translation: blend the existing normalized geometric qualifier toward full correct-yaw release only by the bounded positive-forward-speed deficit, affecting only the phase-even posterior turn-shape residual and leaving carrier, route, redirect, and approach authority unchanged
falsification: reject if early closure does not improve, the v50 middle and terminal lead or capture is lost, switching becomes beat-sensitive, or readable wake, speed, saturation, normalized force, or moment exceeds the sampled successful envelope
```

## Evidence boundary

All rollout outcomes above are completed parent or sampled evidence.  The
axial-response-qualified release is one unevaluated controller hypothesis; no
same-worker CFD result is claimed.

## No-CFD implementation audit

- The sole materialized candidate is
  `dogfish_target_control_v51_axial_response_qualified_geometric_release`.
  All `68` distinct direct `params.FIELD` references resolve among the `70`
  fields returned by `target_policy_params()`.
- A deterministic comparison over `270` endpoint and `405` intermediate
  synthetic states confirms that v51 is action-identical to v49 at zero axial
  response, action-identical to completed v50 once positive forward speed
  reaches the existing launch scale, and continuously bounded between those
  release qualifiers at intermediate response.  Every tested action is finite
  and within the componentwise acceleration envelope.
- The configured check-runner was invoked but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Its three exact checks were run locally
  and separately.  The guidance check first exposed two identical assigned-
  parent markers in the rendered `README.md`; removing the duplicate repaired
  provenance.  The material-guidance check, lightweight Julia contract, and
  editable-boundary check then pass.  No formal CFD was run.
