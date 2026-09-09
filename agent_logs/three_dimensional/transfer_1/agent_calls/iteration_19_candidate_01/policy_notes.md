# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- All four assigned solver examples are direct-uniform, stable still-water
  evaluations with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. They
  also have identical policy SHA-256
  `567de354e2bf646dce0776b20e284aabc896c7816eafff848839efa2937b9dac`:
  they are four repeats of
  `dogfish3d_intercept_guarded_speed_reserve_v1`, not four controller
  alternatives. All four capture at `0.7466--0.7499L` and
  `18.2050--18.6725T`, with scores `-0.15970-- -0.15140`.
- I inspected the combined top-down vorticity and oblique Lambda2 rows for the
  strongest assigned repeat (`solver_6b0e320e2f55`), the latest assigned
  repeat (`solver_6845c208b686`), the inherited yaw-brake capture
  (`solver_856f30352d58`), and the informative half-cycle allocator failure
  (`solver_eabef54fa5c2`). The baseline and yaw-brake sheets show continuous
  self-propulsion, a coherent alternating top-down wake, and compact paired
  three-dimensional structures through capture. The failed allocator also
  retains an active wake after closest pass but curves below the target and
  exits the lower boundary. Thus propulsion, numerical stability, and moving-
  window transport are not the discriminating mechanisms; terminal steering
  realization is.
- The four exact baseline repeats establish a `4/4` capture reference despite
  terminal-path variability. Returned accelerations clamp on
  `68.48--68.72%` / `70.64--70.97%` of rows, exact joint-speed-limit residence
  is `10.40--10.63%` / `11.27--11.56%`, peak lateral force coefficient is
  `0.02745--0.02922`, and peak yaw-moment coefficient is
  `0.01570--0.01627`. Their final speed is `0.827--0.908L/T`, so there is no
  evidence for suppressing the carrier or cadence.
- The inherited `dogfish3d_speed_reserve_terminal_yaw_brake_v1` is the only
  available unreplicated architectural child that both preserves this carrier
  and captures: `0.7486L` at `18.3810T`, score `-0.15985`. Its action clipping
  (`68.76%/70.80%`), speed-limit residence (`10.38%/11.46%`), and peak lateral
  force (`0.02874`) remain within the four-repeat baseline ranges; its peak
  yaw moment (`0.01679`) is about three percent above the baseline maximum.
  The first result therefore shows compatibility with capture, not improved
  arrival, score, saturation, loads, or repeatability.
- Sampled optimizer evidence rejects two tempting alternatives: replacing the
  achieved-course terminal error with signed projected miss captured only
  `1/3` exact runs, and half-cycle steering reallocation retained a coherent
  wake but missed at `1.686L`. This candidate does not stack either mechanism.

## One candidate hypothesis

Replay the exact previously evaluated terminal-yaw-brake bytes (expected
SHA-256 `3bc7e932cb0a4d1fc59822ac9c1d16f71c70199c0a5f0f9e36344465bef7c9bd`).
The controller preserves the four-repeat achieved-course/intercept
speed-reserve baseline everywhere, then adds a bounded residual opposing the
joint-compensated yaw estimate only where distance, projected miss, and
target/velocity alignment jointly predict an approaching capture corridor.
The residual shares the existing steering envelope and never attenuates the
traveling-bend carrier.

This is an exact replication experiment, not scalar tuning. A second capture
would promote yaw braking from one-run compatibility toward repeatability;
improved arrival, distance integral, or actuator/load metrics would still be
required before calling it better than the `4/4` baseline. Falsify the
mechanism if the replay exits, weakens either wake view, changes far-field
closure, increases clipping or speed-limit residence materially, exceeds the
observed force/moment envelope, or merely reduces yaw while worsening capture
geometry. The current worker does not claim an unevaluated outcome.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal capture control
source_mechanism: preserve rhythmic propulsion while sensor-derived terminal geometry gates a bounded yaw-damping residual
transferable_invariant: after broad route acquisition, damp excess measured yaw only when normalized interception geometry predicts an approaching capture, without suppressing the propulsive carrier
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, exact beat or vortex phase, duty ratios, and task-specific routes
policy_translation: exactly replay the two-joint achieved-course and speed-reserve controller whose body-frame distance, projected-corridor, and approach-alignment gates bound a residual opposing joint-compensated yaw
falsification: reject if exact replay loses capture, changes far-field closure, weakens the alternating wake, raises load or saturation metrics, or does not improve terminal geometry beyond run-to-run variability

## Non-CFD verification

- The candidate SHA-256 is
  `3bc7e932cb0a4d1fc59822ac9c1d16f71c70199c0a5f0f9e36344465bef7c9bd`,
  exactly matching the previously evaluated one-capture yaw-brake policy.
- The required guidance checker passes after repairing the duplicated identical
  assigned-parent marker in the rendered root `README.md`; it confirms that
  these notes exist, the reusable guidance delta is material, and every direct
  `params.FIELD` reference has a declared parameter.
- The prescribed lightweight policy contract passes under the official Julia
  `1.12.6` runtime: there is no forbidden `L` parameter and the policy returns
  two finite accelerations. The solver editable-boundary check also passes.
- No CFD rollout was run. Wake, capture, score, and load effects remain the
  next evaluation's falsification test.
