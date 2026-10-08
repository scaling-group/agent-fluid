# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertial moving-window
  transport. All capture, so the useful comparisons are route integral,
  arrival, load/actuator exposure, and trajectory topology rather than
  termination alone.
- Both rows of all four combined keyframe sheets were inspected from release
  through capture. The top-down views show genuine self-propulsion and a
  regular alternating wake followed by the same coarse upward target hook.
  The oblique Lambda2 rows retain a compact coherent three-dimensional wake.
  No sample shows passive advection, wake breakup, boundary interaction,
  instability, or a moving-window rotation artifact. Visual similarity was
  therefore cross-checked against the trajectories and diagnostics rather
  than interpreted as equivalence by itself.
- Removing upstream posterior course-slip allocation gives the weakest sample:
  `solver_8e7135ef9173` captures at `26.2460T`, has mean distance
  `2.518971L`, and scores `-0.616147`. The posterior-vectoring sample
  `solver_fb7bddf12f80` improves the `8/16/24T` distances to
  `10.4512/6.1888/1.8102L`, lowers mean distance to `2.509866L`, and captures
  at `26.1635T`. Its peak planar force/yaw moment rises only modestly from
  `0.018834/0.009789` to `0.019441/0.009868`, with no angle, rate, or action
  contacts. This is evidence for upstream posterior allocation, not for more
  amplitude or terminal correction.
- The assigned route-priority parent (`solver_93fdf80136b2`) is almost
  indistinguishable from that vectoring sample through `16T`; it captures
  `0.0440T` earlier with essentially identical mean distance
  (`2.509863L`) and the same `0.019441/0.009868` load envelope. Its two visual
  rows retain the same route family, so late conflict arbitration is not a
  semantic improvement to extend by thresholds or scalar authority.
- Force-commutating the posterior vectoring (`solver_3065fba218c6`) captures
  fastest at `26.0920T` and lowers peak planar force to `0.018828`, but worsens
  mean distance to `2.512198L` and score to `-0.609997`; its `8/16/24T`
  distances are also worse than the assigned parent. It produces no distinct
  useful visual route. Together with the inherited negative anterior-force
  results, this rejects instantaneous force as the next phase selector despite
  same-trace correlation.
- Reconstructing the assigned-parent course-slip branch shows material
  activation from roughly `0.94T` to `20.93T`. Its posterior correction is a
  same-sign mean acceleration over both beat halves, averaging about
  `1.34 rad/T^2` when active and peaking near `3.07 rad/T^2`. The route benefit
  therefore leaves a controlled question that the sampled policies did not
  test: whether the same bounded mean steering is more effective when assigned
  to the calibrated course-correcting half-cycle instead of spread across the
  full posterior beat.

## Policy hypothesis

Preserve the assigned parent's target-aware traveling bend, redirect,
line-of-sight response, late route-priority arbitration, capture modulation,
coordinated acceleration projection, and angle/rate viability guards. Replace
only the upstream posterior course-slip waveform: retain its body-frame
course-versus-bearing deficit, closing/speed/distance gates, steering side,
and sampled mean authority, but apply the posterior correction on the already
calibrated course-correcting anterior joint-state half-cycle. The half-cycle
coefficient is calibrated against the assigned trace rather than copied from a
source; this is a duty-ratio redistribution rather than a scalar authority
increase.

The falsifiable expectation is to retain capture, zero actuator contacts, and
the coherent three-dimensional wake while improving upstream distance or
arrival without exceeding the assigned parent's `0.019441/0.009868` planar
force/yaw-moment envelope. Reject the mechanism if it loses the upstream
separation, returns to the `2.519L` mean-distance family, produces the earlier
high-load posterior-asymmetry topology, loses capture, or merely perturbs the
shallow terminal crossing.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and elongated-body reactive propulsion
source_mechanism: bounded half-cycle amplitude or duty-ratio asymmetry applied while retaining a posterior traveling-wave thrust carrier
transferable_invariant: a required mean turn can be produced by concentrating bounded posterior authority on the useful beat half instead of adding equal correction throughout the cycle
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species envelopes, clock phase, exact vortex phase, and prescribed routes
policy_translation: infer beat half from anterior joint velocity; let normalized body-frame course-versus-bearing deficit choose the gated steering side, and replace the full-cycle posterior course-slip correction with a sampled-mean-matched half-cycle acceleration
falsification: reject on lost capture or upstream progress, wake incoherence, any actuator contact, force or yaw moment above the sampled vectoring envelope, or recurrence of the high-load posterior-asymmetry trajectory

## Non-CFD implementation audit after the policy edit

- The `3.4 rad/T^2` duty coefficient was calibrated only to preserve the
  assigned trace's mean course correction while changing its phase
  distribution. Over rows where either branch exceeds `0.01 rad/T^2`, the old
  full-cycle correction has signed/absolute means of
  `-0.9297/1.3403 rad/T^2` and peaks at `3.0732`; the candidate half-cycle
  correction has corresponding means of `-0.9255/1.3477` and a lower sampled
  peak of `2.7708`. This is a frozen-state isolation check, not CFD evidence.
- Reconstructing policy observations from all `4,749` assigned-parent rows
  changes `1,807` post-guard command pairs, including `1,022` by more than
  `0.05 rad/T^2`. Activation spans approximately `0.011--21.769T` and
  `12.340--3.0025L`; the candidate is unchanged inside the inherited `3L`
  late corridor. Maximum command separation is `1.1745 rad/T^2`, while the
  candidate's sampled command peak remains `29.7244 rad/T^2`.
- Every direct `params.FIELD` reference is owned by the returned 50-field
  parameter object. A deterministic `486,000`-state joint/geometry/response
  grid produces finite commands bounded by `30 rad/T^2` and zero numerical
  reflection error. The public Julia contract, guidance semantic delta, and
  solver editable-boundary checks pass.
- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its exact three non-CFD checks were run
  directly instead. No formal CFD was run.
