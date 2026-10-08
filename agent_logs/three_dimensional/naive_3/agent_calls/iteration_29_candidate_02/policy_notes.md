# Candidate diagnosis and hypothesis

## Evidence read before the edit

- The assigned parent and duplicate sampled rollout (`solver_9c72bd94b27c`
  and `solver_260633cea095`) capture at `16.9884T`, score `-0.204764`,
  mean distance `2.08931L`, and remain below both joint-speed stops at
  `258.91/259.19 deg/T`. Their peak self-propelled speed is `1.3737U`, while
  local flow peaks at only `0.03134U`; this is active swimming, not advection.
- Both rows of the parent keyframe sheet were inspected from release through
  capture. The top-down row shows a continuous alternating red/blue street
  through the curved approach, and the oblique row shows compact,
  three-dimensional Lambda2 structures convecting behind the body. There is
  no prewarm artifact: all sampled summaries report direct uniform still water
  with `U_infinity=0` and a null prewarm snapshot.
- The mechanically informative comparison is the unguarded soft-envelope
  rollout `solver_bb2a1c7cb2a0`. It captures slightly earlier at `16.9430T`
  and has similar mean distance (`2.08985L`) and coherent wake topology, but
  sits exactly on the two `260 deg/T` speed stops for `3.73/3.54%` of samples.
  The parent removes that defect and improves score, but raises peak force/yaw
  moment from `0.03609/0.01766` to `0.03634/0.01804` and gives up `0.045T`.
- The one-way anterior-to-posterior sample `solver_f3a614b2af9c` retains the
  alternating top-down and compact oblique wake, has zero speed-stop contact,
  and lowers peak force/moment to `0.03585/0.01749`, but captures later at
  `17.0354T`, reaches mean distance `2.09268L`, and scores `-0.207429`.
  Together with the inherited one-way results, this supports preserving the
  bidirectional mechanism while making its discretionary work load-aware; it
  does not support deleting a transfer direction or changing carrier gains.

## Policy hypothesis

The bidirectional parent accepts cross-joint transfer whenever speed,
acceleration, and sign checks expose receiver headroom, even during the largest
measured yaw-load excursions. Add a C1 gate from the absolute normalized
hydrodynamic yaw moment to both transfer magnitudes only. Keep the gate at
identity through ordinary loads and smoothly withdraw discretionary transfer
as the observed moment enters the narrow interval immediately below the
parent's `0.01804` peak. This is a feedback mechanism, not a drive-gain change:
the zero-centered oscillator, posterior traveling-wave target, target-course
steering, soft acceleration envelope, speed guard, and angle barrier are
unchanged.

Expected evidence: retain capture, the alternating 3D wake, zero exact speed
contact, and parent-level mean distance/arrival, while bringing peak force and
yaw moment toward the one-way/unguarded envelope. Reject the mechanism if it
loses capture, returns either speed stop, scores below `-0.204764`, exceeds
`2.0899L` mean distance or `16.9884T` arrival materially, disrupts the wake,
or fails to reduce the `0.03634/0.01804` force/moment envelope. Because this
worker's CFD runs only after exit, these are falsification criteria rather than
claims about the new candidate.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and wake-interaction load feedback
source_mechanism: sensor feedback modulates a bounded residual around an established rhythmic carrier instead of replacing the carrier
transferable_invariant: withdraw discretionary corrective work continuously when a normalized measured load becomes large while preserving the low-load traveling rhythm
nontransferable_details: published gains, species-specific body envelopes, actuator timing, exact vortex phase, and source-task routes
policy_translation: multiply only speed-triggered cross-joint reallocation by a C1 gate of absolute body-frame-normalized yaw moment; leave carrier and target-course steering unchanged
falsification: reject if capture or alternating shedding is lost, speed contact returns, score or route metrics regress beyond the parent, or peak force and yaw moment do not fall below 0.03634 and 0.01804
