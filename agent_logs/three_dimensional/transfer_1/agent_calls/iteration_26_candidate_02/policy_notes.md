# Axial-response energy-governed posterior-launch candidate

## Completed evidence and visual diagnosis before editing

- All four sampled evaluations are finite `capture` terminations from direct
  uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
  The assigned v41 parent captures at `17.91900 T`, score `-0.09321`, and
  total/observed distance integrals `1.97941/1.36531 L`; its mean/max speed,
  any-joint acceleration-limit residence, and peak absolute normalized
  lateral-force/yaw-moment values are `0.71285/0.96753 L/T`, `43.92%`, and
  `0.03182/0.01608`.
- The strongest completed sample is the phase-even posterior-energy governor.
  It captures at `17.80900 T`, score `-0.08840`, and total/observed integrals
  `1.97415/1.35824 L`.  Relative to v41 it is closer by
  `0.0055/0.0149/0.0625/0.0234/0.0485 L` at `2/4/8/12/16 T`, lowers maximum
  speed to `0.95902 L/T` and acceleration-limit residence to `42.90%`, and
  raises peak lateral force/yaw moment modestly to `0.03225/0.01657`.
- The axial-response-only sample independently improves v41: capture is
  `17.83100 T`, score `-0.08863`, total/observed integrals are
  `1.97468/1.36003 L`, and acceleration-limit residence is `43.74%`.  It is
  closer than the energy governor by about `0.0071/0.0035 L` at `12/16 T`,
  although the energy governor is better at `2/8 T`, captures `0.022 T`
  earlier, and has the lower total integral and limit residence.  Thus axial
  response and phase-even wave-energy deficit are separately useful
  localizations of the same posterior launch authority, but their combination
  is not yet a closed-loop result.
- The outstroke phase-allocation sample is the informative transient
  regression: it improves v41's integral to `1.97609 L` but remains slightly
  farther away at `2 T`, captures at the same `17.91900 T`, and increases
  acceleration-limit residence to `44.72%`.  This does not support assigning
  more launch authority to a particular observed beat phase.
- I inspected all four combined sheets from release through capture, including
  their top-down vorticity and oblique body/Lambda2 rows.  Every top-down row
  shows self-propelled motion on the same smooth target-signed arc, with a
  compact startup disturbance developing into a coherent alternating wake;
  none shows collision, reversal, wake collapse, or boundary exit.  The
  phase-allocated sheet is the only readable oblique view and confirms
  compact alternating 3D structures shed behind the caudal region through
  capture.  The other three oblique rows are black rendering failures, so no
  comparative 3D wake-structure claim is made from them.
- The inherited optimizer note proposed the energy proxy because v41 had zero
  posterior acceleration-limit residence through `12 T` while its
  reconstructed phase-insensitive posterior energy rose from roughly `0.25`
  in the first half beat to about `1.0` after `2.5 T`.  The completed energy
  result validates that localization and supersedes the note's structural-only
  status.  Its modest load increase and unreadable oblique row remain explicit
  boundaries.

## One-candidate policy hypothesis

Start from the completed v42 phase-even energy governor, preserving its
carrier, steering, target geometry, crossflow-confidence pose sensing,
response release, and actuator allocation.  Change only the launch response
measurement: use nonnegative forward speed along the fish's normalized body
axis instead of total planar speed when releasing posterior wave-scale
emphasis.  Keep positive target closure and phase-insensitive observed
posterior energy as independent release signals.  Lateral sway can then no
longer masquerade as established propulsion, while the energy deficit still
prevents persistent amplification after the two-joint traveling wave forms.
The translation adds no time, route identity, beat-side selection, mean
curvature, or scalar gain change.

The intended signature is capture before `17.809 T` with total/observed
integrals below `1.97415/1.35824 L`, no loss at the `8-16 T` checkpoints, and
the same coherent alternating wake.  Falsify the combination if it merely
reproduces either parent, delays capture, worsens middle/late closure, makes
posterior saturation persistent, increases acceleration-limit residence
materially above `42.90%`, or materially exceeds `0.959 L/T` maximum speed and
the `0.03225/0.01657` normalized lateral-force/yaw-moment envelope.  The new
candidate's CFD evaluation occurs only after this worker exits; none of these
outcomes is claimed here.

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive thrust and sensor-modulated robotic-fish CPG control
source_mechanism: posterior traveling-wave emphasis should yield when observed axial propulsion and locomotor amplitude are established, rather than treating lateral sway as forward response
transferable_invariant: govern bounded posterior emphasis with phase-insensitive joint-state wave energy and normalized body-axis propulsion while preserving target-derived mean curvature
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body amplitude envelopes, exact vortex phases, and task-specific routes
policy_translation: retain the completed posterior-energy deficit and replace its total-speed launch release with nonnegative forward speed from normalized body-frame velocity; keep positive closing response, distance, and turn load as independent gates
falsification: reject if capture or middle/late closure regresses, the alternating wake loses coherence, posterior saturation persists, readable future oblique evidence shows 3D degradation, or speed and normalized loads materially exceed the completed energy-governed envelope
```

## Evidence boundary

All outcome numbers and visual claims above come from the assigned parent,
sampled solver results, and inherited optimizer logs.  The candidate below has
no same-worker CFD evidence.

## No-CFD implementation audit

- The single candidate is
  `dogfish_target_control_v43_axial_energy_governed_posterior_launch`, with
  SHA-256
  `a8b5a0feb0b2fd281af53201514a2f8ed4900431897b8d590f8332af456fb6f6`.
  All `65` distinct direct `params.FIELD` references resolve against the `67`
  fields returned by `target_policy_params()`.
- A synthetic comparison against completed v42 energy governance recovers its
  action exactly when lateral speed is zero.  With identical axial speed and
  added lateral sway, the anterior action remains exact while this candidate
  retains additional bounded posterior authority; changing only the sway sign
  leaves the new axial release gate unchanged.  This is a structural audit,
  not a closed-loop result.
- The material-guidance check, lightweight Julia policy contract, direct
  parameter-schema check, synthetic mechanism audit, and solver boundary
  check pass.  The prescribed check-runner agent was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account, so its three commands
  were run locally and separately.  The rendered README duplicated the same
  assigned-parent marker; removing only the second marker made the prescribed
  material-guidance comparison unambiguous.  No formal CFD was run.
