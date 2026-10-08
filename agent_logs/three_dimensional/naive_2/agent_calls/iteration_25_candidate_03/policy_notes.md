# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled solver examples have the same policy SHA-256, combined-sheet
  SHA-256, score (`-0.11372863446239556`), `16.604496T` capture, and
  `0.743958L` first-crossing distance. They are exact nominal repeats rather
  than distinct mechanisms. Each reports direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no prewarm, no cylinders, and 237
  moving-window shifts.
- In the top-down sheet the fish moves under its own actuation from the
  upper-right release toward the lower-left target. The alternating wake grows
  from weak at `4T` to a coherent, laterally oscillating reverse-street-like
  trail by `8--16T`; there is no background advection. The body follows a
  shallow target-crossing arc without a collision, domain exit, or visible
  wake breakup. The oblique row agrees: paired Lambda2 structures remain
  connected to the oscillating tail through capture rather than appearing as
  detached initialization artifacts.
- The trajectory cross-check supports the visual reading. Speed is only
  `0.080U` at about `2T` and `0.396U` at `4T`, then rises to `0.937U` by `8T`.
  Once inside `6.5L`, radial closure remains `0.885--1.11U` and mean
  target/velocity alignment is about `0.934`, so the completed approach does
  not show a closure-loss problem. Peak planar force/moment are
  `0.037165/0.018356`, while joint-speed and acceleration limits remain active
  constraints. The final `0.743958L` crossing is successful but necessarily
  only just inside the first-crossing radius.
- Assigned-parent guidance and sampled optimizer logs reject static anterior
  centering, closure-aware carrier relief, line-of-sight-rate feedforward,
  phase-transforming target geometry, and unevidenced moment-residual
  rejection. The inherited score-only descendants remain captures but are
  slightly worse (`-0.114037` to `-0.114215`) than the repeated
  `-0.113729` carrier, so their unidentified changes are not a basis for
  copying or tuning.

## Policy hypothesis

Preserve the complete anterior oscillator, phase-demodulated route feedback,
posterior steering, approach schedule, and one-sided actuator guard. Add only
a smooth posterior-carrier launch envelope: when measured body-frame forward
speed is low and raw target bearing is aligned, modestly increase the lagged
posterior traveling-wave component. Release the boost continuously to exactly
zero at an evidence-calibrated cruise-speed threshold. This is a state-derived
low-speed mode, not an elapsed-time startup script, and it cannot create a
fixed world route. It should form the propulsive wake sooner and reduce the
early distance integral while leaving the demonstrated approach trajectory
bit-for-bit structurally unchanged after the speed gate releases.

bookshelf_consulted: true
source_domain: Lighthill reactive tail-thrust models combined with sensor-modulated robotic-fish CPG control
source_mechanism: emphasize posterior traveling-wave kinematics for thrust, with observed locomotor state smoothly modulating the rhythmic command
transferable_invariant: preserve the traveling-wave carrier and add posterior effort only in an observed low-speed, route-compatible regime, then release it continuously at cruise
nontransferable_details: published dimensional frequencies, gains, species envelopes, robot motor models, exact vortex phases, and prescribed startup timing or routes
policy_translation: scale only the lagged posterior carrier by a bounded function of normalized body-frame forward speed and raw target bearing; retain the existing two-joint state-feedback steering and actuator projections
falsification: reject if capture is lost or delayed, the post-release route changes adversely, wake connection degrades, joint contact or near-limit residence increases materially, peak planar force/moment exceeds the parent, or early speed and distance integral do not improve
