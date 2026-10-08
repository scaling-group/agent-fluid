# Evaluated response-gated target-ray policy selection

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and capture
  termination. The assigned prefill captures at `16.93205T`, scores
  `-0.20004481`, has mean distance `2.08513085L`, and crosses at
  `0.74389035L`.
- I inspected both the top-down mid-plane row and oblique 3D Lambda2 row of
  the best sampled response-gated capture and the assigned prefill. I also
  inspected both rows of the inherited symmetric target-ray regression. All
  show continuous target-directed translation, a coherent alternating
  red/blue wake, and compact caudal 3D structures through capture. None shows
  passive advection, a held-joint coast, wake collapse, collision, boundary
  exit, or instability. Peak fish speed is `1.39123U` while peak local flow is
  only `0.03270U`, consistent with self-propulsion.
- The two duplicated one-sided target-ray samples reproduce the same policy
  and trajectory and improve narrowly over the prefill to score
  `-0.19999072`, mean distance `2.08508726L`, and crossing distance
  `0.74383789L`. Their broad route, `16.93206T` capture, `0.59921 rad`
  posterior excursion, `258.93/259.20 deg/T` peak joint speeds, and
  `0.03693/0.01835` resultant-force/yaw-moment peaks remain inherited.
- The sampled response-gated half-cycle continuation is the strongest finite
  result: it preserves the same arrival and every reported mechanical maximum
  while improving score, mean distance, and crossing distance again to
  `-0.19997658`, `2.08507586L`, and `0.74382418L`. The inherited replay audit
  attributes its distinction to admitting the one-sided target-ray increment
  only during positive posterior work and adverse measured yaw response.
- The informative symmetric target-ray policy captured slightly sooner at
  `16.92622T`, but regressed materially to `-0.20442999`, `2.08865523L`, and
  `0.74813604L` despite a visually indistinguishable wake and unchanged
  mechanical extrema. Its inherited audit relaxed the established course
  request in 136 of 222 terminal samples. This is evidence against another
  symmetric terminal residual or steering-relief overlay, not evidence for
  more carrier gain.

## Single-candidate policy hypothesis

Materialize the evaluated response-gated sample as the sole candidate. Preserve
the zero-centered anterior oscillator, lagged posterior carrier, full
body-frame velocity-course feedback, posterior acceleration reserve, C1
command envelope, high-onset positive-power speed guards, signed adverse-yaw
work allocation, receiver taper, and posterior stopping-risk projection. Add
only the completed sample's bounded target-ray confirmation: estimate inertial
target-ray rotation from matched-window body turn and bearing rates, project it
onto the established course-request sign, and admit its incremental turn work
only on a positive posterior half-cycle while normalized yaw moment still
opposes that increment.

This is an evidence-backed selection, not a claim about this worker's later CFD
evaluation. Expect capture, the inherited broad route and alternating 3D wake,
sublimit joints, and the sampled distance advantage over the prefill and
ungated confirmation. Falsify the selection if it cannot reproduce capture and
the broad route, activates outside `2.25L`, weakens the base course request,
loses coherent shedding, exceeds the `0.5993 rad` posterior envelope or
`0.0370/0.0184` force/moment bounds, or regresses distance quality without a
new semantic or mechanical benefit.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and asymmetric flapping
source_mechanism: sensor feedback schedules corrective work on a compatible propulsive half-cycle and releases it when measured response agrees
transferable_invariant: preserve the traveling rhythm and add target-signed corrective work only during a joint-state phase that performs useful work and only while the measured body response is adverse
nontransferable_details: published gains, dimensional beat rates, species-specific envelopes, duty ratios, full-body oscillator networks, exact vortex phases, capture radius, and task-specific routes
policy_translation: use normalized body-frame target-ray and velocity-course observations for a bounded agreeing increment, then gate only that increment by posterior joint work sign and normalized yaw moment while leaving the two-joint carrier and viability layers unchanged
falsification: reject if capture, broad-route equivalence, sublimit joints, or alternating three-dimensional shedding is lost, or if score, mean/crossing distance, posterior angle, or force/moment loads regress without a new semantic benefit
```

No formal CFD is run in this worker. The materialized candidate's rollout
becomes evidence only after this worker exits.
